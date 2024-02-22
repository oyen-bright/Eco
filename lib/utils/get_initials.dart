String getInitials(String? data) {
  if (data == null) {
    return "";
  }
  if (data.isNotEmpty) {
    final nameParts = data.split(' ');
    if (nameParts.length > 1) {
      return '${nameParts[0][0]}${nameParts[1][0]}';
    } else {
      return nameParts[0][0].toUpperCase();
    }
  } else {
    return '';
  }
}
