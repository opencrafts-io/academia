import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/common/common.dart';
import 'package:dartz/dartz.dart';

class GetChirpUserByIdUsecase extends UseCase<ChirpUser, String> {
  final  ChirpUserRepository chirpUserRepository;


  GetChirpUserByIdUsecase({required this.chirpUserRepository});

  @override 
  Future<Either<Failure, ChirpUser>> call(String userID) async{
    return await chirpUserRepository.getChirpUserByID(userID);
  }
  
}
