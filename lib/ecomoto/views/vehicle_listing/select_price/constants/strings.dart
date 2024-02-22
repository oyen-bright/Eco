part of '../select_price_view.dart';

@immutable
class Strings {
  const Strings._();
  static const String selectPriceHeaderText = 'How does the pricing work?';
  static const String tipText = 'Set you prices  per day according to demand';
  static const String proceedButtonText = 'Proceed';
  static const String invalidPriceZero =
      "Invalid minimum or maximum price. Price can't be zero.";
  static const String invalidPriceRange =
      "Invalid minimum or maximum price. Minimum price can't be greater than maximum price.";
  static const String maximumLabel = "Maximum";
  static const String minimumPriceDescription =
      "The minimum price you're willing to rent out the vehicle for.";

  static const String minimumLabel = "Minimum";
  static const String maximumPriceDescription =
      "The maximum price you're willing to rent out the vehicle for.";
}
