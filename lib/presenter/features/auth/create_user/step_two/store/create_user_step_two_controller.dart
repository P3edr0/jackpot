import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/address_entity.dart';
import 'package:jackpot/domain/entities/country_entity.dart';
import 'package:jackpot/domain/entities/user_entity.dart';
import 'package:jackpot/domain/usecases/auth/login/check_credential_usecase.dart';
import 'package:jackpot/services/cep_service/cep_service.dart';
import 'package:jackpot/shared/utils/enums/genders.dart';
import 'package:jackpot/shared/utils/validators/credential_validator.dart';

class CreateUserStepTwoController extends ChangeNotifier {
  CreateUserStepTwoController(
      {required this.cepService, required this.checkCredentialUsecase});
  /////////////////////////// VARS ////////////////////////////////////
  final CepService cepService;
  final CheckCredentialUsecase checkCredentialUsecase;
  String? exception;
  Genders _selectedGender = Genders.male;
  int? cityCode;
  final List<CountryEntity> _countries = [];
  UserEntity? _currentUser;
  bool _loading = false;
  bool _showDateError = false;
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _complementController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  /////////////////////////// GETS ////////////////////////////////////
  TextEditingController get cepController => _cepController;
  TextEditingController get complementController => _complementController;
  TextEditingController get emailController => _emailController;
  TextEditingController get cityController => _cityController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get stateController => _stateController;

  TextEditingController get neighborhoodController => _neighborhoodController;
  TextEditingController get streetController => _streetController;
  TextEditingController get numberController => _numberController;

  GlobalKey<FormState> get formKey => _formKey;
  UserEntity? get currentUser => _currentUser;
  bool get hasError => exception != null;
  bool get loading => _loading;
  Genders get selectedGender => _selectedGender;
  bool get isObscurePassword => _isObscurePassword;
  bool get isObscureConfirmPassword => _isObscureConfirmPassword;
  bool get showDateError => _showDateError;
  List<CountryEntity> get countries => _countries;
  AddressEntity get address => _address();
  /////////////////////////// FUNCTIONS ////////////////////////////////////

  AddressEntity _address() {
    return AddressEntity(
        cep: cepController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        complement: complementController.text,
        street: streetController.text,
        neighborhood: neighborhoodController.text,
        city: cityController.text,
        state: stateController.text,
        cityCode: cityCode,
        number: numberController.text);
  }

  Future<void> getCepAddress() async {
    final String cep = cepController.text.replaceAll(RegExp('[.-]+'), '');
    final response = await cepService(cep);

    return response.fold((error) {
      exception = error.message;
      cepController.clear();
      notifyListeners();
    }, (address) {
      exception = null;
      setAddress(address);
      notifyListeners();
    });
  }

  bool verifyForm() {
    if (!formKey.currentState!.validate()) return false;

    return true;
  }

  String? validEmail() {
    final String content = emailController.text;
    final validator = CredentialValidator();
    final response = validator(true, content);
    return response;
  }

  /////////////////////////// SETS ////////////////////////////////////
  void setAddress(AddressEntity address) {
    streetController.text = address.street;
    neighborhoodController.text = address.neighborhood;
    stateController.text = address.state;
    cityController.text = address.city;
    cityCode = address.cityCode;
  }

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
