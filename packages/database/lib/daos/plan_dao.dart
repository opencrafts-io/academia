import 'package:database/app_database_v2.dart';
import 'package:drift/drift.dart';
import 'package:database/tables/tables.dart';

part 'plan_dao.g.dart';

/// Data Access Object for managing plan-related database operations.
///
/// [PlanDao] provides a comprehensive API for querying, inserting, updating,
/// and deleting plan records from the database. All operations are asynchronous
/// and support filtering by various criteria such as visibility, activity status,
/// and unique identifiers.
///
/// Example usage:
/// ```dart
/// final planDao = PlanDao(database);
/// final activePlans = await planDao.getAvailablePlans();
/// final plan = await planDao.getPlanByCode('PREMIUM\_ANNUAL');
/// ```
@DriftAccessor(tables: [Plans])
class PlanDao extends DatabaseAccessor<AppDatabaseV2> with _$PlanDaoMixin {
  PlanDao(super.db);

  /// Retrieves all plans from the database.
  ///
  /// Optionally filters results by the [visible] parameter to return only
  /// visible or hidden plans. If [visible] is null, all plans are returned
  /// regardless of visibility status.
  ///
  /// Parameters:
  ///   - [visible]: Optional filter to retrieve only visible (true) or
  ///     hidden (false) plans. If null, no visibility filter is applied.
  ///
  /// Returns:
  ///   A future that completes with a list of [Plan] objects. Returns an
  ///   empty list if no plans match the criteria.
  ///
  /// Throws:
  ///   May throw database-related exceptions if the query fails.
  Future<List<Plan>> getPlans({bool? visible}) {
    final query = select(plans);

    if (visible != null) {
      query.where((plan) => plan.visible.equals(visible));
    }

    return query.get();
  }

  /// Retrieves a single plan by its unique identifier.
  ///
  /// Performs an exact match on the primary key [id] to retrieve a single
  /// plan record. This operation is optimized for primary key lookups.
  ///
  /// Parameters:
  ///   - [id]: The unique identifier of the plan to retrieve.
  ///
  /// Returns:
  ///   A future that completes with a [Plan] object if found, or null
  ///   if no plan with the given ID exists in the database.
  ///
  /// Throws:
  ///   May throw database-related exceptions if the query fails.
  Future<Plan?> getPlanById(int id) {
    return (select(
      plans,
    )..where((plan) => plan.id.equals(id))).getSingleOrNull();
  }

  /// Retrieves a single plan by its unique code.
  ///
  /// Performs an exact match on the [code] field to retrieve a plan record.
  /// The code field is case-sensitive and typically used as a human-readable
  /// plan identifier (e.g., 'PREMIUM_ANNUAL', 'BASIC_MONTHLY').
  ///
  /// Parameters:
  ///   - [code]: The unique code of the plan to retrieve.
  ///
  /// Returns:
  ///   A future that completes with a [Plan] object if found, or null
  ///   if no plan with the given code exists in the database.
  ///
  /// Throws:
  ///   May throw database-related exceptions if the query fails.
  Future<Plan?> getPlanByCode(String code) {
    return (select(
      plans,
    )..where((plan) => plan.code.equals(code))).getSingleOrNull();
  }

  /// Retrieves all active and visible plans available for purchase.
  ///
  /// Returns plans that satisfy both conditions: [active] is true and
  /// [visible] is true. This is typically used to fetch plans that should
  /// be displayed to end users for selection or purchase.
  ///
  /// Returns:
  ///   A future that completes with a list of available [Plan] objects.
  ///   Returns an empty list if no active and visible plans exist.
  ///
  /// Throws:
  ///   May throw database-related exceptions if the query fails.
  Future<List<Plan>> getAvailablePlans() {
    return (select(plans)..where(
          (plan) => plan.active.equals(true) & plan.visible.equals(true),
        ))
        .get();
  }

  /// Inserts a new plan record into the database.
  ///
  /// Creates a new plan entry using the provided [plan] data. The [plan]
  /// parameter should be a [PlansCompanion] object with all required fields
  /// populated. The database will assign an auto-incremented ID if not
  /// explicitly provided.
  ///
  /// Parameters:
  ///   - [plan]: A [PlansCompanion] object containing the plan data to insert.
  ///
  /// Returns:
  ///   A future that completes with the ID of the newly inserted plan record.
  ///
  /// Throws:
  ///   May throw database-related exceptions if the insert fails (e.g.,
  ///   constraint violations, invalid data).
  Future<int> insertPlan(PlansCompanion plan) {
    return into(plans).insert(plan, onConflict: DoUpdate((p) => plan));
  }

  /// Updates an existing plan record in the database.
  ///
  /// Replaces the entire plan record with the data provided in the [plan]
  /// parameter. The plan must include a valid ID to identify which record
  /// to update. All fields in the existing record will be overwritten with
  /// the values from the [plan] companion object.
  ///
  /// Parameters:
  ///   - [plan]: A [PlansCompanion] object containing the updated plan data.
  ///     Must include a valid ID to identify the target record.
  ///
  /// Returns:
  ///   A future that completes with true if the update was successful,
  ///   or false if no plan with the provided ID exists.
  ///
  /// Throws:
  ///   May throw database-related exceptions if the update fails (e.g.,
  ///   constraint violations, invalid data).
  Future<bool> updatePlan(PlansCompanion plan) {
    return update(plans).replace(plan);
  }

  /// Deletes a plan record from the database by its ID.
  ///
  /// Performs a hard delete of the plan record matching the provided [id].
  /// This operation is permanent and cannot be undone. Consider implementing
  /// soft deletes if plan history needs to be retained.
  ///
  /// Parameters:
  ///   - [id]: The unique identifier of the plan to delete.
  ///
  /// Returns:
  ///   A future that completes with the number of rows deleted. Returns 1
  ///   if a plan was deleted, or 0 if no plan with the given ID existed.
  ///
  /// Throws:
  ///   May throw database-related exceptions if the delete fails (e.g.,
  ///   foreign key constraint violations).
  Future<int> deletePlan(int id) {
    return (delete(plans)..where((plan) => plan.id.equals(id))).go();
  }
}
