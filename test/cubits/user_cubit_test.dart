import 'package:bloc_test/bloc_test.dart';
import 'package:emr_005/cubits/loading_cubit/loading_cubit.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/cubits/user_cubit/user_model.dart';
import 'package:emr_005/services/ecomoto/vehicle_service.dart';
import 'package:emr_005/services/ecomoto/wallet_service.dart';
import 'package:emr_005/services/user_service.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserService extends Mock implements UserService {}

class MockVehicleService extends Mock implements VehicleService {}

class MockWalletService extends Mock implements WalletService {}

void main() {
  group('UserCubit', () {
    final faker = Faker();
    late UserCubit userCubit;
    late MockUserService mockUserService;
    late MockVehicleService mockVehicleService;
    late LoadingCubit loadingCubit;
    late MockWalletService walletService;

    final user = User(
      id: faker.guid.guid(),
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      email: faker.internet.email(),
      isEmailVerified: faker.randomGenerator.boolean(),
      username: faker.internet.userName(),
      userType: faker.randomGenerator.element(['admin', 'user']),
      userOnboardingStatus: UserOnboardingStatus.setKyc,

      // notifications: [],
    );
    setUp(() {
      mockUserService = MockUserService();
      loadingCubit = LoadingCubit();
      mockVehicleService = MockVehicleService();
      walletService = MockWalletService();
      userCubit = UserCubit(
          mockUserService, loadingCubit, mockVehicleService, walletService);
    });

    tearDown(() {
      userCubit.close();
      loadingCubit.close();
    });

    test('initial state is correct', () {
      expect(userCubit.state, UserState.details(user: User.initial()));
    });

    blocTest<UserCubit, UserState>(
      'emits [UserState.details] after successful getUserDetails',
      build: () {
        when(mockUserService.getUserInformation(userId: "UserId"))
            .thenAnswer((_) async => (error: null, user: user));
        return userCubit;
      },
      act: (cubit) => cubit.getUserDetails(),
      expect: () => UserState.details(user: user),
    );

    // blocTest<UserCubit, UserState>(
    //   'emits [UserState.details] after successful authenticateUser',
    //   build: () {
    //     when(mockUserService.login(
    //             email: faker.internet.email(),
    //             password: faker.internet.password()))
    //         .thenAnswer((_) async => (error: null, isAuthenticated: true));

    //     // when(()=>mockUserService.login(
    //     //         email: faker.internet.email(),
    //     //         password: faker.internet.password()))
    //     //     .thenAnswer((_) async => (error: null, isAuthenticated: true)));
    //     // when(mockUserService.getUserInfo(userId: "UserId"))
    //     //     .thenAnswer((_) async => (error: null, user: user));
    //     return userCubit;
    //   },
    //   act: (cubit) => cubit.authenticateUser(
    //       email: 'test@example.com', password: 'password'),
    //   expect: () => [
    //     const LoadingState.loading(),
    //     UserState.details(user: user),
    //     const LoadingState.initial(),
    //   ],
    // );

    blocTest<UserCubit, UserState>(
      'emits [UserState.details] after successful userSignUp',
      build: () {
        when(mockUserService.createAccount(
                email: "test@example.com",
                phone: '123456',
                walletAddress: 'walletAddress',
                firstName: '',
                lastName: ''))
            .thenAnswer((_) async => (error: null, isSent: true));
        return userCubit;
      },
      act: (cubit) => cubit.createUserAccount(
          email: 'test@example.com',
          phone: '123456',
          firstName: '',
          lastName: ''),
      expect: () => [
        const LoadingState.loading(),
        const LoadingState.initial(),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [UserState.details] after successful otpVerification',
      build: () {
        when(mockUserService.verifyOTP(otpToken: "111111111"))
            .thenAnswer((_) async => (error: null, password: "12345678"));
        return userCubit;
      },
      act: (cubit) => cubit.otpVerification(otp: '123456'),
      expect: () => [
        const LoadingState.loading(),
        const LoadingState.initial(),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [UserState.details] after successful registerUser',
      build: () {
        when(mockUserService.registerUser(
                userOnboardingStatus: UserOnboardingStatus.setKyc,
                userId: anyNamed('userId'),
                username: "username",
                oldPassword: "oldPassword",
                newPassword: "newPassword"))
            .thenAnswer((_) async => (error: null, isRegistered: true));
        return userCubit;
      },
      act: (cubit) => cubit.registerUser(
        oldPassword: 'oldPassword',
        newPassword: 'newPassword',
        username: 'testUser',
      ),
      expect: () => [
        const LoadingState.loading(),
        UserState.details(user: user),
        const LoadingState.initial(),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [UserState.details] after successful changePassword',
      build: () {
        when(mockUserService.changePassword(
          userId: anyNamed('userId'),
          oldPassword: 'oldPassword',
          newPassword: 'newPassword',
        )).thenAnswer((_) async => (error: null, isChanged: true));
        return userCubit;
      },
      act: (cubit) => cubit.changePassword(
          oldPassword: 'oldPassword', newPassword: 'newPassword'),
      expect: () => [
        const LoadingState.loading(),
        const LoadingState.initial(),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [UserState.details] after successful changeEmail',
      build: () {
        when(mockUserService.changeEmail(
                userId: anyNamed('userId'),
                password: "password",
                newEmail: "userEmail"))
            .thenAnswer((_) async => (error: null, isChanged: true));
        return userCubit;
      },
      act: (cubit) =>
          cubit.changeEmail(password: 'password', newEmail: 'new@example.com'),
      expect: () => [
        const LoadingState.loading(),
        const LoadingState.initial(),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [UserState.details] after successful updateGeneralInfo',
      build: () {
        when(mockUserService.updateUserInformation(
                userId: anyNamed('userId'),
                username: "username",
                firstName: "firstName",
                lastName: "lastName"))
            .thenAnswer((_) async => (error: null, isUpdated: true));
        return userCubit;
      },
      act: (cubit) => cubit.updateGeneralInfo(
        username: 'testUser',
        firstName: 'John',
        lastName: 'Doe',
      ),
      expect: () => [
        const LoadingState.loading(),
        const LoadingState.initial(),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [UserState.details] after successful updateUserDriverKYC',
      build: () {
        when(mockUserService.verifyUserKYC(sessionId: "sessionId"))
            .thenAnswer((_) async => (error: null, verificationData: {}));
        when(mockUserService.updateUserKYC(
                userId: "userID",
                userDriverKYC: {},
                userOnboardingStatus: UserOnboardingStatus.setKyc))
            .thenAnswer((_) async => (error: null));
        return userCubit;
      },
      act: (cubit) => cubit.updateUserDriverKYC(sessionId: 'fakeSessionId'),
      expect: () => [
        const LoadingState.loading(),
        UserState.details(user: user),
        const LoadingState.initial(),
      ],
    );
  });
}
