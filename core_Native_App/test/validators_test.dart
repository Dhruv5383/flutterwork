// test/validators_test.dart

import 'package:core_native_app/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:ecorp_elearning/core/utils/validators.dart';

void main() {
  group('Validators - Email', () {
    test('Valid email passes', () {
      expect(Validators.validateEmail('user@example.com'), isNull);
      expect(Validators.validateEmail('user.name+tag@domain.co'), isNull);
    });

    test('Empty email fails', () {
      expect(Validators.validateEmail(''), isNotNull);
      expect(Validators.validateEmail(null), isNotNull);
    });

    test('Invalid email fails', () {
      expect(Validators.validateEmail('notanemail'), isNotNull);
      expect(Validators.validateEmail('missing@'), isNotNull);
      expect(Validators.validateEmail('@nodomain.com'), isNotNull);
    });
  });

  group('Validators - Password', () {
    test('Valid password passes', () {
      expect(Validators.validatePassword('Pass123'), isNull);
      expect(Validators.validatePassword('Abc123!'), isNull);
    });

    test('Too short password fails', () {
      expect(Validators.validatePassword('Ab1'), isNotNull);
    });

    test('Letters-only password fails', () {
      expect(Validators.validatePassword('password'), isNotNull);
    });

    test('Numbers-only password fails', () {
      expect(Validators.validatePassword('123456'), isNotNull);
    });

    test('Empty password fails', () {
      expect(Validators.validatePassword(''), isNotNull);
      expect(Validators.validatePassword(null), isNotNull);
    });
  });

  group('Validators - Confirm Password', () {
    test('Matching passwords pass', () {
      expect(Validators.validateConfirmPassword('Pass123', 'Pass123'), isNull);
    });

    test('Non-matching passwords fail', () {
      expect(
          Validators.validateConfirmPassword('Pass123', 'Different1'),
          isNotNull);
    });

    test('Empty confirm password fails', () {
      expect(Validators.validateConfirmPassword('', 'Pass123'), isNotNull);
    });
  });

  group('Validators - Name', () {
    test('Valid names pass', () {
      expect(Validators.validateFirstName('John'), isNull);
      expect(Validators.validateLastName('Doe Smith'), isNull);
    });

    test('Empty name fails', () {
      expect(Validators.validateFirstName(''), isNotNull);
      expect(Validators.validateFirstName(null), isNotNull);
    });

    test('Numbers in name fail', () {
      expect(Validators.validateFirstName('John123'), isNotNull);
    });
  });
}
