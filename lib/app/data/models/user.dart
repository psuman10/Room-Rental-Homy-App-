class UserModel {
  String? uuid;
  String? fullName;
  String? email;
  String? password;
  String? profileURL;

  UserModel({
    this.uuid,
    this.fullName,
    this.email,
    this.profileURL,
    this.password,
  });

  Map<String, dynamic> toJsonForRegister() {
    return {
      "fullName": fullName,
      "email": email,
      "profileURL": profileURL,
    };
  }
}
