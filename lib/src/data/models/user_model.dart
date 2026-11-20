class UserModel {
  int? id;
  String serverId;
  String username;
  String fullName;
  String companyName;
  String? token;

  UserModel({
    this.id,
    required this.serverId,
    required this.username,
    required this.fullName,
    required this.companyName,
    this.token,
  });
}