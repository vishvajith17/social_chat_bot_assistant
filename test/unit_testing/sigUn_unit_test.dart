import 'package:social_chat_bot_assistant/screens/Signup/components/body.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {

  test('empty first name returns error string', () {

    final result = FirstNameFieldValidator.validate('');
    expect(result, 'First name can\'t be empty');
  });

  test('non-empty first name returns null', () {

    final result = FirstNameFieldValidator.validate('Vijay');
    expect(result, null);
  });
  test('empty last name returns error string', () {

    final result = LastNameFieldValidator.validate('');
    expect(result, 'Last name can\'t be empty');
  });

  test('non-empty password returns null', () {

    final result = LastNameFieldValidator.validate('Sali');
    expect(result, null);
  });
  test('empty DoB returns error string', () {

    final result = DoBFieldValidator.validate('');
    expect(result, 'DoB can\'t be empty');
  });

  test('non-empty DoB returns null', () {

    final result = DoBFieldValidator.validate('1998/10/10');
    expect(result, null);
  });
  test('empty NIC returns error string', () {

    final result = NICFieldValidator.validate('');
    expect(result, 'NIC can\'t be empty');
  });
  test('non-empty NIC returns null', () {

    final result = NICFieldValidator.validate('199867454567');
    expect(result, null);
  });
  test('mobile number without 10 numbers returns error string', () {

    final result = MobileFieldValidator.validate('0766');
    expect(result, 'Enter a phone number with 10 numbers');
  });
  test('mobile number password with 10 characters returns null', () {

    final result = MobileFieldValidator.validate('0771234567');
    expect(result, null);
  });
  test('empty email returns error string', () {

    final result = EmailFieldValidator.validate('');
    expect(result, 'Enter an valid email');
  });

  test('non-empty email returns null', () {

    final result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

  test('empty password returns error string', () {

    final result = PasswordFieldValidator.validate('');
    expect(result, 'Enter a password 6+ chars long');
  });
  test('password less than 6 characters returns error', () {

    final result = PasswordFieldValidator.validate('123');
    expect(result, 'Enter a password 6+ chars long');
  });
  test('non-empty password returns null', () {

    final result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });
}