import 'package:dart_otp/src/components/otp_type.dart';
import 'package:dart_otp/src/utils/otp_util.dart';
import 'package:test/test.dart';

void main() {
  test('[OTPType] Should convert otp type cases into the right values', () {
    expect(OTPUtil.otpTypeValue(OTPType.TOTP), 'totp');
    expect(OTPUtil.otpTypeValue(OTPType.HOTP), 'hotp');
  });
}
