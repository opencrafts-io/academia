class PortalConnection {
  PortalConnection({
    required this.accountId,
    required this.institutionId,
    required this.schoolName,
    required this.portalUri,
  }) {
    if (accountId.trim().isEmpty) {
      throw ArgumentError.value(accountId, 'accountId');
    }
    if (institutionId <= 0) {
      throw ArgumentError.value(institutionId, 'institutionId');
    }
    if (schoolName.trim().isEmpty) {
      throw ArgumentError.value(schoolName, 'schoolName');
    }
    if (portalUri.scheme != 'https' ||
        portalUri.host.isEmpty ||
        portalUri.userInfo.isNotEmpty) {
      throw ArgumentError.value(
        portalUri,
        'portalUri',
        'An HTTPS URL without user information is required.',
      );
    }
  }

  final String accountId;
  final int institutionId;
  final String schoolName;
  final Uri portalUri;

  String get origin =>
      '${portalUri.scheme}://${portalUri.host}${portalUri.hasPort ? ':${portalUri.port}' : ''}';
}
