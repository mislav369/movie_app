import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/domain/model/result.dart';

abstract interface class UserRepository {
  Future<Result<User>> signIn(String email, String password);

  Future<Result<User>> signUp(String email, String password);

  Future<void> signOut();

  User? get currentUser;
}