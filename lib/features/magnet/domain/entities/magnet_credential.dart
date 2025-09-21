class MagnetCredential {
  // Verisafe's user ID
  final String userID;

  // The institution's id that the user is part of
  final int institutionID;

  /// The student's username, which can be an admission number or a staff ID.
  final String username;

  /// The student's password.
  final String password;

  const MagnetCredential({
    required this.username,
    required this.password,
    required this.userID,
    required this.institutionID,
  });

  /// Creates a copy of this [MagnetCredential] object with the given
  /// fields replaced with new values.
  MagnetCredential copyWith({String? username, String? password}) {
    return MagnetCredential(
      userID: userID,
      institutionID: institutionID,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
