sealed class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {}

class AuthenticationErrorState extends AuthenticationState {
  final String message;

  AuthenticationErrorState(this.message);
}