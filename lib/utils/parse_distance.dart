double parseDistance(String distance) {
  double distanceValue = 0.0;

  if (distance.contains('km')) {
    distanceValue =
        double.tryParse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

    distanceValue *= 3280.84;
  } else if (distance.contains('mi')) {
    distanceValue =
        double.tryParse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

    distanceValue *= 5280;
  } else if (distance.contains('m')) {
    distanceValue =
        double.tryParse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

    // Convert the distance value to feet (multiply by 3.28084, since 1 m = 3.28084 ft)
    distanceValue *= 3.28084;
  } else if (distance.contains('ft')) {
    distanceValue =
        double.tryParse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
  }

  print(distance);
  print(distanceValue);

  return distanceValue;
}
