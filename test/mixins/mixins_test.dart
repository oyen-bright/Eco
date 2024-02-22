import 'package:emr_005/ecomoto/mixins/wallet_mixin.dart';
import 'package:flutter_test/flutter_test.dart';

class FunctionHoldingClassForMixin with WalletUtils {}

void main() {
  late FunctionHoldingClassForMixin mockClass;
  group('Utility Tests', () {
    setUp(() => mockClass = FunctionHoldingClassForMixin());
    test('formatAddress should format the address properly', () {
      // Arrange
      const String address = '0x1234567890abcdef';

      // Act
      final formattedAddress = mockClass.formatAddress(address);

      // Assert
      expect(formattedAddress, '0x12345678....90abcdef');
    });
  });
}
