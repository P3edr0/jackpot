import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/data/datasources/auth/check_credential_datasource_impl.dart';
import 'package:jackpot/data/datasources/auth/create_user_datasource_impl.dart';
import 'package:jackpot/data/datasources/auth/login_datasource_impl.dart';
import 'package:jackpot/data/datasources/base_datasources/auth/check_credential_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/auth/create_user_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/auth/login_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/championship/get_championship_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/complements/country_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/fetch_all_team_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/get_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/list_by_championship_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/list_by_team_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/session/create_session.dart';
import 'package:jackpot/data/datasources/base_datasources/session/delete_session.dart';
import 'package:jackpot/data/datasources/base_datasources/session/get_session.dart';
import 'package:jackpot/data/datasources/base_datasources/team/get_team_datasource.dart';
import 'package:jackpot/data/datasources/championship/get_championship_datasource_impl.dart';
import 'package:jackpot/data/datasources/complements/country_datasource_impl.dart';
import 'package:jackpot/data/datasources/jackpot/get_jackpot_datasource_impl.dart';
import 'package:jackpot/data/datasources/local/secure_storage/create_session.dart';
import 'package:jackpot/data/datasources/local/secure_storage/delete_session.dart';
import 'package:jackpot/data/datasources/local/secure_storage/get_session.dart';
import 'package:jackpot/data/datasources/team/fetch_all_team_jackpot_datasource_impl.dart';
import 'package:jackpot/data/datasources/team/get_team_datasource_impl.dart';
import 'package:jackpot/data/datasources/team/list_by_championship_jackpot_datasource_impl.dart';
import 'package:jackpot/data/datasources/team/list_by_team_jackpot_datasource_impl.dart';
import 'package:jackpot/data/repositories/auth/create_user/create_user_repository_impl.dart';
import 'package:jackpot/data/repositories/auth/login/login_repository_impl.dart';
import 'package:jackpot/data/repositories/championship/championship_repository_impl.dart';
import 'package:jackpot/data/repositories/complements/country_repository_impl.dart';
import 'package:jackpot/data/repositories/jackpot/jackpot_repository_impl.dart';
import 'package:jackpot/data/repositories/session/create_session_repository_impl.dart';
import 'package:jackpot/data/repositories/session/delete_session_repository_impl.dart';
import 'package:jackpot/data/repositories/session/get_session_repository_impl.dart';
import 'package:jackpot/data/repositories/team/team_repository_impl.dart';
import 'package:jackpot/domain/repositories/auth/auth_repository.dart';
import 'package:jackpot/domain/repositories/championship/championship_repository.dart';
import 'package:jackpot/domain/repositories/complements/login_repository.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';
import 'package:jackpot/domain/repositories/session/session_repository.dart';
import 'package:jackpot/domain/repositories/team/team_repository.dart';
import 'package:jackpot/domain/usecases/auth/complements/country_usecase.dart';
import 'package:jackpot/domain/usecases/auth/create_user/create_user_usecase.dart';
import 'package:jackpot/domain/usecases/auth/login/check_credential_usecase.dart';
import 'package:jackpot/domain/usecases/auth/login/login_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/fetch_all_team_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/get_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/list_by_championship_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/list_by_team_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/session/create_session_usecase.dart';
import 'package:jackpot/domain/usecases/session/delete_session_usecase.dart';
import 'package:jackpot/domain/usecases/session/get_session_usecase.dart';
import 'package:jackpot/presenter/features/auth/create_user/create_user_store/create_user_controller.dart';
import 'package:jackpot/presenter/features/auth/create_user/face_detector/store/face_capture_controller.dart';
import 'package:jackpot/presenter/features/auth/create_user/step_one/store/create_user_step_one_controller.dart';
import 'package:jackpot/presenter/features/auth/create_user/step_two/store/create_user_step_two_controller.dart';
import 'package:jackpot/presenter/features/auth/login/login_store/login_controller.dart';
import 'package:jackpot/presenter/features/auth/login/pages/credential/store/credential_controller.dart';
import 'package:jackpot/presenter/features/auth/login/pages/password/store/password_controller.dart';
import 'package:jackpot/presenter/features/home/pages/home/store/home_controller.dart';
import 'package:jackpot/presenter/features/home/pages/profile/store/profile_controller.dart';
import 'package:jackpot/presenter/features/jackpot/coupon_select/store/coupon_select_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_championship/store/jackpot_championship_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_questions/store/jackpot_questions_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_team/store/jackpot_team_controller.dart';
import 'package:jackpot/presenter/features/jackpot/store/jackpot_controller.dart';
import 'package:jackpot/presenter/features/lgpd/pages/viewer_docs/store/viewer_docs_controller.dart';
import 'package:jackpot/services/cep_service/cep_service.dart';
import 'package:jackpot/services/cep_service/viacep_service_impl.dart';
import 'package:provider/provider.dart';

