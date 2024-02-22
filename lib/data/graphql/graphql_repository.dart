import 'dart:developer';

import 'package:emr_005/data/graphql/graphql_client.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/models/vehicle_input_data.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/models/rental_input_data.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../ecobook/models/create_community.dart';
import '../../ecobook/models/post_model.dart';
import '../local_storage/local_storage.dart';

class GraphQLRepository {
  GraphQLRepository._();

  static Future<QueryResult<Object?>> login(String email, String password) {
    const mutation = '''
    mutation Login(\$credentials: Credentials!) {
      login(credentials: \$credentials) {
        accessToken
        email
        id
        roles
        username
      }
    }
  ''';

    final options = MutationOptions(
      document: gql(mutation),
      fetchPolicy: FetchPolicy.networkOnly,
      variables: {
        'credentials': {
          'email': email,
          'password': password,
        }
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> registerUser(
    String? userId,
    String oldPassword,
    String newPassword,
    String username,
    UserOnboardingStatus userOnboardingStatus,
  ) async {
    const mutation = r'''
    mutation registerUser($userId: String!, $oldPassword: String!, $newPassword: String!, $username: String!, $userOnboardingStatus: EnumUserOnboardingStatus!) {
      updateUserNames(
        data: {
          oldPassword: $oldPassword,
          password: $newPassword,
          username: $username
          userOnboardingStatus: $userOnboardingStatus
        }
        where: {
          id: $userId
        }
      ) {
        email
        id
        username
        
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': "Bearer $accessToken",
        'userId': userId,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'username': username,
        'userOnboardingStatus': userOnboardingStatus.value
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> updateUserOnboardingStatus(
    String? userId,
    UserOnboardingStatus userOnboardingStatus,
  ) async {
    const mutation = r'''
    mutation updateUser($userId: String!, $userOnboardingStatus: EnumUserOnboardingStatus!) {
      updateUser(
        data: {
          userOnboardingStatus: $userOnboardingStatus
        }
        where: {
          id: $userId
        }
      ) {
        email
        id
        username
        userOnboardingStatus   
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': "Bearer $accessToken",
        'userId': userId,
        'userOnboardingStatus': userOnboardingStatus.value
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> changePassword(
    String? userId,
    String oldPassword,
    String newPassword,
  ) async {
    const mutation = r'''
    mutation UpdatePassword($userId: String!, $oldPassword: String!, $newPassword: String!) {
      updateUserNames(
        data: {
          oldPassword: $oldPassword,
          password: $newPassword,
        }
        where: {
          id: $userId
        }
      ) {
        email
        id
        username
        
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': "Bearer $accessToken",
        'userId': userId,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> changeEmail(
    String? userId,
    String password,
    String newEmail,
  ) async {
    const mutation = r'''
    mutation UpdatePassword($userId: String!, $password: String!, $newEmail: String!) {
      updateUser(
        data: {
          password: $password,
          email : $newEmail,
        }
        where: {
          id: $userId
        }
      ) {
        email
        id
        username
        
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': "Bearer $accessToken",
        'userId': userId,
        'password': password,
        'newEmail': newEmail,
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> updateGeneralSettings(
    String? userId,
    String username,
    String firstname,
    String lastname,
  ) async {
    const mutation = r'''
    mutation UpdateGeneralSettings($userId: String!, $username: String, $firstName: String, $lastName: String) {
      updateUser(
        data: {
          username: $username
          firstName: $firstName
          lastName: $lastName
          
        }
        where: {
          id: $userId
        }
      ) {
        email
        id
        username
        firstName
        lastName
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': "Bearer $accessToken",
        'userId': userId,
        'username': username,
        'firstName': firstname,
        'lastName': lastname,
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> updateVehicleBlockchainData(
    String lessorAddress,
    String nftId,
    String transactionHash,
    String web3vehicleId,
    String vehicleId,
  ) async {
    const mutation = r'''
    mutation updateCar($id: String!, $web3Data: BlockchainInputData) {
      updateCar(
        data: {
          web3Data: $web3Data 
        }
        where: {
          id: $id
        }
      ) {
        id
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': "Bearer $accessToken",
        'id': vehicleId,
        'web3Data': {
          'lessorAddress': lessorAddress,
          'nftId': nftId,
          'transactionHash': transactionHash,
          'vehicleId': web3vehicleId
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> updateUserDriverKYC(String? userId,
      Map userDriverKYC, UserOnboardingStatus userOnboardingStatus) async {
    const mutation = r'''
    mutation updateUser($userId: String!, $userOnboardingStatus: EnumUserOnboardingStatus!, $userDriverKYC: UserVerification!) {
      updateUser(
        data: { 
          userOnboardingStatus: $userOnboardingStatus
          userDriverKYC: $userDriverKYC
        }
        where: {
          id: $userId
        }
      ) {
        userDriverKYC
        userOnboardingStatus
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;

    log(userDriverKYC.toString());
    final options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': "Bearer $accessToken",
        'userId': userId,
        'userDriverKYC': userDriverKYC.toString(),
        'userOnboardingStatus': userOnboardingStatus.value
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> signUpUser(String email, String phone,
      String firstName, String lastName, String walletAddress) {
    const String mutation = '''
      mutation RegisterUser(\$credentials: RegisterCredentials!) {
        register(credentials: \$credentials) {
          email
        }
      }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'credentials': {
          'email': email,
          'phone': phone,
          'firstName': firstName,
          'lastName': lastName,
          'walletAddress': walletAddress
        },
      },
    );

    log(options.variables.toString(), name: "create account params");

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> verifyOtp(String otpToken) async {
    const String mutation = '''
    mutation VerifyEmail(\$credentials: VerifyEmailCredentials!) {
      verifyEmail(credentials: \$credentials) {
        email
        password
      }
    }
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'credentials': {
          'token': otpToken,
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> forgetPassword(String email) {
    const String mutation = '''
    mutation forgetPassword(\$credentials: RequestForgetPasswordCredentials!) {
      forgetPassword(credentials: \$credentials) {
        email
        message
      }
    }
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'credentials': {
          'email': email,
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> resetPassword(String email,
      String newPassword, String confirmPassword, String otpToken) async {
    const String mutation = '''
      mutation ResetPassword(\$email: String!, \$newPassword: String!, \$confirmPassword: String!, \$token: String!) {
        resetPassword(credentials: { email: \$email, password: \$newPassword, confirmPassword: \$confirmPassword, token: \$token }) {
          email
          message
        }
      }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'email': email,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
        'token': otpToken,
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> deleteVehicle(
    String? vehicleId,
  ) async {
    const mutation = r'''
    mutation deleteCar($id: String!) {
      deleteCar(
        where: {
          id: $id
        }
      ) {
       id      
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;

    final options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': "Bearer $accessToken",
        'id': vehicleId,
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> vehicleUnlockOTP(
    String rentalID,
  ) async {
    const mutation = '''
    mutation sendVehicleUnlockOTP(\$rentalId: String!) {
      sendVehicleUnlockOTP(rentalId: \$rentalId) {
          error
          message
          status
          token
        }
      }
    ''';

    final options = MutationOptions(
      document: gql(mutation),
      variables: {
        'rentalId': rentalID,
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> verifyVehicleUnlockOTP(
      String rentalID, String token) async {
    const mutation = '''
    mutation VerifyVehicleUnlockOTP(\$rentalId: String!, \$token: String!) {
      verifyVehicleUnlockOTP(rentalId: \$rentalId, token: \$token) {
          error
          message
          status
          token
        }
      }
    ''';

    final options = MutationOptions(
      document: gql(mutation),
      variables: {
        'rentalId': rentalID,
        'token': token,
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> createRental(
      VehicleRentalModel vehicleRentalModel,
      {required String lessorId,
      required String lesseeID,
      Map planId = const {
        "id": "657b2819687c39a412f1d6e8",
      }}) {
    const String mutation = '''
  mutation RentCar(\$data: RentalCreateInput!) {
    createRental(data:\$data) {
      
      id
      
    }
  }
''';
    final String? accessToken = LocalStorage.accessToken;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'data': {
          'car': {'id': vehicleRentalModel.vehicleId},
          'currentLocation': " ",
          'destination': " ",
          'destinationGeoLoc': " ",
          'lessee': {'id': lesseeID},
          'lessor': {'id': lessorId},
          'startMillage': "0",
          'pickupAddress': " ",
          'pickupGeoLoc': " ",
          'pickupTime':
              vehicleRentalModel.rentalStartDateTime?.toIso8601String(),
          'plan': planId,
          'rentalEndDatetime':
              vehicleRentalModel.rentalEndDateTime?.toIso8601String(),
          'rentalRequestTime': DateTime.now().toIso8601String(),
          'rentalStatus': RentalStatus.booked.value,
          'rentalStartDatetime':
              vehicleRentalModel.rentalStartDateTime?.toIso8601String(),
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> updateRental({
    ({
      String backImage,
      String frontImage,
      String insideImage,
      String leftImage,
      String rightImage
    })? beforeTripImage,
    ({
      String backImage,
      String frontImage,
      String insideImage,
      String leftImage,
      String rightImage
    })? afterTripImage,
    required RentalStatus rentalStatus,
    required String rentalId,
    String? endMilage,
    String? startMilage,
  }) {
    const String mutation = '''
  mutation RentCar(\$data:  RentalUpdateInput!, \$rentalId: String!) {
    updateRental(data:\$data,  where: {
          id: \$rentalId
        }) {     
      id
    }
  }
''';
    final String? accessToken = LocalStorage.accessToken;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'rentalId': rentalId,
        'data': {
          if (endMilage != null) "endMilage": endMilage,
          if (startMilage != null) "startMillage": startMilage,
          if (beforeTripImage != null || true)
            "beforeTripImage": {
              "backImage": beforeTripImage?.backImage ??
                  "QmUNxpuYFcHPjo3PuM5EaTRf4753n6VmkbWxdqD4viLx2Z",
              "frontImage": beforeTripImage?.frontImage ??
                  "QmUNxpuYFcHPjo3PuM5EaTRf4753n6VmkbWxdqD4viLx2Z",
              "InsideImage": beforeTripImage?.insideImage ??
                  "QmUNxpuYFcHPjo3PuM5EaTRf4753n6VmkbWxdqD4viLx2Z",
              "leftImage": beforeTripImage?.leftImage ??
                  "QmUNxpuYFcHPjo3PuM5EaTRf4753n6VmkbWxdqD4viLx2Z",
              "RightImage": beforeTripImage?.rightImage ??
                  "QmUNxpuYFcHPjo3PuM5EaTRf4753n6VmkbWxdqD4viLx2Z"
            },
          if (afterTripImage != null)
            "afterTripImage": {
              "backImage": afterTripImage.backImage,
              "frontImage": afterTripImage.frontImage,
              "InsideImage": afterTripImage.insideImage,
              "leftImage": afterTripImage.leftImage,
              "RightImage": afterTripImage.rightImage
            },
          'rentalStatus': rentalStatus.value,
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> createEscrow(
      String transactionHash, String depositAmount, String rentalId) async {
    const String mutation = '''
    mutation CreateEscrow(\$data: EscrowCreateInput!) {
      createEscrow(data: \$data) {
        id
        depositAmount
        depositStatus
        blockchainHash
        rentalId {
          id
        }
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'data': {
          'blockchainHash': transactionHash,
          'depositAmount': double.parse(depositAmount),
          'depositStatus': 'Active',
          'rentalId': {"id": rentalId},
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> createVehicle(VehicleModel vehicleData,
      {required String lessorID,
      Map planId = const {
        "id": "657b2819687c39a412f1d6e8",
      }}) async {
    const String mutation = '''
    mutation CreateCar(\$input: CarCreateInput!) {
      createCar(data: \$input) {
        id
        capacity
        color
        pricePerHour
        createdAt
        make
        extraFeatures
        availability
        insuranceExpDate
        insuranceEffectiveDate
        insuranceProvider
        insuranceProviderNumber
        millagePerCharge
        model
        policyNumber
        seats
        vehicleBrand
        vehicleType
        year
        registrationInfo
        parkedLocation
        updatedAt
        vin
        hadAccident
        iAmVehicleOwner
        vehicleHasMaintenance
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'input': {
          'insuranceExpDate': vehicleData.expiryDate.toString(),
          'insuranceProvider': vehicleData.insuranceProvider,
          'parkedLocation': {
            'longitude': vehicleData.longitude,
            'latitude': vehicleData.latitude
          },
          'registrationInfo': vehicleData.vehicleRegistrationGoodThru,
          'vin': vehicleData.vin,
          'insuranceProviderNumber': vehicleData.insurancePNumber,
          'policyNumber': vehicleData.policyNumber,
          'insuranceEffectiveDate': vehicleData.effectiveDate.toString(),
          'model': vehicleData.model,
          'vehicleType': vehicleData.vehicleType,
          'color': vehicleData.color,
          'plan': planId,
          'capacity': vehicleData.capacity,
          'millagePerCharge': vehicleData.mileagePerCharge,
          'year': vehicleData.modelYear,
          'seats': vehicleData.numberOfSeats,
          'extraFeatures': vehicleData.extraFeatures ?? [],
          'lessor': {'id': lessorID},
          'smartCarAccessToken': vehicleData.smartCarVehicle?.token?.access,
          'smartCarRefreshToken': vehicleData.smartCarVehicle?.token?.refresh,
          'smartCarVehicleId': vehicleData.smartCarVehicle?.id,
          'vehiclePlateNumber': vehicleData.vehiclePlateNumber,
          'make': vehicleData.brand,
          'vehicleHasMaintenance': vehicleData.isVehicleMaintenance,
          'iAmVehicleOwner': vehicleData.isRegisteredOwner,
          'vehicleHasUpdatedMOT': vehicleData.isUpToDate,
          'hadAccident': vehicleData.isAccident,
          'vehicleBrand': vehicleData.brand,
          'maxPricePerHour': vehicleData.maximumPrice,
          'minPricePerHour': vehicleData.minimumPrice,
          'pricePerHour': vehicleData.maximumPrice,
          'availability': vehicleData.selectedDates
              ?.map((e) => e.toIso8601String())
              .toList(),
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult> getUserName() async {
    const query = r'''
    query GetUserName {
      userInfo {
        username
        }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'Authorization': "Bearer $accessToken",
      },
    );

    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult> getUserDetails(String userId) async {
    const query = r'''
  query GetUser($userId: String!) {
    user(where: { id: $userId }) {
      id
      firstName
      lastName
      email
      isEmailVerified
      username
      userType
      userOnboardingStatus
      roles
      userDriverKYC
      cars {
        capacity
        carImages {
          imageUrl
        }
        color
        createdAt
        extraFeatures
        id
        insuranceExpDate
        insuranceEffectiveDate
        insuranceProvider
        insuranceProviderNumber
        make
        millagePerCharge
        pricePerHour
        model
        policyNumber
        registrationInfo
        rentals {
          createdAt
        }
        web3Data{
          nftId
          transactionHash
          lessorAddress
          vehicleId
         }
          lessor {
          id
        username
         }
        seats
        smartCarVehicleId
        updatedAt
        vehicleType
        vehicleBrand
        year
      }
      notifications {
        createdAt
        id
        isRead
        message
        updatedAt
      }
      rentals {
        car {
          carImages {
            imageUrl
          }
          color
          id
          lessor {
            username
            id
            firstName
            lastName
            email
          }
          
          make
          model
          vehicleBrand
          vehicleType
        }
        escrows {
          depositAmount
        }
        createdAt
        currentLocation
        destination
        destinationGeoLoc
        id
        pickupAddress
        pickupGeoLoc
        pickupTime
        rentalEndDatetime
        rentalRequestTime
        rentalStartDatetime
        rentalStatus
      }
    }
  }
  ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'userId': userId,
      },
    );
    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult<Object?>> getVehicles(
      ({
        List<String>? brand,
        List<String>? type,
        List<String>? capacity,
        ({String? min, String? max}) priceRange
      })? queryOptions,
      String? lessorID) async {
    const String query = '''
    query GetAllCars(\$where: CarWhereInput, \$orderBy: [CarOrderByInput!]) {
      cars(where: \$where, orderBy:\$orderBy ) {
        availability
        color
        vehicleType
        reservedDates
        extraFeatures
        id
        make
        millagePerCharge
        model
        carImages {
          imageUrl
          videoUrl
        }
         lessor {
          id
          username
        }
        web3Data {
          nftId
          transactionHash
          lessorAddress
          vehicleId
        }
        vehiclePlateNumber
        pricePerHour
        parkedLocation
        seats
        smartCarVehicleId
        vin
        year
      }
    }
  ''';
    final String? accessToken = LocalStorage.accessToken;

    final Map<String, dynamic> variables = {
      'Authorization': "Bearer $accessToken",
    };
    final capacitiesAsIntegers =
        queryOptions?.capacity?.map((str) => int.tryParse(str)).toList();

    final minPriceAsInt = int.tryParse(queryOptions?.priceRange.min ?? '');
    final maxPriceAsInt = int.tryParse(queryOptions?.priceRange.max ?? '');

    if (queryOptions?.brand != null ||
        queryOptions?.capacity != null ||
        queryOptions?.type != null) {
      variables["where"] = {};

      if (queryOptions?.brand?.isNotEmpty == true) {
        variables["where"]["make"] = {"in": queryOptions!.brand!};
      }

      if (queryOptions?.type?.isNotEmpty == true) {
        variables["where"]["vehicleType"] = {"in": queryOptions!.type!};
      }

      if (capacitiesAsIntegers?.isNotEmpty == true) {
        variables["where"]["capacity"] = {"in": capacitiesAsIntegers};
      }
    }

    if (queryOptions?.priceRange.min != null ||
        queryOptions?.priceRange.max != null) {
      variables["where"] ??= {};
      variables["where"]["pricePerHour"] = {
        "gte": minPriceAsInt ?? 0,
        if (maxPriceAsInt != null) "lte": maxPriceAsInt,
      };
    }

    if (lessorID != null) {
      variables["where"] = {};
      variables["where"]["lessor"] = {"id": lessorID};
    }

    variables["orderBy"] = {"createdAt": 'Desc'};

    final QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables,
        fetchPolicy: FetchPolicy.networkOnly);

    //TODO:set to network only       fetchPolicy: FetchPolicy.networkOnly,

    return GraphQLConfig.performQuery(
      options,
    );
  }

  static Future<QueryResult<Object?>> getRentals(
      {RentalStatus? rentalStatus, String? lesseeID, String? lessorID}) async {
    const String query = '''
  query Rentals(\$where: RentalWhereInput) {
    rentals(where: \$where) {
      car {
         availability
        color
        vehicleType
        extraFeatures
        id
        make
        millagePerCharge
        model
        carImages {
          imageUrl
          videoUrl
        }
         lessor {
          id
          username
        }
        web3Data {
          nftId
          transactionHash
          lessorAddress
          vehicleId
        }
        vehiclePlateNumber
        pricePerHour
        parkedLocation
        seats
        smartCarVehicleId
        vin
        year
      }
      lessor{
      id
      email
      username
      firstName
      lastName
      }
      lessee{
        id
        username
        firstName
        lastName
        email
      }
      startMillage
      createdAt
      currentLocation
      destination
      destinationGeoLoc
      id
      pickupAddress
      pickupGeoLoc
      pickupTime
      rentalEndDatetime
      rentalRequestTime
      rentalStartDatetime
      rentalStatus
    }
  }
''';

    final String? accessToken = LocalStorage.accessToken;
    final Map<String, dynamic> whereConditions = {};

    if (lesseeID != null) {
      whereConditions['lessee'] = {'id': lesseeID};
    }
    if (lessorID != null) {
      whereConditions['lessor'] = {'id': lessorID};
    }
    if (rentalStatus != null) {
      whereConditions['rentalStatus'] = rentalStatus.value;
    }

    final Map<String, dynamic> variables = {
      'Authorization': "Bearer $accessToken",
      'where': whereConditions,
    };

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables,
      fetchPolicy: FetchPolicy.networkOnly,
    );

    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult<Object?>> getVehiclesById(String id) async {
    const String query = r'''
  query getCar($carID: String!) {
    cars(where: { id: { equals: $carID } }) {
      availability
      capacity
      color
      createdAt
      deletedAt
      extraFeatures
      hadAccident
      iAmVehicleOwner
      id
      insuranceEffectiveDate
      insuranceExpDate
      insuranceProvider
      insuranceProviderNumber
      make
      millagePerCharge
      model
      parkedLocation
      policyNumber
      availability
      registrationInfo
      seats
      smartCarVehicleId
      updatedAt
      web3Data {
        nftId
        transactionHash
        lessorAddress
        vehicleId
      }
      vehicleBrand
      vehicleHasMaintenance
      vehicleHasUpdatedMOT
      vehicleType
      vin
      year
    }
  }
''';

    final String? accessToken = LocalStorage.accessToken;

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {'Authorization': "Bearer $accessToken", 'carID': id},
    );

    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult<Object?>> deleteUser(
    String? userId,
    Map userDriverKYC,
  ) async {
    const mutation = r'''
    mutation deleteUser($userId: String!) {
      deleteUser(
        
        where: {
          id: $userId
        }
      ) {
       email
       username
       id
        
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;

    final options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': "Bearer $accessToken",
        'userId': userId,
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> createVehicleImageVideo(
      String? vehicleId, String? imageUrl, String? videoUrl) async {
    const mutation = r'''
      mutation CreateCarImage($carImageInput: CarImageCreateInput!) {
      createCarImage(data: $carImageInput) {
        carId {
          id
        }
        createdAt
        deletedAt
        id
        imageUrl
        updatedAt
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;

    final options = MutationOptions(document: gql(mutation), variables: {
      'Authorization': "Bearer $accessToken",
      'carImageInput': {
        'carId': {'id': vehicleId},
        'imageUrl': imageUrl ?? "",
        'videoUrl': videoUrl ?? "",
      },
    });

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> vehicleFilterValues() async {
    const query = r'''
    query CarsFilterValues {
      cars(orderBy: { createdAt: Desc }) {
        make
        millagePerCharge
        capacity
        vehicleType
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final options = QueryOptions(
      document: gql(query),
      variables: {
        'Authorization': "Bearer $accessToken",
      },
    );

    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult<Object?>> requestNonce(String walletAddress) async {
    const query = r'''
    query RequestNonce($walletAddress: String!) {
      requestNonce(address: $walletAddress) {
        nonce
      }
    }
  ''';

    final options = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(query),
      variables: {
        'walletAddress': walletAddress,
      },
    );

    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult<Object?>> verifySIWESignature(
      String signature, String message) async {
    const mutation = r'''
      mutation VerifySIWESignature($credentials: VerifySIWECredentials!) {
        verifySIWESignature(credentials: $credentials) {
          accessToken
          email
          id
          roles
          username
        }
      }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'credentials': {'message': message, 'signature': signature},
      },
    );

    return await GraphQLConfig.performMutation(options);
  }

  //Smart Car Section
  static Future<QueryResult<Object?>> exchangeSmartCar(
    String code,
  ) async {
    const mutation = '''
      mutation exchangeSmartCar(\$data: ExchangeSmartCarCodeInput!){
        exchange(data:\$data){
          access_token
          expires_in
          refresh_token
          token_type
        }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'data': {'referral': "mobile", 'code': code}
      },
    );

    return await GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> getAllSmartCarVehicles(
    String smartCarAccessToken,
  ) async {
    const String query = r'''
      query GetAllVehicles($accessToken: String!) {
        getAllVehicles(data: { accessToken: $accessToken }) {
          vehicles
        }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'accessToken': smartCarAccessToken,
      },
    );
    return await GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult<Object?>> getSmartCarLockStatus(
      String smartCarAccessToken, String smartCarVehicleId) async {
    const String query = r'''
      query GetLockStatus($accessToken: String!, $vehicleId: String!) {
        getLockStatus(data: {
          accessToken: $accessToken,
          vehicleId: $vehicleId
        }) {
          isLocked
        }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'accessToken': smartCarAccessToken,
        'vehicleId': smartCarVehicleId,
      },
    );

    return await GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult<Object?>> lockSmartCarVehicle(
      String vehicleId) async {
    const String mutation = r'''
      mutation LockVehicle($vehicleId: String!) {
        lockVehicle(data: {
          vehicleId: $vehicleId
        }) {
          message
          status
        }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'vehicleId': vehicleId,
      },
    );
    return await GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> unlockSmartCarVehicle(
      String vehicleId) async {
    const String mutation = r'''
      mutation UnlockVehicle($vehicleId: String!) {
        unLockVehicle(data: {
          vehicleId: $vehicleId
        }) {
          message
          status
        }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'vehicleId': vehicleId,
      },
    );
    return await GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> refreshSmartCarToken(
      String vehicleId) async {
    const String mutation = r'''
      mutation RefreshToken( $vehicleId: String!) {
        refreshToken(
          vehicleId: $vehicleId
        ) {
         expires_in
        }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'vehicleId': vehicleId,
      },
    );
    return await GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> getSmartCarVehicleDetails(
      String? smartCarAccessToken, String vehicleId) async {
    String query = smartCarAccessToken == null
        ? r'''
      query LesseeGetBatchData($vehicleId: String!) {
        lesseeGetBatchData(
          vehicleId: $vehicleId
        ) {
          responses {
          body
          path
          }
        }
      }
    '''
        : r'''
      query GetBatchData($accessToken: String!, $vehicleId: String!) {
        getBatchData(
          accessToken: $accessToken,
          vehicleId: $vehicleId
        ) {
          responses {
          body
          path
          }
        }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'Authorization': 'Bearer $accessToken',
        if (smartCarAccessToken != null) 'accessToken': smartCarAccessToken,
        'vehicleId': vehicleId,
      },
    );

    return await GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult<Object?>> getSmartCarVehicleDetailsN(
      String smartCarAccessToken, String vehicleId) async {
    const String query = r'''
      query GetBatchData($accessToken: String!, $vehicleId: String!) {
        getBatchData(
          accessToken: $accessToken,
          vehicleId: $vehicleId
        ) {
          responses {
          body
          path
          }
        }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'accessToken': smartCarAccessToken,
        'vehicleId': vehicleId,
      },
    );

    return await GraphQLConfig.performQuery(options);
  }

  static Stream<QueryResult<Object?>> rentalSubscription() {
    const String subscription = '''
      subscription rentals(\$where: RentalWhereInput) {
         rentals(where: \$where) {
          responses {
          body
          path
          }
        }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;

    final SubscriptionOptions options = SubscriptionOptions(
      document: gql(subscription),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'where': const {
          'lesseeId': {'id': "657b1ac98b90756c87b5a707"}
        },
      },
    );

    return GraphQLConfig.performSubscription(options);
  }

  // Ecobook Sections

  static Future<QueryResult<Object?>> createPost(
    PostModel postModel,
  ) async {
    const String mutation = '''
    mutation CreatePost(\$input: UserFeedCreateInput!) {
      createUserFeed(data: \$input) {
        createdAt
        content
        media{imageUrl
        videoUrl}
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final String? id = LocalStorage.userId;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'input': {
          'content': postModel.content,
          'creator': {'id': id},
          'media': {
            'imageUrl': postModel.imageUrl,
            'videoUrl': postModel.videoUrl
          },
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> createCommunityPost(
    PostModel postModel,
    String communityId,
  ) async {
    const String mutation = '''
    mutation CreateCommunityPost(\$input: CommunityFeedCreateInput!) {
      createCommunityFeed(data: \$input) {
        createdAt
        content
        mediaUrl{
        imageUrl
        videoUrl
        }
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final String? id = LocalStorage.userId;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'input': {
          'community': {'id': communityId},
          'content': postModel.content,
          'creator': {'id': id},
          'mediaUrl': {
            'imageUrl': postModel.imageUrl,
            'videoUrl': postModel.videoUrl
          },
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> editPost(
    PostModel postModel,
    String postId,
  ) async {
    const String mutation = '''
    mutation EditPost(\$input: UserFeedUpdateInput!, \$where : UserFeedWhereUniqueInput!) {
      updateUserFeed(
      where : \$where,
      data: \$input) {
        createdAt
        content
        media{imageUrl
        videoUrl}
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final String? id = LocalStorage.userId;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'where': {"id": postId},
        'input': {
          'content': postModel.content,
          'creator': {'id': id},
          'media': {
            'imageUrl': postModel.imageUrl,
            'videoUrl': postModel.videoUrl
          },
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> editCommunityPost(
    PostModel postModel,
    String postId,
  ) async {
    const String mutation = '''
    mutation EditCommunityPost(\$input: CommunityFeedUpdateInput!, \$where : CommunityFeedWhereUniqueInput!) {
      updateCommunityFeed(
      where : \$where,
      data: \$input) {
        createdAt
        content
        mediaUrl{
        imageUrl
        videoUrl
        }
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final String? id = LocalStorage.userId;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'where': {"id": postId},
        'input': {
          'content': postModel.content,
          'creator': {'id': id},
          'mediaUrl': {
            'imageUrl': postModel.imageUrl,
            'videoUrl': postModel.videoUrl
          }
          // 'media': {
          //   'imageUrl': postModel.imageUrl,
          //   'videoUrl': postModel.videoUrl
          // },
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> deleteUserPost(String feedId) async {
    const String mutation = '''
    mutation DeleteUserPost(\$input: UserFeedWhereUniqueInput!) {
      deleteUserFeed(where: \$input) {
        content
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'input': {"id": feedId},
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> deleteCommunityPost(String feedId) async {
    const String mutation = '''
    mutation DeleteCommunityFeed(\$input: CommunityFeedWhereUniqueInput!) {
      deleteCommunityFeed(where: \$input) {
        content
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'input': {"id": feedId},
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult> fetchLikedFeeds() async {
    const query = r'''
    query FetchLikedFeeds ($id : String!){
       feedLikes (where : {likedBy : {id : $id}},
       orderBy : [{createdAt : Desc}]){
       userFeed{
       id
         content
         createdAt
         updatedAt
         creator {
           id
         username
         }
         feedLikes {
          id
           likedBy {
             username
             id
           }
         }
        media{
        imageUrl
        videoUrl
        }
         comments (orderBy: [{
         createdAt: Desc
       }]) {
         comments
          id
         createdAt
         updatedAt
         creator{
         id
         username
         }
    }
    }
  }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;
    final String? id = LocalStorage.userId;
    final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(query),
      variables: {'Authorization': "Bearer $accessToken", "id": id},
    );

    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult> fetchFeeds() async {
    const query = r'''
    query FetchFeeds {
       userFeeds (orderBy: [{
         createdAt: Desc
       }]){
         id
         content
         createdAt
         updatedAt
         creator {
           id
         username
         }
         feedLikes {
          id
           likedBy {
             username
             id
           }
         }
        media{
        imageUrl
        videoUrl
        }
         comments (orderBy: [{
         createdAt: Desc
       }]) {
         comments
          id
         createdAt
         updatedAt
         creator{
         id
         username
         }
    }
  }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;
    final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(query),
      variables: {
        'Authorization': "Bearer $accessToken",
      },
    );

    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult> fetchFeedsByUser() async {
    const query = r'''
    query FetchFeeds($userId : String!) {
       userFeeds (orderBy: [{
         createdAt: Desc
       }], where : {creator : {id : $userId}}){
         id
         content
         createdAt
         updatedAt
         creator {
           id
         username
         }
         feedLikes {
          id
           likedBy {
             username
             id
           }
         }
        media{
        imageUrl
        videoUrl
        }
         comments (orderBy: [{
         createdAt: Desc
       }]) {
         comments
          id
         createdAt
         updatedAt
         creator{
         id
         username
         }
    }
  }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;
    final String? id = LocalStorage.userId;
    final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(query),
      variables: {'Authorization': "Bearer $accessToken", "userId": id},
    );

    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult> fetchFeedComments({required String feedId}) async {
    const query = r'''
    query FetchFeedComments ($feedId : String!) {
       comments (where : {userFeed : {id : $feedId}}, orderBy : [{
         createdAt: Desc
       }] ) {
         id
         comments
         createdAt
         updatedAt
         creator {
           id
         username
         }
    }
  }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;
    final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(query),
      variables: {
        'Authorization': "Bearer $accessToken",
      },
    );

    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult> fetchCommunityFeedComments(
      {required String feedId}) async {
    const query = r'''
    query FetchCommunityFeed ($feedId : String!) {
       comments (where : {communityFeed : {id : $feedId}}, orderBy : [{
         createdAt: Desc
       }] ) {
         id
         comments
         createdAt
         updatedAt
         creator {
           id
         username
         }
    }
  }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;
    final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(query),
      variables: {
        'Authorization': "Bearer $accessToken",
      },
    );

    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult> fetchCommunityMembers(
      {required String communityId}) async {
    const query = r'''
    query FetchCommunityMembers ($id : String!) {
       community (where : {id : $id}) {
       members {
       id
       username
       }}
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;
    final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(query),
      variables: {'Authorization': "Bearer $accessToken", "id": communityId},
    );

    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult> communityFeeds(
      {required String communityId}) async {
    const query = r'''
    query FetchFeeds ($communityId : String!){
       communityFeeds(orderBy: [{
         createdAt: Desc
       }]
       where : {community : {id : $communityId}}) {
         id
         content
         createdAt
         updatedAt
         creator {
           id
           username
         }
         feedLikes {
           likedBy {
             username
             id
           }
         }
         mediaUrl{
         imageUrl
         videoUrl
         }
         comments (orderBy: [{
         createdAt: Desc
       }]) {
           comments
           id
           createdAt
           updatedAt
           creator {
             id
             username
           }
         }
       }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(query),
      variables: {
        'Authorization': "Bearer $accessToken",
        'communityId': communityId
      },
    );

    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult> fetchCommunities() async {
    const query = r'''
    query FetchFeeds {
       communities {
         communityHeaderImgUrl
         name
         id
         communityFeeds {
         id
         content
         createdAt
         updatedAt
         feedLikes{
         likedBy {
         username
         id
         }}
         
         mediaUrl {
         imageUrl
         videoUrl
         }
         
         comments (orderBy: [{
         createdAt: Desc
       }]) {
           comments
           id
           createdAt
           updatedAt
           creator {
             id
             username
           }
         }
         
      creator {
      id
        username
      }
    }
         description
         members{
         id
         username
         }
         createdAt
         updatedAt
        
     
  }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;
    final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(query),
      variables: {
        'Authorization': "Bearer $accessToken",
      },
    );

    return GraphQLConfig.performQuery(options);
  }

  static Future<QueryResult<Object?>> createCommentOnUserFeed(
      {required String postId, required String comment}) async {
    const String mutation = '''
    mutation CreatePost(\$input: CommentCreateInput!) {
      createComment(data: \$input) {
        createdAt
        comments
          id
         createdAt
         updatedAt
         creator{
         id
         username
         }
      }
      
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final String? id = LocalStorage.userId;

    final MutationOptions options = MutationOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'input': {
          'comments': comment,
          'creator': {'id': id},
          'userFeed': {'id': postId}
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> createCommentOnCommunityFeed(
      {required String postId, required String comment}) async {
    const String mutation = '''
    mutation CreatePost(\$input: CommentCreateInput!) {
      createComment(data: \$input) {
        createdAt
        comments
          id
         createdAt
         updatedAt
         creator{
         id
         username
         }
      }
      
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final String? id = LocalStorage.userId;

    final MutationOptions options = MutationOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'input': {
          'comments': comment,
          'creator': {'id': id},
          'communityFeed': {'id': postId}
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> deleteUserFeedLike(String likeId) async {
    const String mutation = '''
      mutation DeleteLike(\$id: String!) {
        deleteFeedLike(where: { id: \$id }) {
          id
          likedBy {
            username
          }
        }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {'Authorization': 'Bearer $accessToken', 'id': likeId},
    );

    return await GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> deleteCommunityFeedLike(
      String likeId) async {
    const String mutation = '''
      mutation DeleteLike(\$id: String!) {
        deleteFeedLike(where: { id: \$id }) {
          id
          likedBy {
            username
          }
        }
      }
    ''';

    final String? accessToken = LocalStorage.accessToken;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {'Authorization': 'Bearer $accessToken', 'id': likeId},
    );

    return await GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> likeUserFeed(
    String feedId,
  ) async {
    const String mutation = '''
    mutation Like(\$input: FeedLikeCreateInput!) {
      createFeedLike(data: \$input) {
        id
        likedBy{
        id
        username}
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final String? id = LocalStorage.userId;

    final MutationOptions options = MutationOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'input': {
          'likedBy': {'id': id},
          'userFeed': {'id': feedId}
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  static Future<QueryResult<Object?>> likeCommunityFeed(
    String feedId,
  ) async {
    const String mutation = '''
    mutation Like(\$input: FeedLikeCreateInput!) {
      createFeedLike(data: \$input) {
        id
        likedBy{
        id
        username}
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final String? id = LocalStorage.userId;

    final MutationOptions options = MutationOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'input': {
          'likedBy': {'id': id},
          'communityFeed': {'id': feedId}
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }

  // Community section

  static Future<QueryResult<Object?>> createCommunity(
    CommunityInput communityInput,
  ) async {
    const String mutation = '''
    mutation CreateCommunityPost(\$input: CommunityCreateInput!) {
      createCommunity(data: \$input) {
        createdAt
      }
    }
  ''';

    final String? accessToken = LocalStorage.accessToken;
    final String? id = LocalStorage.userId;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'Authorization': 'Bearer $accessToken',
        'input': {
          'description': communityInput.description,
          'name': communityInput.name,
          'communityHeaderImgUrl': communityInput.headerImage,
          'members': {
            'connect': {'id': id}
          }
        },
      },
    );

    return GraphQLConfig.performMutation(options);
  }
}
