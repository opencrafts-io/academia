enum PermissionStatus { granted, denied, permanentlyDenied }

extension PermissionStatuses on Iterable<PermissionStatus> {
  PermissionStatus get combined {
    if (any((status) => status == PermissionStatus.permanentlyDenied)) {
      return PermissionStatus.permanentlyDenied;
    }
    if (every((status) => status == PermissionStatus.granted)) {
      return PermissionStatus.granted;
    }
    return PermissionStatus.denied;
  }
}
