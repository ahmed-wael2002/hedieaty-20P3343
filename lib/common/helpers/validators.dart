class FormFieldValidators{
  // The `required` method is a static method that takes a `String?` value as a parameter and returns a `String?` value.
  static String? required(value){
    if(value == null || value.isEmpty){
      return 'This field is required';
    }
    return null;
  }

  // The `email` method is a static method that takes a `String?` value as a parameter and returns a `String?` value.
  static String? email(value){
    if(value == null || value.isEmpty){
      return 'This field is required';
    }
    if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
      return 'Please enter a valid email';
    }
    return null;
  }

  // The `password` method is a static method that takes a `String?` value as a parameter and returns a `String?` value.
  static String? password(value){
    if(value == null || value.isEmpty){
      return 'This field is required';
    }
    if(value.length < 6){
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // The `confirmPassword` method is a static method that takes two `String?` values as parameters and returns a `String?` value.
  static String? confirmPassword(value, password){
    if(value == null || value.isEmpty){
      return 'This field is required';
    }
    if(value != password){
      return 'Passwords do not match';
    }
    return null;
  }

  // The `phone` method is a static method that takes a `String?` value as a parameter and returns a `String?` value.
  static String? phone(value){
    if(value == null || value.isEmpty){
      return 'This field is required';
    }
    if(!RegExp(r'^[0-9]{10}$').hasMatch(value)){
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // The `name` method is a static method that takes a `String?` value as a parameter and returns a `String?` value.
  static String? name(value){
    if(value == null || value.isEmpty){
      return 'This field is required';
    }
    if(value.length < 3){
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  // The `address` method is a static method that takes a `String?` value as a parameter and returns a `String?` value.
  static String? number(value){
    if(value == null || value.isEmpty){
      return 'This field is required';
    }
    if(!RegExp(r'^[0-9]+$').hasMatch(value)){
      return 'Please enter a valid number';
    }
    return null;
  }

  // The `date` method is a static method that takes a `String?` value as a parameter and returns a `String?` value.
  static String? date(value){
    if(value == null || value.isEmpty){
      return 'This field is required';
    }
    if(!RegExp(r'^[0-9]{4}-[0-9]{2}-[0-9]{2}$').hasMatch(value)){
      return 'Please enter a valid date';
    }
    return null;
  }

}