import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

/// The SmartContract class represents a deployed Ethereum smart contract.
///
/// It provides methods to initialize the contract, access contract information,
/// and retrieve contract data based on the contract's JSON file.
///
/// Usage:
/// - Create an instance of SmartContract with the contract's JSON file URL and name.
/// - Call the init method to initialize the contract with data from the JSON file.
/// - Access contract information using deployedContract and getDeployedContractAddress.
/// - Use getContractData, vehicleContractData, or rentalContractData to retrieve contract data.
///
/// Example:
/// ```dart
/// // Create a SmartContract instance for a vehicle contract
/// final vehicleContract = SmartContract(
///   contactUrl: "assets/smart_contracts/vehicle_collection.json",
///   contractName: "vehicle",
/// );
///
/// // Initialize the vehicle contract
/// await vehicleContract.init();
///
/// // Access deployed contract information
/// final deployedContract = vehicleContract.deployedContract;
/// final contractAddress = vehicleContract.getDeployedContractAddress;
///
/// // Retrieve vehicle contract data
/// final vehicleData = SmartContract.vehicleContractData;
/// print("Vehicle Contract Data: $vehicleData");
/// ```
class SmartContract {
  /// The deployed contract instance.
  late DeployedContract? _contract;

  /// The address of the deployed contract.
  late String? _contractAddress;

  /// The URL or path to the contract's JSON file.
  final String contactUrl;

  /// The name of the contract.
  final String contractName;

  /// Constructor for the SmartContract class.
  ///
  /// [contactUrl]: The URL or path to the contract's JSON file.
  /// [contractName]: The name of the contract.
  SmartContract({
    required this.contactUrl,
    required this.contractName,
  }) {
    _contract = null;
    _contractAddress = null;
  }

  /// Returns the deployed contract.
  ///
  /// Throws an exception if the contract has not been initialized. Call [init] first.
  DeployedContract get deployedContract {
    if (_contract == null) {
      throw Exception('Contract has not been initialized. Call init first.');
    }
    return _contract!;
  }

  /// Returns the address of the deployed contract.
  ///
  /// Throws an exception if the contract has not been initialized. Call [init] first.
  String get getDeployedContractAddress {
    if (_contract == null) {
      throw Exception('Contract has not been initialized. Call init first.');
    }
    return _contractAddress!;
  }

  /// Returns a map containing contract data with the given [url] and [name].
  ///
  /// [url]: The URL or path to the contract's JSON file.
  /// [name]: The name of the contract.
  static ({String url, String name}) getContractData(String url, String name) {
    return (url: url, name: name);
  }

  /// Returns a map containing vehicle contract data.
  static ({String url, String name}) get vehicleContractData => getContractData(
      "assets/smart_contracts/vehicle_collection.json", "vehicle");

  /// Returns a map containing rental contract data.
  static ({String url, String name}) get rentalContractData =>
      getContractData("assets/smart_contracts/rental.json", "rental");

  /// Returns a map containing rental contract data.
  static ({String url, String name}) get erc20ContractData =>
      getContractData("assets/smart_contracts/erc_20.json", "erc20");

  /// Initializes the contract by loading data from [contactUrl].
  ///
  /// Loads contract address and ABI from the specified JSON file.
  Future<void> init() async {
    try {
      final response = await rootBundle.loadString(contactUrl);
      final contractData = jsonDecode(response);
      final contractAddress = contractData['address'];
      final contractABI = contractData['abi'];
      final contractAbi =
          ContractAbi.fromJson(jsonEncode(contractABI), contractName);

      _contract = DeployedContract(
          contractAbi, EthereumAddress.fromHex(contractAddress));
      _contractAddress = contractAddress;

      log("$contractName contract initialized at $_contractAddress",
          name: "Smart Contract");
    } catch (e) {
      print(e);
      throw Exception("An error occurred loading SmartContract");
    }
  }
}
