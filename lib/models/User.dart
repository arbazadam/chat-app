class User {
  final String imageUrl;
  final String username;
  final String email;
  final String uid;
  final String id;
  final List<User> pendingFriends;
  User({this.username, this.imageUrl, this.email, this.uid, this.id,this.pendingFriends});

  factory User.fromJSON(Map<String, dynamic> userMap, [String id]) {
    return User(
        imageUrl: userMap['imageFile'],
        username: userMap['username'],
        email: userMap['email'],
        pendingFriends: userMap['requests'],
        id: id);
  }
}
