class UserData {
  String firebaseKey;
  String id;
  List<Map<String, int>> counter;
  String lastName;
  String photoUrl;

  UserData(
      {this.id, this.counter, this.lastName, this.photoUrl, this.firebaseKey});
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['lastname'] = lastName;
    data['photo'] = photoUrl;
    data['counter'] = counter;
    data['id'] = id;
    return data;
  }
}
