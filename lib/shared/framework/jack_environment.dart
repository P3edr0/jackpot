abstract class JackEnvironment {
  // Url
  static const apiUrl = String.fromEnvironment(
    'api_url',
  );
  static const paymentApi = String.fromEnvironment(
    'payment_api',
  );
  static const paymentApiKey = String.fromEnvironment(
    'payment_api_key',
  );
  static const paymentExternalApi = String.fromEnvironment(
    'payment_external_api',
  );
  static const paymentExternalToken = String.fromEnvironment(
    'payment_external_token',
  );
  static const apiUzerpass = String.fromEnvironment(
    'api_uzerpass',
  );
  static const deviceId = String.fromEnvironment(
    'device_id',
  );
}
