class Institution {
  final int institutionId;
  final String name;
  final List<String>? webPages;
  final List<String>? domains;
  final String? alphaTwoCode;
  final String? country;
  final String? stateProvince;

  Institution({
    required this.institutionId,
    required this.name,
    required this.webPages,
    required this.domains,
    required this.alphaTwoCode,
    required this.country,
    this.stateProvince,
  });
}
