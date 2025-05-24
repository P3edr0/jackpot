import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/user_entity.dart';
import 'package:jackpot/domain/usecases/auth/login/check_credential_usecase.dart';
import 'package:jackpot/shared/utils/enums/credential_type.dart';
import 'package:jackpot/shared/utils/formatters/cpf_formatter.dart';
import 'package:jackpot/shared/utils/formatters/regx.dart';
import 'package:jackpot/shared/utils/validators/credential_validator.dart';

class CredentialController extends ChangeNotifier {
  CredentialController({required this.checkCredentialUsecase});
  /////////////////////////// VARS ////////////////////////////////////
  final CheckCredentialUsecase checkCredentialUsecase;
  String? exception;
  bool _loading = false;
  final TextEditingController _credentialController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  CredentialType currentCredentialType = CredentialType.document;
  final GlobalKey<FormState> _credentialKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  /////////////////////////// GETS ////////////////////////////////////
  TextEditingController get credentialController => _credentialController;
  TextEditingController get passwordController => _passwordController;
  GlobalKey<FormState> get credentialKey => _credentialKey;
  GlobalKey<FormState> get passwordKey => _passwordKey;
  bool get hasError => exception != null;
  bool get loading => _loading;
  String get credential => _credentialController.text;
  /////////////////////////// FUNCTIONS ////////////////////////////////////

  Future<UserEntity?> checkCredential() async {
    setLoading();
    String credential;
    if (currentCredentialType.isDocument) {
      credential = credentialController.text.replaceAll(RegExp('[.-]+'), '');
    } else {
      credential = credentialController.text;
    }
    final response =
        await checkCredentialUsecase(credential, currentCredentialType);

    return response.fold((error) {
      exception = error.message;
      setLoading();

      return null;
    }, (user) {
      exception = null;
      setLoading();
      return user;
    });
  }

  Future<void> changeCredentialMask() async {
    final validator = CpfFormatter.maskFormatter.getUnmaskedText();
    if (JackRegex.onlyNumbers.hasMatch((validator))) {
      if (currentCredentialType.isDocument) return;
      credentialController.value =
          CpfFormatter.maskFormatter.updateMask(mask: "###.###.###-##");
      currentCredentialType = CredentialType.document;
      notifyListeners();
    } else {
      if (currentCredentialType.isEmail) return;

      credentialController.value =
          CpfFormatter.maskFormatter.updateMask(mask: "");
      currentCredentialType = CredentialType.email;
      notifyListeners();
    }
  }

  String? validCredential() {
    final String content = credentialController.text;
    final validator = CredentialValidator();
    final response = validator(currentCredentialType.isEmail, content);
    return response;
  }

  bool verifyUser() {
    if (!credentialKey.currentState!.validate()) return false;

    return true;
  }

  void clearCredential() {
    credentialController.clear();
  }

  /////////////////////////// SETS ////////////////////////////////////
  void setLoading([bool? newLoading]) {
    if (newLoading == null) {
      _loading = !loading;
      notifyListeners();
    } else {
      if (_loading == newLoading) return;
      _loading = newLoading;
      notifyListeners();
    }
  }
}
