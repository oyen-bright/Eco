part of rental_date;

@immutable
class Strings {
  const Strings._();
  static const String appBarTitle = 'Rental Details';
  static const String ourSupportedTokensText = 'Our Supported Tokens';
  static const String tetherText = 'Tether';
  static const String usdCoinText = 'USD Coin';
  static const String daiText = 'DAI';
  static const String binanceText = 'Binance';
  static const String trueUsdText = 'True USD';
  static const String perHourText = '/hour';
  static const String totalPriceText = 'Total Price';
  static const String summaryText = 'Summary';
  static const String extraDriverInsText = 'Extra Driver Insurance';
  static const String noImageAvailableText = 'No image available';
  static const String editButtonText = 'Edit';
  static const String continueButtonText = 'Continue';
  static const String rentalDateTitle = "Rental Date";
  static const String pickUpTimeInput = "PickUp Time";
  static const String pickUpTimeInputHit = "Input Pick Up Time";
  static const String returnTimeInput = "Return Time";
  static const String vehicleNotAvailable =
      "Vehicle is not available for rental on this day. Please choose another date.";
  static const String returnTimeInputHit = "Input Return Time Time";
  static const String validationErrorPrompt =
      'Please fill in all the fields and choose a date or date range for your rental';
  static const String validationReturnTimeErrorPrompt =
      'The return time must be after the pick-up time.';
}
