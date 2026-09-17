class NotificationIdentity {
  const NotificationIdentity({
    required this.userId,
    required this.email,
    required this.displayName,
    this.phoneNumber,
  });

  final String userId;
  final String email;
  final String displayName;
  final String? phoneNumber;
}
