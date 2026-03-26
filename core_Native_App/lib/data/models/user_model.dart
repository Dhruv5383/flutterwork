// lib/data/models/user_model.dart

/// Model class representing a User entity.
/// Demonstrates Encapsulation by keeping data private with getters/setters.
class UserModel {
  final int? _id;
  String _firstName;
  String _lastName;
  String _email;
  String _passwordHash;

  UserModel({
    int? id,
    required String firstName,
    required String lastName,
    required String email,
    required String passwordHash,
  })  : _id = id,
        _firstName = firstName,
        _lastName = lastName,
        _email = email,
        _passwordHash = passwordHash;

  // Getters
  int? get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get passwordHash => _passwordHash;
  String get fullName => '$_firstName $_lastName';

  // Setters with basic validation
  set firstName(String value) {
    if (value.trim().isNotEmpty) _firstName = value.trim();
  }

  set lastName(String value) {
    if (value.trim().isNotEmpty) _lastName = value.trim();
  }

  set email(String value) {
    if (value.trim().isNotEmpty) _email = value.trim();
  }

  set passwordHash(String value) {
    if (value.isNotEmpty) _passwordHash = value;
  }

  /// Convert model to Map for database insertion.
  Map<String, dynamic> toMap() {
    return {
      if (_id != null) 'id': _id,
      'firstName': _firstName,
      'lastName': _lastName,
      'email': _email,
      'passwordHash': _passwordHash,
    };
  }

  /// Create a UserModel from a database Map.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      passwordHash: map['passwordHash'] as String,
    );
  }

  /// Create a copy with optional field overrides.
  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? passwordHash,
  }) {
    return UserModel(
      id: id ?? _id,
      firstName: firstName ?? _firstName,
      lastName: lastName ?? _lastName,
      email: email ?? _email,
      passwordHash: passwordHash ?? _passwordHash,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $_id, firstName: $_firstName, lastName: $_lastName, email: $_email)';
  }
}
