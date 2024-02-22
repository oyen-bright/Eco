int convertKilometersToMiles(String kilometers) {
  const double conversionFactor = 0.621371;
  return (double.parse(kilometers.toString()) * conversionFactor).floor();
}
