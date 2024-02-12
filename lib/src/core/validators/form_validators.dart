
class FormValidators {
  static String sanitizeData(String inputData){
    return inputData.trim();
  }

  static String? isNullOrEmpty(String? val, {String label = "Field",int minLength=2}){
    if(val==null){
      return "$label is required";
    }else if(val.trim().isEmpty){
      return "$label is required";
    }else if(val.length == 2){
      return "$label requires min. $minLength characters";
    }
    else{
      return null;
    }
  }

  static String? isValidEmail(String? val){
    String? isEmailEmpty = isNullOrEmpty(val, label: "Email");
    if(isEmailEmpty != null){
      return isEmailEmpty;
    }
    bool isEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!);
    return isEmailValid ? null : "Invalid email";
  }

  static String? isValidPassword(String? val) {
    String? isPasswordEmpty = isNullOrEmpty(val, label: "Password");
    if(isPasswordEmpty != null){
      return isPasswordEmpty;
    }
    bool passwordValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val!);
    return passwordValid ? null : "Requires uppercase, lowercase,number and special character";
  }


  static String? isValidPhoneNumber(String? val){
    String? isNumberEmpty = isNullOrEmpty(val,label: "Phone number");
    if(isNumberEmpty != null){
      return isNumberEmpty;
    }
    bool numberValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(val!);
    return numberValid? null : "Invalid number";
  }

}