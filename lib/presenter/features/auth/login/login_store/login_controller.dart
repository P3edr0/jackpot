import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/entities/user_entity.dart';
import 'package:jackpot/presenter/features/auth/login/pages/credential/store/credential_controller.dart';
import 'package:jackpot/presenter/features/auth/login/pages/password/store/password_controller.dart';
import 'package:jackpot/shared/utils/enums/credential_type.dart';

class LoginController extends ChangeNotifier {
  LoginController({
    required this.credentialController,
    required this.passwordController,
  });
  /////////////////////////// VARS ////////////////////////////////////
  final CredentialController credentialController;
  final PasswordController passwordController;

  String? exception;
  UserEntity? _currentCredentialUser;
  NewUserEntity? _currentUser;
  final bool _loading = false;

  /////////////////////////// GETS ////////////////////////////////////

  UserEntity? get currentCredentialUser => _currentCredentialUser;
  bool get hasError => exception != null;
  bool get loading => _loading;
  /////////////////////////// FUNCTIONS ////////////////////////////////////

  Future<bool> checkCredential() async {
    _currentCredentialUser = await credentialController.checkCredential();
    if (_currentCredentialUser == null) return false;

    if (_currentCredentialUser!.haveProfile!) {
      exception = null;
      return true;
    }
    return false;
  }

  Future<NewUserEntity?> login() async {
    String credential;
    if (credentialController.currentCredentialType.isDocument) {
      credential =
          currentCredentialUser!.document!.replaceAll(RegExp('[.-]+'), '');
    } else {
      credential = currentCredentialUser!.email!;
    }
    final response = await passwordController.login(credential);
    _currentUser = response;

    if (_currentUser != null) {
      clearLoginFields();

      return _currentUser;
    }
    return null;
  }

  Future<NewUserEntity?> externalLogin(
      String credential, String password, CredentialType type) async {
    String newCredential;
    if (type.isDocument) {
      newCredential = credential.replaceAll(RegExp('[.-]+'), '');
    } else {
      newCredential = credential;
    }
    final response =
        await passwordController.externalLogin(newCredential, password);
    _currentUser = response;

    if (_currentUser != null) return _currentUser;
    return null;
  }

  void clearLoginFields() {
    credentialController.clearCredential();
    passwordController.clearPassword();
  }
  /////////////////////////// SETS ////////////////////////////////////
}
