import 'package:crypto/crypto.dart';
import 'package:dart_otp/dart_otp.dart';

abstract class AlgorithmUtil {
  static Hmac createHmacFor(OTPAlgorithm algorithm, List<int> key) {
    switch (algorithm) {
      case OTPAlgorithm.SHA1:
        return Hmac(sha1, key);
      case OTPAlgorithm.SHA256:
        return Hmac(sha256, key);
      case OTPAlgorithm.SHA384:
        return Hmac(sha384, key);
      case OTPAlgorithm.SHA512:
        return Hmac(sha512, key);
    }
  }

  static String rawValue(OTPAlgorithm algorithm) {
    switch (algorithm) {
      case OTPAlgorithm.SHA1:
        return 'SHA1';
      case OTPAlgorithm.SHA256:
        return 'SHA256';
      case OTPAlgorithm.SHA384:
        return 'SHA384';
      case OTPAlgorithm.SHA512:
        return 'SHA512';
    }
  }
}
