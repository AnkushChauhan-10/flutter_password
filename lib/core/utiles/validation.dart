String? validateName(String? name) {
  if(name == null) return "Empty Field";
  if (name.isEmpty) return "Empty Field";
}

String? validatePhone(String? phone) {
  if(phone == null) return "Empty Field";
  if (phone.isEmpty) return "Empty Field";
}

String? validatePassword(String? password) {
  if(password == null) return "Empty Field";
  if (password.isEmpty) return "Empty Field";
  if (password.length < 6) return "Invalid Password";

}

String? validateConfirmPassword(String? password, String? confirmPassword) {
  if(confirmPassword == null) return "Empty Field";
  if (confirmPassword.isEmpty) return "Empty Field";
  if (confirmPassword.length < 4) return "Invalid Confirm Password";
  if (confirmPassword == password) return null;
  return "Invalid Confirm Password";
}

String? validateEmail(String? email) {
  if(email == null) return "Empty Field";
  if (email.isEmpty) return "Empty Field";
  bool flag = RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
  if(!flag) return "Invalid Email";
}