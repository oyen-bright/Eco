String routeSubPath(String fullPath, {int levels = 2}) {
  List<String> parts = fullPath.split('/');
  if (parts.length > levels) {
    return parts.sublist(levels).join('/');
  } else {
    return fullPath;
  }
}