class Providers {
  static final providers = [
    //////////////// CREATE SESSION  //////////////////////////////
    Provider<ICreateSessionDatasource>(
      create: (ctx) => SecureStorageCreateSession(),
    ),
    Provider<ICreateSessionRepository>(
      create: (ctx) => CreateSessionRepositoryImpl(
          Provider.of<ICreateSessionDatasource>(ctx, listen: false)),
    ),
    ProxyProvider<ICreateSessionRepository, CreateSessionUseCase>(
      create: (ctx) => CreateSessionUseCase(
        repository: Provider.of<ICreateSessionRepository>(ctx, listen: false),
      ),
      update: (ctx, repository, __) => CreateSessionUseCase(
          repository:
              Provider.of<ICreateSessionRepository>(ctx, listen: false)),
    ),
//////////////// GET SESSION  //////////////////////////////
    Provider<IGetSessionDatasource>(
      create: (ctx) => SecureStorageGetSession(),
    ),
    Provider<IGetSessionRepository>(
      create: (ctx) => GetSessionRepositoryImpl(
          Provider.of<IGetSessionDatasource>(ctx, listen: false)),
    ),
    ProxyProvider<IGetSessionRepository, GetSessionUseCase>(
      create: (ctx) => GetSessionUseCase(
        repository: Provider.of<IGetSessionRepository>(ctx, listen: false),
      ),
      update: (ctx, repository, __) => GetSessionUseCase(
          repository: Provider.of<IGetSessionRepository>(ctx, listen: false)),
    ),

//////////////// DELETE SESSION  //////////////////////////////
    Provider<IDeleteSessionDatasource>(
      create: (ctx) => SecureStorageDeleteSession(),
    ),
    Provider<IDeleteSessionRepository>(
      create: (ctx) => DeleteSessionRepositoryImpl(
          Provider.of<IDeleteSessionDatasource>(ctx, listen: false)),
    ),
    ProxyProvider<IDeleteSessionRepository, DeleteSessionUseCase>(
      create: (ctx) => DeleteSessionUseCase(
        repository: Provider.of<IDeleteSessionRepository>(ctx, listen: false),
      ),
      update: (ctx, repository, __) => DeleteSessionUseCase(
          repository:
              Provider.of<IDeleteSessionRepository>(ctx, listen: false)),
    ),

//////////////// HOME  //////////////////////////////

    Provider<IFetchAllTeamJackpotDatasource>(
      create: (ctx) => FetchAllTeamJackpotDatasourceImpl(),
    ),
    Provider<IFetchAllTeamJackpotRepository>(
      create: (ctx) => FetchAllTeamJackpotRepositoryImpl(
          datasource:
              Provider.of<IFetchAllTeamJackpotDatasource>(ctx, listen: false)),
    ),
    Provider<FetchAllTeamJackpotUsecase>(
      create: (ctx) => FetchAllTeamJackpotUsecase(
        repository:
            Provider.of<IFetchAllTeamJackpotRepository>(ctx, listen: false),
      ),
    ),

    ChangeNotifierProvider<HomeController>(
      create: (ctx) => HomeController(
        fetchAllTeamJackpotUsecase:
            Provider.of<FetchAllTeamJackpotUsecase>(ctx, listen: false),
      ),
    ),
    ChangeNotifierProvider<ViewerDocsController>(
      create: (ctx) => ViewerDocsController(),
    ),
    ChangeNotifierProvider<ProfileController>(
      create: (ctx) => ProfileController(),
    ),
//////////////// LOGIN  //////////////////////////////
// ADDRESS  //////////////////////////////
    Provider<CepService>(
      create: (ctx) => ViaCepServiceImpl(),
    ),
// CHECK CREDENTIAL  //////////////////////////////
    Provider<ICheckCredentialDatasource>(
      create: (ctx) => CheckCredentialDatasource(),
    ),
    Provider<ICheckCredentialRepository>(
      create: (ctx) => CheckCredentialRepositoryImpl(
          datasource:
              Provider.of<ICheckCredentialDatasource>(ctx, listen: false)),
    ),
    Provider<CheckCredentialUsecase>(
      create: (ctx) => CheckCredentialUsecase(
        repository: Provider.of<ICheckCredentialRepository>(ctx, listen: false),
      ),
    ),

// LOGIN /////////////////////////////
    Provider<ILoginDatasource>(
      create: (ctx) => LoginDatasourceImpl(),
    ),
    Provider<ILoginRepository>(
      create: (ctx) => LoginRepositoryImpl(
          datasource: Provider.of<ILoginDatasource>(ctx, listen: false)),
    ),
    Provider<LoginUsecase>(
      create: (ctx) => LoginUsecase(
        repository: Provider.of<ILoginRepository>(ctx, listen: false),
      ),
    ),
// CREDENTIAL /////////////////////////////
    ChangeNotifierProvider<CredentialController>(
      create: (ctx) => CredentialController(
        checkCredentialUsecase:
            Provider.of<CheckCredentialUsecase>(ctx, listen: false),
      ),
    ),
// COUNTRY /////////////////////////////
    Provider<ICountryDatasource>(
      create: (ctx) => CountryDatasourceImpl(),
    ),
    Provider<ICountryRepository>(
      create: (ctx) => CountryRepositoryImpl(
          datasource: Provider.of<ICountryDatasource>(ctx, listen: false)),
    ),
    Provider<CountryUsecase>(
      create: (ctx) => CountryUsecase(
        repository: Provider.of<ICountryRepository>(ctx, listen: false),
      ),
    ),
// CREATE USER /////////////////////////////

    ChangeNotifierProvider<CreateUserStepOneController>(
      create: (ctx) => CreateUserStepOneController(
        countryUsecase: Provider.of<CountryUsecase>(ctx, listen: false),
        checkCredentialUsecase:
            Provider.of<CheckCredentialUsecase>(ctx, listen: false),
      ),
    ),
    ChangeNotifierProvider<CreateUserStepTwoController>(
      create: (ctx) => CreateUserStepTwoController(
        cepService: Provider.of<CepService>(ctx, listen: false),
        checkCredentialUsecase:
            Provider.of<CheckCredentialUsecase>(ctx, listen: false),
      ),
    ),
// CAPTURE USER IMAGE /////////////////////////////
    ChangeNotifierProvider<FaceCaptureController>(
      create: (ctx) => FaceCaptureController(),
    ),
// CREATEUSER /////////////////////////////

    Provider<ICreateUserDatasource>(
      create: (ctx) => CreateUserDatasourceImpl(),
    ),
    Provider<ICreateUserRepository>(
      create: (ctx) => CreateUserRepositoryImpl(
          datasource: Provider.of<ICreateUserDatasource>(ctx, listen: false)),
    ),
    Provider<CreateUserUsecase>(
      create: (ctx) => CreateUserUsecase(
        repository: Provider.of<ICreateUserRepository>(ctx, listen: false),
      ),
    ),

    ChangeNotifierProxyProvider4<
        CreateUserStepOneController,
        CreateUserStepTwoController,
        FaceCaptureController,
        CreateUserUsecase,
        CreateUserController>(
      create: (ctx) => CreateUserController(
        createUserStepOneController:
            Provider.of<CreateUserStepOneController>(ctx, listen: false),
        createUserStepTwoController:
            Provider.of<CreateUserStepTwoController>(ctx, listen: false),
        faceCaptureController:
            Provider.of<FaceCaptureController>(ctx, listen: false),
        createUserUsecase: Provider.of<CreateUserUsecase>(ctx, listen: false),
      ),
      update: (ctx, createUserStepOneController, createUserStepTwoController,
              faceCaptureController, createUserUsecase, createUserController) =>
          CreateUserController(
        createUserStepOneController:
            Provider.of<CreateUserStepOneController>(ctx, listen: false),
        createUserStepTwoController:
            Provider.of<CreateUserStepTwoController>(ctx, listen: false),
        faceCaptureController:
            Provider.of<FaceCaptureController>(ctx, listen: false),
        createUserUsecase: Provider.of<CreateUserUsecase>(ctx, listen: false),
      ),
    ),
// PASSWORD /////////////////////////////
    ChangeNotifierProvider<PasswordController>(
      create: (ctx) => PasswordController(
        loginUsecase: Provider.of<LoginUsecase>(ctx, listen: false),
        createSessionUseCase:
            Provider.of<CreateSessionUseCase>(ctx, listen: false),
        deleteSessionUseCase:
            Provider.of<DeleteSessionUseCase>(ctx, listen: false),
      ),
    ),

// LOGIN /////////////////////////////
    ChangeNotifierProvider<LoginController>(
      create: (ctx) => LoginController(
        credentialController:
            Provider.of<CredentialController>(ctx, listen: false),
        passwordController: Provider.of<PasswordController>(ctx, listen: false),
      ),
    ),
// LOGIN /////////////////////////////
    ChangeNotifierProvider<CoreController>(
      create: (ctx) => CoreController(
        loginController: Provider.of<LoginController>(ctx, listen: false),
        getSessionUseCase: Provider.of<GetSessionUseCase>(ctx, listen: false),
        deleteSessionUseCase:
            Provider.of<DeleteSessionUseCase>(ctx, listen: false),
      ),
    ),
// COUPON /////////////////////////////
    ChangeNotifierProvider<CouponSelectController>(
      create: (ctx) => CouponSelectController(),
    ),
// QUESTIONS /////////////////////////////
    ChangeNotifierProvider<JackpotQuestionsController>(
      create: (ctx) => JackpotQuestionsController(),
    ),
// JACKPOT /////////////////////////////

    Provider<IGetTeamDatasource>(
      create: (ctx) => GetTeamDatasourceImpl(),
    ),
    Provider<IGetTeamRepository>(
      create: (ctx) => GetTeamRepositoryImpl(
          datasource: Provider.of<IGetTeamDatasource>(ctx, listen: false)),
    ),
    Provider<IGetChampionshipDatasource>(
      create: (ctx) => GetChampionshipDatasourceImpl(),
    ),
    Provider<IGetChampionshipRepository>(
      create: (ctx) => GetChampionshipRepositoryImpl(
          datasource:
              Provider.of<IGetChampionshipDatasource>(ctx, listen: false)),
    ),

    Provider<IGetJackpotDatasource>(
      create: (ctx) => GetJackpotDatasourceImpl(),
    ),
    Provider<IGetJackpotRepository>(
      create: (ctx) => GetJackpotRepositoryImpl(
          datasource: Provider.of<IGetJackpotDatasource>(ctx, listen: false)),
    ),
    Provider<GetJackpotUsecase>(
      create: (ctx) => GetJackpotUsecase(
        repository: Provider.of<IGetJackpotRepository>(ctx, listen: false),
        teamRepository: Provider.of<IGetTeamRepository>(ctx, listen: false),
        championshipRepository:
            Provider.of<IGetChampionshipRepository>(ctx, listen: false),
        fetchAllTeamJackpotRepository:
            Provider.of<IFetchAllTeamJackpotRepository>(ctx, listen: false),
      ),
    ),

    Provider<IListByTeamJackpotDatasource>(
      create: (ctx) => ListByTeamJackpotDatasourceImpl(),
    ),
    Provider<IListByTeamJackpotRepository>(
      create: (ctx) => ListByTeamJackpotRepositoryImpl(
          datasource:
              Provider.of<IListByTeamJackpotDatasource>(ctx, listen: false)),
    ),
    Provider<ListByTeamJackpotUsecase>(
      create: (ctx) => ListByTeamJackpotUsecase(
        repository:
            Provider.of<IListByTeamJackpotRepository>(ctx, listen: false),
      ),
    ),
    Provider<IListByChampionshipJackpotDatasource>(
      create: (ctx) => ListByChampionshipJackpotDatasourceImpl(),
    ),
    Provider<IListByChampionshipJackpotRepository>(
      create: (ctx) => ListByChampionshipJackpotRepositoryImpl(
          datasource: Provider.of<IListByChampionshipJackpotDatasource>(ctx,
              listen: false)),
    ),
    Provider<ListByChampionshipJackpotUsecase>(
      create: (ctx) => ListByChampionshipJackpotUsecase(
        repository: Provider.of<IListByChampionshipJackpotRepository>(ctx,
            listen: false),
      ),
    ),

    ChangeNotifierProvider<JackpotTeamController>(
      create: (ctx) => JackpotTeamController(
        getJackpotUsecase: Provider.of<GetJackpotUsecase>(ctx, listen: false),
        listByTeamJackpotUsecase:
            Provider.of<ListByTeamJackpotUsecase>(ctx, listen: false),
      ),
    ),
    ChangeNotifierProvider<JackpotChampionshipController>(
      create: (ctx) => JackpotChampionshipController(
        getJackpotUsecase: Provider.of<GetJackpotUsecase>(ctx, listen: false),
        listByChampionshipJackpotUsecase:
            Provider.of<ListByChampionshipJackpotUsecase>(ctx, listen: false),
      ),
    ),
    ChangeNotifierProvider<JackpotController>(
      create: (ctx) => JackpotController(
        jackpotChampionshipController:
            Provider.of<JackpotChampionshipController>(ctx, listen: false),
        jackpotTeamController:
            Provider.of<JackpotTeamController>(ctx, listen: false),
      ),
    ),
  ];
}
