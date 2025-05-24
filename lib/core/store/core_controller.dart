import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jackpot/data/datasources/auth/delete_user_datasource_impl.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/entities/session_entity.dart';
import 'package:jackpot/domain/usecases/session/delete_session_usecase.dart';
import 'package:jackpot/domain/usecases/session/get_session_usecase.dart';
import 'package:jackpot/presenter/features/auth/login/login_store/login_controller.dart';
import 'package:jackpot/shared/utils/enums/credential_type.dart';

class CoreController extends ChangeNotifier {
  CoreController({
    required this.loginController,
    required this.getSessionUseCase,
    required this.deleteSessionUseCase,
  });

  ////////////////// VARS /////////////////////////
  final LoginController loginController;
  final GetSessionUseCase getSessionUseCase;
  final DeleteSessionUseCase deleteSessionUseCase;
  String recovererPasswordContent = '';

  NewUserEntity? _currentUser;
  SessionEntity? _currentSession;
  ////////////////// FUNCTIONS /////////////////////////

  Future<void> login() async {
    final newUser = await loginController.login();
    _currentUser = newUser;

    notifyListeners();
  }

  Future<bool> deleteAccount() async {
    final datasource = DeleteUserDatasourceImpl();
    final id = _currentUser!.id!.toString();
    final response = await datasource(id);
    response.fold(
      (l) {
        return false;
      },
      (r) {
        logout();
        return true;
      },
    );
    return false;
  }

  Future<SessionEntity?> getSession() async {
    final response = await getSessionUseCase();
    return response.fold((l) {
      log(l.message);
      return null;
    }, (data) {
      _currentSession = data;
      return data;
    });
  }

  void logout() async {
    final response = await deleteSessionUseCase.call();
    response.fold((exception) {}, (success) {
      if (success) {
        _currentUser = null;
        _currentSession = null;
        notifyListeners();
      }
    });
  }

  Future<String?> loginSession() async {
    if (recovererPasswordContent != currentSession!.password) {
      return 'Senha inválida';
    }

    setLoading();
    await Future.delayed(Durations.extralong4);
    await externalLogin(currentSession!.credential, recovererPasswordContent,
        CredentialType.email);
    setLoading();
    return null;
  }

  Future<void> externalLogin(
      String credential, String password, CredentialType type) async {
    final newUser =
        await loginController.externalLogin(credential, password, type);
    _currentUser = newUser;

    notifyListeners();
  }

  Future<void> getUser(
      String credential, String password, CredentialType type) async {
    final newUser =
        await loginController.externalLogin(credential, password, type);
    _currentUser = newUser;
    notifyListeners();
  }

  ////////////////// GETS /////////////////////////

  bool get haveUser => _currentUser != null;
  bool get haveSession => _currentSession != null;
  NewUserEntity? get user => _currentUser;
  SessionEntity? get currentSession => _currentSession;

  ////////////////// SETS /////////////////////////
  int? setRecoverPassword(String letter, [isBackspace = false]) {
    if (isBackspace) {
      final size = recovererPasswordContent.length;
      if (size == 0) return null;
      recovererPasswordContent =
          recovererPasswordContent.substring(0, size - 1);
      notifyListeners();
      return null;
    }
    if (recovererPasswordContent.length == 6) return null;
    recovererPasswordContent += letter;
    notifyListeners();
    return recovererPasswordContent.length;
  }

  void clearRecovererPasswordContent() {
    recovererPasswordContent = '';
  }

  ////////////////////////// TEMP RECOVER PASSWORD ////////////////////
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
