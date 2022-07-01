import 'package:dart_otp/dart_otp.dart';
import 'package:test/test.dart';

void main() {
  var hotp = HOTP("J22U6B3WIWRRBTAV");

  test('[HOTP] Should check the token with default digits', () {
    expect(hotp.digits, 6);
    expect(hotp.counter, 0);
    expect(hotp.type, OTPType.HOTP);
    expect(hotp.secret, "J22U6B3WIWRRBTAV");
    expect(hotp.algorithm, OTPAlgorithm.SHA1);
  });

  test(
      '[HOTP] Should check the token with custom digits, counter and algorithm',
      () {
    var token = HOTP("J22U6B3WIWRRBTAV",
        digits: 8, counter: 50, algorithm: OTPAlgorithm.SHA256);

    expect(token.digits, 8);
    expect(token.counter, 50);
    expect(token.type, OTPType.HOTP);
    expect(token.secret, "J22U6B3WIWRRBTAV");
    expect(token.algorithm, OTPAlgorithm.SHA256);
  });

  test('[HOTP] Should generate and verify using a specific counter', () {
    var otpValue = hotp.at(counter: 0);

    expect(otpValue, '542773');
    expect(hotp.verify(otp: otpValue, counter: 0), true);
  });

  test(
      '[HOTP] Should generate, verify using a specific counter and comare with a superior counter',
      () {
    var otpValue = hotp.at(counter: 10);
    expect(hotp.verify(otp: otpValue, counter: 10), true);
    expect(hotp.verify(otp: otpValue, counter: 20), false);
  });

  test('[HOTP] Should generate token urls', () {
    expect(hotp.generateUrl(issuer: "Sample", account: "Account"),
        "otpauth://hotp/Account?secret=J22U6B3WIWRRBTAV&issuer=Sample&digits=6&algorithm=SHA1&counter=0");
    expect(
        hotp.generateUrl(issuer: "Encoded Issuer", account: "Account Detailed"),
        "otpauth://hotp/Account%20Detailed?secret=J22U6B3WIWRRBTAV&issuer=Encoded+Issuer&digits=6&algorithm=SHA1&counter=0");
  });

  test('[HOTP] Should generate token urls with a custom token', () {
    var token = HOTP("J22U6B3WIWRRBTAV",
        digits: 8, counter: 10, algorithm: OTPAlgorithm.SHA256);
    expect(token.generateUrl(issuer: "More", account: "Digits"),
        "otpauth://hotp/Digits?secret=J22U6B3WIWRRBTAV&issuer=More&digits=8&algorithm=SHA256&counter=10");
  });

  test('[HOTP] Fail Conditions: Validations', () {
    expect(hotp.at(counter: -1), null);
    expect(hotp.at(counter: null), null);
    expect(hotp.verify(otp: null, counter: null), false);
    expect(hotp.verify(otp: null, counter: -1), false);
    expect(hotp.verify(otp: "", counter: -1), false);
  });

  test('[HOTP] Fail Conditions: Generate Url', () {
    expect(hotp.generateUrl(issuer: null, account: null),
        "otpauth://hotp/?secret=J22U6B3WIWRRBTAV&issuer=&digits=6&algorithm=SHA1&counter=0");
    expect(hotp.generateUrl(issuer: null, account: ""),
        "otpauth://hotp/?secret=J22U6B3WIWRRBTAV&issuer=&digits=6&algorithm=SHA1&counter=0");
    expect(hotp.generateUrl(issuer: "", account: null),
        "otpauth://hotp/?secret=J22U6B3WIWRRBTAV&issuer=&digits=6&algorithm=SHA1&counter=0");
  });
}
