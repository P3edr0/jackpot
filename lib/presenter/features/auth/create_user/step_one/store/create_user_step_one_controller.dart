import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jackpot/domain/entities/country_entity.dart';
import 'package:jackpot/domain/entities/user_entity.dart';
import 'package:jackpot/domain/usecases/auth/complements/country_usecase.dart';
import 'package:jackpot/domain/usecases/auth/login/check_credential_usecase.dart';
import 'package:jackpot/shared/utils/enums/credential_type.dart';
import 'package:jackpot/shared/utils/enums/document_type.dart';
import 'package:jackpot/shared/utils/enums/genders.dart';
import 'package:jackpot/shared/utils/formatters/cpf_formatter.dart';
import 'package:jackpot/shared/utils/validators/credential_validator.dart';
import 'package:jackpot/shared/utils/validators/password_validator.dart';

class CreateUserStepOneController extends ChangeNotifier {
  CreateUserStepOneController(
      {required this.countryUsecase, required this.checkCredentialUsecase});
  /////////////////////////// VARS ////////////////////////////////////

  final CountryUsecase countryUsecase;
  final CheckCredentialUsecase checkCredentialUsecase;
  int? _ddi;
  String? _handledPhone;
  String? _birthDay;
  String? _referenceBirthDay;
  String? _referenceName;
  String? exception;
  Genders _selectedGender = Genders.male;
  final DocumentType _documentType = DocumentType.cpf;
  List<CountryEntity> _countries = [];
  UserEntity? _currentUser;
  bool _loading = false;
  bool _showDateError = false;
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  final TextEditingController _nationalityController =
      TextEditingController(text: 'Brasil');
  final TextEditingController _documentController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  /////////////////////////// GETS ////////////////////////////////////
  TextEditingController get passwordController => _passwordController;
  TextEditingController get nationalityController => _nationalityController;
  TextEditingController get documentController => _documentController;
  TextEditingController get emailController => _emailController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get dayController => _dayController;
  TextEditingController get yearController => _yearController;
  TextEditingController get monthController => _monthController;

  GlobalKey<FormState> get formKey => _formKey;
  UserEntity? get currentUser => _currentUser;
  bool get hasError => exception != null;
  bool get loading => _loading;
  Genders get selectedGender => _selectedGender;
  bool get isObscurePassword => _isObscurePassword;
  bool get isObscureConfirmPassword => _isObscureConfirmPassword;
  bool get showDateError => _showDateError;
  List<CountryEntity> get countries => _countries;
  String? get referenceName => _referenceName;
  String? get referenceBirthDay => _referenceBirthDay;

  /////////////////////////// SHORTCUTS ////////////////////////////////////
  String get password => _passwordController.text;
  String get nationality => _nationalityController.text;
  String get document =>
      _documentController.text.replaceAll(RegExp('[.-]+'), '');
  String get email => _emailController.text;
  String get birthDay => _birthDay!;
  String get phone => _handledPhone!;
  int get documentId => _documentType.getValue();
  int get countryId => getCountryId();
  int get ddi => _ddi!;

  /////////////////////////// FUNCTIONS ////////////////////////////////////

  setDocumentMask() {
    _documentController.value =
        CpfFormatter.maskFormatter.updateMask(mask: "###.###.###-##");
  }

  void setCredential(bool isEmail, String credential) {
    if (isEmail) {
      _emailController.text = credential;
      return;
    }
    _documentController.text = credential;
  }

  int getCountryId() {
    final country =
        countries.firstWhere((country) => country.name == nationality);
    return country.id!;
  }

  void handledPhone() {
    final parts = _phoneController.text.split(' ');
    final ddi = parts.first.replaceAll(RegExp(r'[^0-9]'), '');
    final ddd = parts[1].replaceAll(RegExp(r'[^0-9]'), '');
    final completePhone = parts[2].replaceAll(RegExp(r'[^0-9]'), '');

    final newDdi = int.tryParse(ddi);

    _ddi = newDdi ?? 55;
    _handledPhone = '$ddd$completePhone';
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

  String? validPassword() {
    final String content = passwordController.text;
    final validator = PasswordValidator();
    final response = validator(content);
    return response;
  }

  String? validConfirmPassword() {
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;
    if (password == confirmPassword) return null;

    return "As senhas precisam ser iguais";
  }

  bool validBirthDate() {
    final String day = _dayController.text;
    final String month = _monthController.text;
    final String year = _yearController.text;
    log("Data: $day/$month/$year");
    try {
      final date =
          DateFormat('yyyy-MM-dd').parseStrict('$year-$month-$day', false);
      final refDate =
          DateFormat('yyyy-MM-dd').parseStrict(referenceBirthDay!, false);
      final isValid = refDate.compareTo(date);
      if (isValid == 0) {
        _birthDay = refDate.toUtc().toIso8601String();
        return true;
      }
      exception = 'Data nascimento não corresponde com o CPF informado!';
      return false;
    } catch (e) {
      final formatException = e as FormatException;
      log('exception:${formatException.message}');
      exception = "Data inválida";
      return false;
    }
  }

  Future<UserEntity?> checkDocument() async {
    String document = documentController.text.replaceAll(RegExp('[.-]+'), '');

    final response =
        await checkCredentialUsecase(document, CredentialType.document);

    return response.fold((error) {
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
        _referenceName = user.name;
        _referenceBirthDay = user.birthDay;
        notifyListeners();
        return user;
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

  bool verifyForm() {
    if (!formKey.currentState!.validate()) return false;

    final isValidBirthDate = validBirthDate();
    if (isValidBirthDate) {
      log('Data válida');

      return true;
    }
    log('Data inválida');
    notifyListeners();
    return false;
  }

  String? validEmail() {
    final String content = emailController.text;
    final validator = CredentialValidator();
    final response = validator(true, content);
    return response;
  }

  String? validDocument() {
    final String content = documentController.text;
    final validator = CredentialValidator();
    final response = validator(false, content);
    return response;
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

  void setIsObscurePassword() {
    _isObscurePassword = !_isObscurePassword;
    notifyListeners();
  }

  void setShowDateError() {
    _showDateError = !_showDateError;
    notifyListeners();
  }

  void setIsObscureConfirmPassword() {
    _isObscureConfirmPassword = !_isObscureConfirmPassword;
    notifyListeners();
  }

  void setGender(Genders newGender) {
    _selectedGender = newGender;
    notifyListeners();
  }
}
