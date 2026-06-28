import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/data/client/firebase_auth_client.dart';
import 'package:movie_app/domain/model/result.dart';
import 'package:movie_app/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuthClient firebaseClient;

  UserRepositoryImpl(this.firebaseClient);

  @override
  Future<Result<User>> signIn(String email, String password) async {
    try {
      final credential = await firebaseClient.signIn(email, password);
      final user = credential.user;

      if (user == null) {
        return Result.error(Exception('User not found.'));
      }

      return Result.ok(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        return Result.error(Exception('Wrong email password combination'));
      }

      if (e.code == 'invalid-email') {
        return Result.error(Exception('Invalid email format.'));
      }

      return Result.error(Exception('Authentication error.'));
    } catch (e) {
      return Result.error(Exception('There was an error.'));
    }
  }

  @override
  Future<Result<User>> signUp(String email, String password) async {
    try {
      final credential = await firebaseClient.signUp(email, password);
      final user = credential.user;

      if (user == null) {
        return Result.error(Exception('Could not create account.'));
      }

      return Result.ok(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Result.error(Exception('Email already in use.'));
      }

      if (e.code == 'weak-password') {
        return Result.error(Exception('Password is too weak.'));
      }

      if (e.code == 'invalid-email') {
        return Result.error(Exception('Invalid email format.'));
      }

      return Result.error(Exception('Could not create account.'));
    } catch (e) {
      return Result.error(Exception('There was an error.'));
    }
  }

  @override
  Future<void> signOut() {
    return firebaseClient.signOut();
  }

  @override
  User? get currentUser => firebaseClient.currentUser;
}