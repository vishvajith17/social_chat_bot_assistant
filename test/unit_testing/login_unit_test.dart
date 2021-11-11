import 'package:social_chat_bot_assistant/screens/Login/components/body.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {

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