//TODO;refactor all enums to have values

import 'package:emr_005/themes/app_images.dart';

enum UserWalletType {
  walletProvider,
  generatedWallet,
}

enum VehicleListingState {
  uploadImagesVideos,
  createVehicleData,
  updateVehicleData,
  makePayment,
  verifyPayment,
}

enum VehicleRentingState {
  getApproval,
  makePayment,
  verifyPayment,
  createRental,
  createEscrow
}

enum LoadingStatus { loading, initial }

enum StorageAction { add, remove, clear }

enum WalletType {
  metamask("Metamask", AppImages.metaMaskIcon),
  trustWallet("Trust Wallet", AppImages.trustWIcon),
  rainbowWallet("Rainbow Wallet", AppImages.rainbowIcon),
  coinbase("Coinbase", AppImages.coinBaseIcon);

  const WalletType(this.title, this.image);
  final String title;
  final String image;
}

enum Environment {
  development("DEV"),
  production("PROD");

  const Environment(this.value);
  final String value;
}

enum UserOnboardingStatus {
  setKyc,
  setNames,
  verifyDriverLicense,
  verifyEmail;

  String get value {
    return name[0].toUpperCase() + name.substring(1);
  }
}

enum EscrowDepositStatus {
  active,
  reversed,
  settled,
}

enum BarType { error, success, loading, action }

enum RentalStatus {
  accepted,
  ready,
  active,
  completed,
  extended,
  rejected,
  requesting,
  settled,
  booked,
  reserved;

  String get value {
    return name[0].toUpperCase() + name.substring(1);
  }
}

enum UserUserType {
  lessee,
  lessor,
}

enum OrderBy {
  asc,
  desc,
}

enum EIP155Methods {
  personalSign,
  ethSign,
  ethSignTransaction,
  ethSignTypedData,
  ethSendTransaction,
}

enum EIP155Events {
  chainChanged,
  accountsChanged,
}

class AppEnums {
  static UserOnboardingStatus? userOnboardingStatusFromString(String? status) {
    switch (status) {
      case 'SetKyc':
        return UserOnboardingStatus.setKyc;
      case 'SetNames':
        return UserOnboardingStatus.setNames;
      case 'VerifyDriverLicense':
        return UserOnboardingStatus.verifyDriverLicense;
      case 'VerifyEmail':
        return UserOnboardingStatus.verifyEmail;
      default:
        return null;
    }
  }

  static EscrowDepositStatus escrowDepositStatusFromString(String status) {
    switch (status) {
      case 'Active':
        return EscrowDepositStatus.active;
      case 'Reversed':
        return EscrowDepositStatus.reversed;
      case 'Settled':
        return EscrowDepositStatus.settled;
      default:
        throw Exception('Invalid EscrowDepositStatus');
    }
  }

  static RentalStatus? rentalRentalStatusFromString(String status) {
    switch (status) {
      case 'Accepted':
        return RentalStatus.accepted;
      case 'Active':
        return RentalStatus.active;
      case 'Completed':
        return RentalStatus.completed;
      case 'Extended':
        return RentalStatus.extended;
      case 'Rejected':
        return RentalStatus.rejected;
      case 'Requesting':
        return RentalStatus.requesting;
      case 'Settled':
        return RentalStatus.settled;
      default:
        return null;
    }
  }

  static UserUserType userUserTypeFromString(String type) {
    switch (type) {
      case 'Lessee':
        return UserUserType.lessee;
      case 'Lessor':
        return UserUserType.lessor;
      default:
        throw Exception('Invalid UserUserType');
    }
  }
}

enum HttpMethod {
  get("GET"),
  post('POST'),
  put('PUT'),
  delete('DELETE');

  const HttpMethod(this.value);
  final String value;
}

enum HapticFeedbackType {
  light,
  medium,
  heavy,
  selection,
  vibrate,
}
