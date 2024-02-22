int getDifferenceInDays(DateTime startDate, DateTime endDate) {
  Duration difference = endDate.difference(startDate);

  int days = difference.inDays;

  if (days > 0) {
    return days;
  }

  return days + 1;
}
