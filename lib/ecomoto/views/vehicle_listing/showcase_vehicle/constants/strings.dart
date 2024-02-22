part of '../showcase_vehicle_view.dart';

@immutable
class Strings {
  const Strings._();
  static const String showcaseYourVehicleText =
      'Showcase your vehicle in a Gallery';
  static const String addAttractivePhotosText =
      'Add attractive photos of your car ';
  static const String addAttractivePhotosText2 =
      'Front, back, and side views, along with interior perspectives of both the front and back';
  static const String imageGuidelinesText = 'Image Guide';
  static const String imageGuidelinesButtonText = 'Image Guidelines';
  static const String imageGuidelinesText2 =
      'The front, back, and both side views, as well as the front and back interior views, are compulsory.';
  static const String registeredOwnerText = '';
  static const String addVideoText = 'Video Only';
  static const String addVideoGuidelineText =
      'Capture guests attention with a video that showcases your vehicle.\nPlease choose a video shorter than 1 minute and smaller than 100MB';
  static const String imageGuideText = 'Image Guide';
  static const String imageGuideText1 =
      'The front, back and both side views are compulsory.';
  static const String imageGuideText2 = 'Use landscape format';
  static const String imageGuideText3 = 'Keep the background clear and neutral';
  static const String imageGuideText4 = 'Follow our angle guidelines';
  static const String imageGuideText5 = 'Use only natural daylight';
  static const String okImageGuidelinesText = 'OK';
  static const String chooseImagesText = 'Choose Images or Click New One';
  static const String browseText = 'Browse';

  static const String listingVehicleText = 'Listing Vehicle...';
  static const String vehicleListedSuccess = 'Vehicle Listed Successfully';
  static const String frontImagePrompt = "Front View of the Vehicle";
  static const String backImagePrompt = "Back View of the Vehicle";
  static const String leftImagePrompt = "Left View of the Vehicle";
  static const String rightImagePrompt = "Right View of the Vehicle";
  static const String frontInteriorImagePrompt =
      "Front Interior View of the Vehicle";
  static const String backInteriorImagePrompt =
      "Back Interior View of the Vehicle";

  static const String noVideoPrompt = "Upload a video";
  static const String otherImagesPrompt = "Upload an image";
  static const String selectImagePrompt = "Browse";
  static const String otherImagesHeader =
      "Other vehicle pictures you might have";
  static const String andPictureErrorText =
      "Please add at least 6 pictures of the vehicle you are listing";
  static const String andPictureErrorButtonText = "show Guidelines";
  static const String processingVideoPrompt = 'Processing video';
  static const String videoSizeErrorText =
      'Selected video exceeds the ${AppConstants.maximumVideoFileSizeMB}MB limit.';
}
