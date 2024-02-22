import 'package:emr_005/ecomoto/config/web3/smart_contract_config.dart';
import 'package:web3dart/contracts.dart';

class VehicleContract extends SmartContract {
  static final VehicleContract _instance = VehicleContract._private(
    SmartContract.vehicleContractData.url,
    SmartContract.vehicleContractData.name,
  );

  static VehicleContract get instance => _instance;
  static String get contractAddress => _instance.getDeployedContractAddress;
  static DeployedContract get contract => _instance.deployedContract;

  static ContractFunction get getListedVehicles =>
      contract.function('vehicles');

  static ContractFunction get listVehicle => contract.function('listVehicle');
  static ContractFunction get setApproval =>
      contract.function('setApprovalForAll');

  static ContractEvent get vehicleListedEvent =>
      contract.event('VehicleListed');
  static ContractEvent get vehicleNFTMintedEvent => contract.event('NFTMinted');

  static const String vehicleListedEventTopic =
      '0x0485b4321bf7ed2f92e37110eee16952129e733d383f40c4d5f3f50c8578df6d';
  static const String vehicleNFTMintedEventTopic =
      '0x0176f203df400d7bd5f1b1c9ef36c16709bf3b5d9fd35f000a6bae32393f66c3';

  VehicleContract._private(String contactUrl, String name)
      : super(contactUrl: contactUrl, contractName: name);

  factory VehicleContract() {
    return instance;
  }
}
