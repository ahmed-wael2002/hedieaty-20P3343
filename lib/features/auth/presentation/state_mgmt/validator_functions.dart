String? emailValidator(email) {
  if (email == null || email.isEmpty) {
    return "Please enter an email address";
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
      .hasMatch(email)) {
    return "Please enter a valid email address";
  }
  return null;
}

String? passwordValidator(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

String? nameValidator(name){
  if(name == null || name.isEmpty){
    return 'Please enter a username';
  }
  return null;
}