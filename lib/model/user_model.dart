class UserModel {
  late String _username;
  late String _password;
  late String _email;

  UserModel(this._username, this._password, this._email);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'email': _email,
      'username': _username,
      'password': _password,
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    _email = map['email'];
    _username = map['username'];
    _password = map['password'];
  }
}
