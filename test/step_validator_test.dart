import 'package:solid_software_app/StepValidator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('empty input returns error string', () {

    final result = StepValidator.validate("");
    expect(result, 'Please enter the number!');
  });

  test('non-empty input returns null', () {

    final result = StepValidator.validate('25');
    expect(result, null);
  });

}