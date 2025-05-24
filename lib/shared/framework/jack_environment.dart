abstract class JackEnvironment {
  // Url
  static const apiUrl = String.fromEnvironment(
    'api_url',
  );
  static const apiUzerpass = String.fromEnvironment(
    'api_uzerpass',
  );
  static const deviceId = String.fromEnvironment(
    'device_id',
  );
}
