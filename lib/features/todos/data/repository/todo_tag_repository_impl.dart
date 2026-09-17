import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';

class TodoTagRepositoryImpl implements TodoTagRepository {
  final TodoTagLocalDatasource localDataSource;
  final TodoTagRemoteDatasource remoteDataSource;

  TodoTagRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, TodoTagPage>> getTags({String? url}) async {
    final remoteResult = await remoteDataSource.getTags(url: url);

    return remoteResult.fold(
      (failure) async {
        // Fallback to local cache
        final localResult = await localDataSource.getTags(
          isPendingDeletion: false,
        );
        return localResult.fold(
          (l) => Left(l),
          (r) => Right(TodoTagPage(items: r.map((e) => e.toDomain()).toList())),
        );
      },
      (paginatedDto) async {
        // Eagerly upsert remote data into local cache
        Future.wait(
          paginatedDto.results.map((dto) async {
            if (dto.id == null) return;

            final existing = await localDataSource.getTagByExternalID(dto.id!);
            existing.fold((_) => null, (localModel) async {
              final dataModel = dto.toDataModel(
                localId: localModel?.localId ?? 0,
                isDirty: false,
              );
              if (localModel == null) {
                await localDataSource.createTag(dataModel);
              } else {
                await localDataSource.updateTag(dataModel);
              }
            });
          }),
        );
        final localResult = await localDataSource.getTags(
          isPendingDeletion: false,
        );
        return localResult.fold(
          (l) => Left(l),
          (r) => Right(
            TodoTagPage(
              items: r.map((e) => e.toDomain()).toList(),
              nextUrl: paginatedDto.next,
            ),
          ),
        );
      },
    );
  }

  @override
  Future<Either<Failure, TodoTagEntity>> createTag(TodoTagEntity entity) async {
    // 1. Local-first
    final localResult = await localDataSource.createTag(entity.toDataModel());

    return localResult.fold((failure) => Left(failure), (createdLocal) async {
      // 2. Sync to remote
      final remoteResult = await remoteDataSource.createTag(
        createdLocal.toDto(),
      );

      return remoteResult.fold(
        (_) => Right(createdLocal.toDomain()), // Offline — return local
        (dto) async {
          // 3. Update local with server ID and mark clean
          final synced = dto.toDataModel(
            localId: createdLocal.localId,
            isDirty: false,
          );
          await localDataSource.updateTag(synced);
          return Right(synced.toDomain());
        },
      );
    });
  }

  @override
  Future<Either<Failure, TodoTagEntity>> updateTag(TodoTagEntity entity) async {
    // 1. Local-first
    final localResult = await localDataSource.updateTag(entity.toDataModel());

    return localResult.fold((failure) => Left(failure), (updatedLocal) async {
      // 2. Sync to remote
      final remoteResult = await remoteDataSource.updateTag(
        updatedLocal.toDto(),
      );

      return remoteResult.fold(
        (_) => Right(updatedLocal.toDomain()), // Offline — return local
        (dto) async {
          // 3. Mark clean on success
          final synced = dto.toDataModel(
            localId: updatedLocal.localId,
            isDirty: false,
          );
          await localDataSource.updateTag(synced);
          return Right(synced.toDomain());
        },
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteTag(int tagLocalId) async {
    final localItem = await localDataSource.getTagByID(tagLocalId);

    return localItem.fold((failure) => Left(failure), (item) async {
      if (item == null) return const Right(unit);

      // 1. Soft delete locally
      await localDataSource.softDeleteTag(item);

      // 2. Try remote delete
      final remoteResult = await remoteDataSource.deleteTag(item.id ?? '');

      return remoteResult.fold(
        (_) => const Right(unit), // Offline — sync will retry
        (_) async {
          // 3. Hard delete after remote confirms
          await localDataSource.hardDeleteTag(item.localId);
          return const Right(unit);
        },
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> syncTags() async {
    final dirtyResult = await localDataSource.getTags(isDirty: true);

    return dirtyResult.fold((l) => Left(l), (dirtyItems) async {
      for (final item in dirtyItems) {
        // Case 1: Pending deletion
        if (item.isPendingDeletion) {
          if (item.id != null) await remoteDataSource.deleteTag(item.id!);
          await localDataSource.hardDeleteTag(item.localId);
          continue;
        }

        // Case 2: New or dirty — create or update
        final isNew = item.id == null || item.id!.isEmpty;
        final remoteOp = isNew
            ? await remoteDataSource.createTag(item.toDto())
            : await remoteDataSource.updateTag(item.toDto());

        remoteOp.fold(
          (_) => null, // Failed — will retry on next sync
          (dto) async {
            await localDataSource.updateTag(
              dto.toDataModel(localId: item.localId, isDirty: false),
            );
          },
        );
      }
      return const Right(unit);
    });
  }
}
