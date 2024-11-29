class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}

class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;

  RegisterParams({required this.name, required this.email, required this.password, required this.phoneNumber});
}

class NoParams {} // For use cases that don’t require parameters
