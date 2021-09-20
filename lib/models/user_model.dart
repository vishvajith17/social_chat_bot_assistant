class User {
  String uid;
  String username;
  String first_name;
  String last_name;
  String email;
  String birthday;
  String phonenumber;
  String nic;

  User({
    this.uid,
    this.username,
    this.first_name,
    this.last_name,
    this.email,
    this.birthday,
    this.phonenumber,
    this.nic,
  });

  void setUserId(String uid) {
    this.uid = uid;
  }
  String getUserLastName() {
    return this.last_name;
  }
}
