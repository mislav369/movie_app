import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/domain/model/result.dart';
import 'package:movie_app/domain/repository/user_repository.dart';

class UserSignUpUseCase {
  final UserRepository _repository;

  UserSignUpUseCase(this._repository);

  Future<Result<User>> call(String email, String password) {
    return _repository.signUp(email, password);
  }
}