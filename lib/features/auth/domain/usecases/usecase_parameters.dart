class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}

class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams({required this.name, required this.email, required this.password});
}

class NoParams {} // For use cases that don’t require parameters
