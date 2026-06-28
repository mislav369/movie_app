import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/domain/model/result.dart';
import 'package:movie_app/presentation/auth/notifier/state/authentication_state.dart';

class AuthenticationNotifier extends Notifier<AuthenticationState> {
  @override
  AuthenticationState build() {
    return AuthenticationInitialState();
  }

  Future<void> signIn(String email, String password) async {
    state = AuthenticationLoadingState();

    final result = await ref.read(userSignInUseCaseProvider)(email, password);

    switch (result) {
      case Ok():
        state = AuthenticationSuccessState();

      case Error(error: final error):
        state = AuthenticationErrorState(
          error.toString().replaceFirst('Exception: ', ''),
        );
    }
  }

  Future<void> signUp(String email, String password) async {
    state = AuthenticationLoadingState();

    final result = await ref.read(userSignUpUseCaseProvider)(email, password);

    switch (result) {
      case Ok():
        state = AuthenticationSuccessState();
      case Error(error: final error):
        state = AuthenticationErrorState(
          error.toString().replaceFirst('Exception: ', ''),
        );
    }
  }
}