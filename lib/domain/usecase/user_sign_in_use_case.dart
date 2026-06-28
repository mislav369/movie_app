import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/domain/model/result.dart';
import 'package:movie_app/domain/repository/user_repository.dart';

class UserSignInUseCase {
  final UserRepository _repository;

  UserSignInUseCase(this._repository);

  Future<Result<User>> call(String email, String password) {
    return _repository.signIn(email, password);
  }
}