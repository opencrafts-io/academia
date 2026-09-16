import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:database/database.dart';
import 'package:injectable/injectable.dart';

/// Local data source for managing plan persistence operations.
///
/// [PlanLocalDatasource] handles all local database operations related to plans,
/// including CRUD operations with proper error handling and type safety using
/// the Either monad pattern. All operations are wrapped in try-catch blocks to
/// ensure database errors are converted to application-level failures.
@injectable
class PlanLocalDatasource {
  final PlanDao _planDao;

  PlanLocalDatasource({required this._planDao});

  Future<Either<Failure, Unit>> cachePlan(PlansCompanion plan) async {
    try {
      await _planDao.upsertPlan(plan);
      return const Right(unit);
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to cache plan',
          error: e,
          stackTrace: stackTrace,
          code: 'PLAN_CACHE_ERROR',
        ),
      );
    }
  }

  /// Retrieves all plans from the local database.
  ///
  /// Fetches all plan records regardless of their visibility or active status.
  /// This operation is useful for administrative purposes or internal operations
  /// that require access to all plans in the system.
  ///
  /// Returns:
  ///   Either a [Failure] if the database operation fails, or a list of
  ///   [Plan] objects. Returns an empty list if no plans exist.
  Future<Either<Failure, List<Plan>>> getAllPlans() async {
    try {
      final plans = await _planDao.getPlans();
      return Right(plans);
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to retrieve all plans',
          error: e,
          stackTrace: stackTrace,
          code: 'PLAN_FETCH_ALL_ERROR',
        ),
      );
    }
  }

  /// Retrieves all visible plans from the local database.
  ///
  /// Fetches only plan records that have visibility enabled. This is typically
  /// used to retrieve plans that should be displayed to end users in the UI.
  ///
  /// Returns:
  ///   Either a [Failure] if the database operation fails, or a list of
  ///   visible [Plan] objects. Returns an empty list if no visible plans exist.
  Future<Either<Failure, List<Plan>>> getVisiblePlans() async {
    try {
      final plans = await _planDao.getPlans(visible: true);
      return Right(plans);
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to retrieve visible plans',
          error: e,
          stackTrace: stackTrace,
          code: 'PLAN_FETCH_VISIBLE_ERROR',
        ),
      );
    }
  }

  /// Retrieves all active and visible plans available for user selection.
  ///
  /// Fetches plan records where both [active] and [visible] are true. This is
  /// the primary operation for retrieving plans that are currently available
  /// for purchase or selection by end users.
  ///
  /// Returns:
  ///   Either a [Failure] if the database operation fails, or a list of
  ///   available [Plan] objects. Returns an empty list if no available
  ///   plans exist.
  Future<Either<Failure, List<Plan>>> getAvailablePlans() async {
    try {
      final plans = await _planDao.getAvailablePlans();
      return Right(plans);
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to retrieve available plans',
          error: e,
          stackTrace: stackTrace,
          code: 'PLAN_FETCH_AVAILABLE_ERROR',
        ),
      );
    }
  }

  /// Retrieves a single plan by its unique identifier.
  ///
  /// Performs a lookup of a plan record using its primary key. This operation
  /// is optimized for exact ID matches and should be used when you need to
  /// fetch a specific plan.
  ///
  /// Parameters:
  ///   - [id]: The unique identifier of the plan to retrieve.
  ///
  /// Returns:
  ///   Either a [Failure] if the database operation fails, or a [Plan] object
  ///   if found. Returns a [CacheFailure] if no plan exists with the given ID.
  Future<Either<Failure, Plan>> getPlanById(int id) async {
    try {
      final plan = await _planDao.getPlanById(id);

      if (plan == null) {
        return Left(
          Failure.cache(
            message: 'Plan with ID $id not found',
            code: 'PLAN_NOT_FOUND',
            metadata: {'plan_id': id},
          ),
        );
      }

      return Right(plan);
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to retrieve plan by ID: $id',
          error: e,
          stackTrace: stackTrace,
          code: 'PLAN_FETCH_BY_ID_ERROR',
          metadata: {'plan_id': id},
        ),
      );
    }
  }

  /// Retrieves a single plan by its unique code.
  ///
  /// Performs a lookup of a plan record using its unique code identifier.
  /// The code is typically a human-readable identifier such as 'PREMIUM_ANNUAL'
  /// or 'BASIC_MONTHLY'. This operation is useful for looking up plans by
  /// user-facing identifiers.
  ///
  /// Parameters:
  ///   - [code]: The unique code of the plan to retrieve.
  ///
  /// Returns:
  ///   Either a [Failure] if the database operation fails, or a [Plan] object
  ///   if found. Returns a [CacheFailure] if no plan exists with the given code.
  Future<Either<Failure, Plan>> getPlanByCode(String code) async {
    try {
      final plan = await _planDao.getPlanByCode(code);

      if (plan == null) {
        return Left(
          Failure.cache(
            message: 'Plan with code "$code" not found',
            code: 'PLAN_NOT_FOUND',
            metadata: {'planCode': code},
          ),
        );
      }

      return Right(plan);
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to retrieve plan by code: $code',
          error: e,
          stackTrace: stackTrace,
          code: 'PLAN_FETCH_BY_CODE_ERROR',
          metadata: {'planCode': code},
        ),
      );
    }
  }

  /// Creates and persists a new plan to the local database.
  ///
  /// Inserts a new plan record with the provided data. The [plan] parameter
  /// should contain all required fields. The database will assign an
  /// auto-incremented ID to the new plan.
  ///
  /// Parameters:
  ///   - [plan]: A [PlansCompanion] object containing the plan data to create.
  ///
  /// Returns:
  ///   Either a [Failure] if the database operation fails, or the [Plan] object
  ///   that was created with its assigned ID. Returns a [ValidationFailure]
  ///   if the provided plan data violates database constraints.
  Future<Either<Failure, Plan>> createPlan(PlansCompanion plan) async {
    try {
      if (plan.code.value.isEmpty) {
        return Left(
          Failure.validation(
            message: 'Plan code cannot be empty',
            code: 'PLAN_CODE_REQUIRED',
          ),
        );
      }

      final planId = await _planDao.insertPlan(plan);
      final createdPlan = await _planDao.getPlanById(planId);

      if (createdPlan == null) {
        return Left(
          Failure.cache(
            message: 'Failed to retrieve created plan with ID: $planId',
            code: 'PLAN_CREATION_VERIFICATION_ERROR',
            metadata: {'plan_id': planId},
          ),
        );
      }

      return Right(createdPlan);
    } catch (e, stackTrace) {
      return Left(
        Failure.unexpected(
          message: 'An unexpected error occurred while creating plan',
          error: e,
          stackTrace: stackTrace,
          code: 'PLAN_CREATION_UNEXPECTED_ERROR',
        ),
      );
    }
  }

  /// Updates an existing plan record in the local database.
  ///
  /// Replaces the plan record with the provided updated data. The [plan]
  /// parameter must include a valid ID to identify which plan to update.
  /// All fields will be overwritten with the provided values.
  ///
  /// Parameters:
  ///   - [plan]: A [PlansCompanion] object containing the updated plan data.
  ///     Must include a valid ID.
  ///
  /// Returns:
  ///   Either a [Failure] if the database operation fails, or the updated
  ///   [Plan] object. Returns a [CacheFailure] if no plan exists with
  ///   the provided ID.
  Future<Either<Failure, Plan>> updatePlan(PlansCompanion plan) async {
    try {
      final success = await _planDao.updatePlan(plan);

      if (!success) {
        return Left(
          Failure.cache(
            message: 'Plan with ID ${plan.id.value} not found',
            code: 'PLAN_NOT_FOUND',
            metadata: {'plan_id': plan.id.value},
          ),
        );
      }

      final updatedPlan = await _planDao.getPlanById(plan.id.value);

      if (updatedPlan == null) {
        return Left(
          Failure.cache(
            message:
                'Failed to retrieve updated plan with ID: ${plan.id.value}',
            code: 'PLAN_UPDATE_VERIFICATION_ERROR',
            metadata: {'plan_id': plan.id.value},
          ),
        );
      }

      return Right(updatedPlan);
    } catch (e, stackTrace) {
      return Left(
        Failure.unexpected(
          message: 'An unexpected error occurred while updating plan',
          error: e,
          stackTrace: stackTrace,
          code: 'PLAN_UPDATE_UNEXPECTED_ERROR',
        ),
      );
    }
  }

  /// Deletes a plan record from the local database.
  ///
  /// Performs a permanent deletion of the plan record with the provided ID.
  /// This operation cannot be undone. Verify that the plan should be deleted
  /// before calling this method, or implement soft deletes if plan history
  /// needs to be retained.
  ///
  /// Parameters:
  ///   - [id]: The unique identifier of the plan to delete.
  ///
  /// Returns:
  ///   Either a [Failure] if the database operation fails, or true if the
  ///   deletion was successful. Returns a [CacheFailure] if no plan
  ///   exists with the given ID.
  Future<Either<Failure, bool>> deletePlan(int id) async {
    try {
      final rowsDeleted = await _planDao.deletePlan(id);

      if (rowsDeleted == 0) {
        return Left(
          Failure.cache(
            message: 'Plan with ID $id not found',
            code: 'PLAN_NOT_FOUND',
            metadata: {'plan_id': id},
          ),
        );
      }

      return const Right(true);
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to delete plan with ID: $id',
          error: e,
          stackTrace: stackTrace,
          code: 'PLAN_DELETION_ERROR',
          metadata: {'plan_id': id},
        ),
      );
    }
  }

  /// Clears all plan records from the local database.
  ///
  /// Performs a bulk deletion of all plan records. This operation is permanent
  /// and cannot be undone. Use with caution, typically only during logout or
  /// data reset scenarios.
  ///
  /// Returns:
  ///   Either a [Failure] if the database operation fails, or the number of
  ///   plan records that were deleted.
  Future<Either<Failure, int>> clearAllPlans() async {
    try {
      final allPlans = await _planDao.getPlans();
      for (final plan in allPlans) {
        await _planDao.deletePlan(plan.id);
      }
      return Right(allPlans.length);
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to clear all plans',
          error: e,
          stackTrace: stackTrace,
          code: 'PLAN_CLEAR_ALL_ERROR',
        ),
      );
    }
  }
}
