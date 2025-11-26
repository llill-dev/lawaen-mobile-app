import 'dart:convert';

class JwtHelper {
  /// Decode the JWT payload (middle part) into a Map
  static Map<String, dynamic>? decodePayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      return jsonDecode(decoded) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Get expiry from "exp" claim (seconds since epoch)
  static DateTime? getExpiry(String token) {
    final payload = decodePayload(token);
    if (payload == null) return null;

    final exp = payload['exp'];
    if (exp is int) {
      return DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true);
    }
    if (exp is String) {
      final parsed = int.tryParse(exp);
      if (parsed != null) {
        return DateTime.fromMillisecondsSinceEpoch(parsed * 1000, isUtc: true);
      }
    }
    return null;
  }

  /// Is token expired? (optional small leeway for clock skew)
  static bool isExpired(String token, {Duration leeway = Duration.zero}) {
    final expiry = getExpiry(token);
    if (expiry == null) return true; // if we can't read it, treat as expired
    final now = DateTime.now().toUtc();
    return now.isAfter(expiry.subtract(leeway));
  }

  /// Convenience: is token valid & not expired?
  static bool isValid(String token, {Duration leeway = Duration.zero}) {
    if (token.isEmpty) return false;
    return !isExpired(token, leeway: leeway);
  }
}
