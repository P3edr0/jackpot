enum CredentialType {
  document,
  email;

  bool get isDocument => this == document;
  bool get isEmail => this == email;
}
