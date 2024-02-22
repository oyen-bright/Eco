import 'package:emr_005/ecomoto/config/web3/smart_contract_config.dart';
import 'package:web3dart/contracts.dart';

class RentalContract extends SmartContract {
  static RentalContract get instance => _instance;
  static DeployedContract get contract => _instance.deployedContract;
  RentalContract._private(String contactUrl, String name)
      : super(contactUrl: contactUrl, contractName: name);
  static final RentalContract _instance = RentalContract._private(
      SmartContract.rentalContractData.url,
      SmartContract.rentalContractData.name);

  static ContractFunction get rentVehicle =>
      contract.function('requestVehicleRental');
  static ContractFunction get verifyDriverLicense =>
      contract.function('validateDriverLicense');

  factory RentalContract() {
    return instance;
  }
}
