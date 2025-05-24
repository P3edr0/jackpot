import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/entities/session_entity.dart';
import 'package:jackpot/domain/entities/user_entity.dart';
import 'package:jackpot/domain/usecases/auth/login/login_usecase.dart';
import 'package:jackpot/domain/usecases/session/create_session_usecase.dart';
import 'package:jackpot/domain/usecases/session/delete_session_usecase.dart';
import 'package:jackpot/shared/utils/enums/credential_type.dart';
import 'package:jackpot/shared/utils/validators/password_validator.dart';

class PasswordController extends ChangeNotifier {
  PasswordController(
      {required this.loginUsecase,
      required this.createSessionUseCase,
      required this.deleteSessionUseCase});
  /////////////////////////// VARS ////////////////////////////////////
  final LoginUsecase loginUsecase;
  final CreateSessionUseCase createSessionUseCase;
  final DeleteSessionUseCase deleteSessionUseCase;
  String? exception;
  UserEntity? _currentUser;
  bool _loading = false;
  bool _isObscurePassword = true;
  final TextEditingController _passwordController = TextEditingController();
  CredentialType currentCredentialType = CredentialType.document;
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  /////////////////////////// GETS ////////////////////////////////////
  TextEditingController get passwordController => _passwordController;
  GlobalKey<FormState> get passwordKey => _passwordKey;
  UserEntity? get currentUser => _currentUser;
  bool get hasError => exception != null;
  bool get loading => _loading;
  bool get isObscurePassword => _isObscurePassword;
  /////////////////////////// FUNCTIONS ////////////////////////////////////

  Future<NewUserEntity?> login(String credential) async {
    setLoading();
    final password = passwordController.text;

    final response = await loginUsecase(credential, password);

    return response.fold((error) {
      exception = error.message;
      setLoading();

      return null;
    }, (user) async {
      createSession(
          credential: credential, password: password, image: user.image!);
      exception = null;
      setLoading();
      return user;
    });
  }

  Future<NewUserEntity?> externalLogin(
      String credential, String password) async {
    setLoading();

    final response = await loginUsecase(credential, password);

    return response.fold((error) {
      exception = error.message;
      setLoading();

      return null;
    }, (user) async {
      createSession(
          credential: credential, password: password, image: user.image!);
      exception = null;
      setLoading();
      return user;
    });
  }

  Future createSession(
      {required String password,
      required String credential,
      required String image}) async {
    final session =
        SessionEntity(credential: credential, image: image, password: password);

    await createSessionUseCase(session);
  }

  String? validPassword() {
    final String content = passwordController.text;
    final validator = PasswordValidator();
    final response = validator(content);
    return response;
  }

  bool verifyPassword() {
    if (!passwordKey.currentState!.validate()) return false;

    return true;
  }

  void clearPassword() {
    passwordController.clear();
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
}
