class User {
  User({required this.contactPerson, required this.loginToken});

  factory User.fromJson(Map<String, dynamic> json) => User(
    contactPerson: ContactPerson.fromJson(json['contactPerson']),
    loginToken: json['loginToken'] ?? '',
  );

  final ContactPerson contactPerson;
  final String loginToken;
}

class ContactPerson {
  ContactPerson({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory ContactPerson.fromJson(Map<String, dynamic> json) => ContactPerson(
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    email: json['email'] ?? '',
  );

  final String firstName;
  final String lastName;
  final String email;
}
