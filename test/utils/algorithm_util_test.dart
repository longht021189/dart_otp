import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dart_otp/src/components/otp_algorithm.dart';
import 'package:dart_otp/src/utils/algorithm_util.dart';
import 'package:test/test.dart';

void main() {
  var key = utf8.encode('sample key string');

  test(
      '[OTPAlgorithm] Should create an Hmac object for each available algorithm type',
      () {
    expect(AlgorithmUtil.createHmacFor(OTPAlgorithm.SHA1, key).toString(),
        Hmac(sha1, key).toString());
    expect(AlgorithmUtil.createHmacFor(OTPAlgorithm.SHA256, key).toString(),
        Hmac(sha256, key).toString());
    expect(AlgorithmUtil.createHmacFor(OTPAlgorithm.SHA384, key).toString(),
        Hmac(sha384, key).toString());
    expect(AlgorithmUtil.createHmacFor(OTPAlgorithm.SHA512, key).toString(),
        Hmac(sha512, key).toString());
  });

  test(
      '[OTPAlgorithm] Should return a raw value for each available algorithm type',
      () {
    expect(AlgorithmUtil.rawValue(OTPAlgorithm.SHA1), 'SHA1');
    expect(AlgorithmUtil.rawValue(OTPAlgorithm.SHA256), 'SHA256');
    expect(AlgorithmUtil.rawValue(OTPAlgorithm.SHA384), 'SHA384');
    expect(AlgorithmUtil.rawValue(OTPAlgorithm.SHA512), 'SHA512');
  });
}
