class UserProfile {
  final String fullName;
  final String companyName;
  final String email;
  final String phoneNumber;
  final String age;

  UserProfile({
    required this.fullName,
    required this.companyName,
    required this.email,
    required this.phoneNumber,
    required this.age,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'companyName': companyName,
      'email': email,
      'phoneNumber': phoneNumber,
      'age': age,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      fullName: json['fullName'] as String? ?? '',
      companyName: json['companyName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      age: json['age'] as String? ?? '',
    );
  }
}
