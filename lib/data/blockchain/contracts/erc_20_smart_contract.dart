import 'package:emr_005/ecomoto/config/web3/smart_contract_config.dart';
import 'package:web3dart/contracts.dart';

class ERC20Contract extends SmartContract {
  static ERC20Contract get instance => _instance;
  static DeployedContract get contract => _instance.deployedContract;
  ERC20Contract._private(String contactUrl, String name)
      : super(contactUrl: contactUrl, contractName: name);
  static final ERC20Contract _instance = ERC20Contract._private(
      SmartContract.erc20ContractData.url,
      SmartContract.erc20ContractData.name);
  static ContractFunction get approval => contract.function('approve');

  factory ERC20Contract() {
    return instance;
  }
}
