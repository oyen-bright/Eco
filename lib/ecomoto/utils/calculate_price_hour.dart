String calculatePricePerHour(dynamic pricePerDay) {
  num? numericPricePerDay;
  try {
    numericPricePerDay = num.parse(pricePerDay.toString());
  } catch (e) {
    return 'Unavailable';
  }
  int hoursInADay = 24;
  double pricePerHour = numericPricePerDay / hoursInADay;
  return pricePerHour.toStringAsFixed(1);
}
