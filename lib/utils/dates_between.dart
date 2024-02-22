List<DateTime> getDatesBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> dates = [];
  for (DateTime date = startDate;
      date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
      date = date.add(const Duration(days: 1))) {
    dates.add(date);
  }
  return dates;
}
