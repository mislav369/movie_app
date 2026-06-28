import 'package:movie_app/domain/repository/user_repository.dart';

class UserSignOutUseCase {
  final UserRepository _repository;

  UserSignOutUseCase(this._repository);

  Future<void> call() {
    return _repository.signOut();
  }
}