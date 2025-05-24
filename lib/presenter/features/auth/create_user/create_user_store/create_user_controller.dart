import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/mappers/new_user_mapper.dart';
import 'package:jackpot/domain/usecases/auth/create_user/create_user_usecase.dart';
import 'package:jackpot/presenter/features/auth/create_user/face_detector/store/face_capture_controller.dart';
import 'package:jackpot/presenter/features/auth/create_user/step_one/store/create_user_step_one_controller.dart';
import 'package:jackpot/presenter/features/auth/create_user/step_two/store/create_user_step_two_controller.dart';

class CreateUserController extends ChangeNotifier {
  CreateUserController({
    required this.faceCaptureController,
    required this.createUserStepOneController,
    required this.createUserStepTwoController,
    required this.createUserUsecase,
  });
  /////////////////////////// VARS ////////////////////////////////////
  CreateUserStepOneController createUserStepOneController;
  CreateUserStepTwoController createUserStepTwoController;
  FaceCaptureController faceCaptureController;
  CreateUserUsecase createUserUsecase;

  String? exception;
  bool _loading = false;
  bool _isEmail = false;
  bool _acceptTerms = false;
  bool _userCreated = false;
  String? credential;

  /////////////////////////// GETS ////////////////////////////////////

  bool get hasError => exception != null;
  bool get loading => _loading;
  bool get userCreated => _userCreated;
  bool get isEmail => _isEmail;
  bool get acceptTerms => _acceptTerms;
  String get email => createUserStepOneController.email;
  String get password => createUserStepOneController.password;

  /////////////////////////// FUNCTIONS ////////////////////////////////////
  void setCredentialEmail(bool nextStepIsEmail, String nextStepCredential) {
    _isEmail = nextStepIsEmail;
    credential = nextStepCredential;
    createUserStepOneController.setCredential(
        nextStepIsEmail, nextStepCredential);
    notifyListeners();
  }

  Future<void> createUser() async {
    setLoading();
    final NewUserEntity newUser = NewUserEntity(
        name: createUserStepOneController.referenceName,
        email: createUserStepOneController.email,
        document: createUserStepOneController.document,
        birthDay: createUserStepOneController.birthDay,
        phoneDDI: createUserStepOneController.ddi,
        phone: createUserStepOneController.phone,
        countryId: createUserStepOneController.countryId,
        uzerId: null,
        password: createUserStepOneController.password,
        documentId: createUserStepOneController.documentId,
        address: createUserStepTwoController.address,
        image: faceCaptureController.base64Image);

    final newUserMapped = NewUserMapper.toJson(newUser);
    debugPrint(newUserMapped.toString());
    final response = await createUserUsecase(newUser);
    response.fold((error) {
      exception = error.message;
      setLoading();
    }, (success) {
      _userCreated = success;
      setLoading();
    });
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

  void setAcceptTerms() {
    _acceptTerms = !_acceptTerms;
    notifyListeners();
  }
}
