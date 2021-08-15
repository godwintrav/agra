class User {
  int id;
  String firstName;
  String lastName;
  String phone;
  String userType;
  String password;
  int user_id;
  User(
      {this.user_id,
      this.firstName,
      this.lastName,
      this.phone,
      this.password,
      this.userType,
      this.id});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      user_id: parsedJson['data']['id'],
      firstName: parsedJson['data']['first_name'],
      lastName: parsedJson['data']['last_name'],
      phone: parsedJson['data']['phone'],
      userType: parsedJson['data']['user_type'],
      password: parsedJson['data']['password'],
      id: parsedJson['data'][parsedJson['data']['user_type']]['id'],
    );
  }
}
