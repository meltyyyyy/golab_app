class AppRegExp {
  static bool email(String _email) {
    bool email = RegExp(r'[\w\-._]+@[\w\-._]+\.[A-Za-z]+').hasMatch(_email);
    return email;
  }
}