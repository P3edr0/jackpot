import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/country_entity.dart';
import 'package:jackpot/domain/entities/quick_purchase_user_entity.dart';
import 'package:jackpot/domain/entities/user_entity.dart';
import 'package:jackpot/domain/usecases/auth/complements/country_usecase.dart';
import 'package:jackpot/domain/usecases/auth/login/check_credential_usecase.dart';
import 'package:jackpot/shared/utils/enums/credential_type.dart';
import 'package:jackpot/shared/utils/formatters/cpf_formatter.dart';
import 'package:jackpot/shared/utils/validators/credential_validator.dart';

class QuickPurchaseController extends ChangeNotifier {
  QuickPurchaseController(
      {required this.countryUsecase, required this.checkCredentialUsecase});

  CountryUsecase countryUsecase;
  CheckCredentialUsecase checkCredentialUsecase;

  //////////////////////// VARS //////////////////////////////
  bool _isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? exception;
  UserEntity? _tempUser;
  List<CountryEntity> _countries = [];
  TextEditingController documentController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nationalityController =
      TextEditingController(text: 'Brasil');

  //////////////////////// GETS //////////////////////////////
  bool get isLoading => _isLoading;
  List<CountryEntity> get countries => _countries;
  bool get hasError => exception != null;

  //////////////////////// FUNCTIONS //////////////////////////////

  setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<void> fetchCountries() async {
    setLoading();

    final response = await countryUsecase();

    return response.fold((error) {
      exception = error.message;
      setLoading();
    }, (newCountries) {
      exception = null;
      _countries = newCountries;
      setLoading();
    });
  }

  Future<void> checkDocument() async {
    String document = documentController.text.replaceAll(RegExp('[.-]+'), '');

    final response =
        await checkCredentialUsecase(document, CredentialType.document);

    response.fold((error) {
      exception = error.message;
      documentController.clear();
      notifyListeners();
      return null;
    }, (user) {
      if (user.haveProfile!) {
        exception = "O documento inserido já está cadastrado.";
        documentController.clear();
        notifyListeners();
        return null;
      } else {
        if (exception != null) exception = null;
        _tempUser = user;
        notifyListeners();
      }
    });
  }

  Future<void> checkEmail() async {
    String document = emailController.text;
    final isValidEmail = validEmail();
    if (isValidEmail != null) return;
    final response =
        await checkCredentialUsecase(document, CredentialType.email);

    return response.fold((error) {
      exception = error.message;
      documentController.clear();
      notifyListeners();
      return null;
    }, (user) {
      if (user.haveProfile!) {
        exception = "O email inserido já está cadastrado.";
        emailController.clear();
        notifyListeners();
      } else if (exception != null) {
        exception = null;

        notifyListeners();
      }
    });
  }

  String? validEmail() {
    final String content = emailController.text;
    final validator = CredentialValidator();
    final response = validator(true, content);
    return response;
  }

  QuickPurchaseUserEntity generateQuickUser() {
    final document = documentController.text.replaceAll(RegExp('[.-]+'), '');
    final email = emailController.text;
    String phone = phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final name = _tempUser!.name!;
    final quickUser = QuickPurchaseUserEntity(
        document: document, email: email, phone: phone, name: name);
    return quickUser;
  }

  String? validDocument() {
    final String content = documentController.text;
    final validator = CredentialValidator();
    final response = validator(false, content);
    return response;
  }

  bool verifyForm() {
    if (!formKey.currentState!.validate()) return false;

    return true;
  }

  setDocumentMask() {
    documentController.value =
        CpfFormatter.maskFormatter.updateMask(mask: "###.###.###-##");
  }

  //////////////////////// SETS //////////////////////////////
}
