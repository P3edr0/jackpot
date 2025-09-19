import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/data/datasources/auth/check_credential_datasource_impl.dart';
import 'package:jackpot/data/datasources/auth/create_user_datasource_impl.dart';
import 'package:jackpot/data/datasources/auth/login_datasource_impl.dart';
import 'package:jackpot/data/datasources/award/fetch_all_awards_datasource_impl.dart';
import 'package:jackpot/data/datasources/base_datasources/auth/check_credential_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/auth/create_user_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/auth/login_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/award/fetch_all_awards_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/bet/get_bet_made_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/bet/get_jackpot_bet_id_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/championship/get_championship_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/complements/country_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/bet/create_bet_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/bet/create_temp_bet_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/bet/delete_temp_bets_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/bet/get_temp_bets_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/extra/fetch_extra_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/fetch_all_resume_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/fetch_all_team_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/get_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/group_by_championship_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/list_by_championship_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/list_by_team_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/payment/card_payment_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/payment/get_payment_public_key_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/payment/get_pix_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/payment/get_pix_status_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/session/create_session.dart';
import 'package:jackpot/data/datasources/base_datasources/session/delete_session.dart';
import 'package:jackpot/data/datasources/base_datasources/session/get_session.dart';
import 'package:jackpot/data/datasources/base_datasources/team/get_team_datasource.dart';
import 'package:jackpot/data/datasources/bet/get_bet_made_datasource_impl.dart';
import 'package:jackpot/data/datasources/bet/get_jackpot_bet_id_datasource_impl.dart';
import 'package:jackpot/data/datasources/championship/get_championship_datasource_impl.dart';
import 'package:jackpot/data/datasources/complements/country_datasource_impl.dart';
import 'package:jackpot/data/datasources/extra/fetch_extra_jackpot_datasource_impl.dart';
import 'package:jackpot/data/datasources/jackpot/create_bet_datasource_impl.dart';
import 'package:jackpot/data/datasources/jackpot/fetch_all_resume_jackpot_datasource_impl.dart';
import 'package:jackpot/data/datasources/jackpot/get_jackpot_datasource_impl.dart';
import 'package:jackpot/data/datasources/local/secure_storage/session/create_session.dart';
import 'package:jackpot/data/datasources/local/secure_storage/session/delete_session.dart';
import 'package:jackpot/data/datasources/local/secure_storage/session/get_session.dart';
import 'package:jackpot/data/datasources/local/secure_storage/temp_bet/delete_temp_bets.dart';
import 'package:jackpot/data/datasources/local/secure_storage/temp_bet/get_temp_bets.dart';
import 'package:jackpot/data/datasources/local/secure_storage/temp_bet/update_temp_bet.dart';
import 'package:jackpot/data/datasources/payment/card_payment_datasource_impl.dart';
import 'package:jackpot/data/datasources/payment/get_payment_public_key_datasource_impl.dart';
import 'package:jackpot/data/datasources/payment/get_pix_datasource_impl.dart';
import 'package:jackpot/data/datasources/payment/get_pix_status_datasource_impl.dart';
import 'package:jackpot/data/datasources/team/fetch_all_team_jackpot_datasource_impl.dart';
import 'package:jackpot/data/datasources/team/get_team_datasource_impl.dart';
import 'package:jackpot/data/datasources/team/group_by_championship_jackpot_datasource_impl.dart';
import 'package:jackpot/data/datasources/team/list_by_championship_jackpot_datasource_impl.dart';
import 'package:jackpot/data/datasources/team/list_by_team_jackpot_datasource_impl.dart';
import 'package:jackpot/data/repositories/auth/create_user/create_user_repository_impl.dart';
import 'package:jackpot/data/repositories/auth/login/login_repository_impl.dart';
import 'package:jackpot/data/repositories/award/award_repository_impl.dart';
import 'package:jackpot/data/repositories/bet/bet_repository_impl.dart';
import 'package:jackpot/data/repositories/championship/championship_repository_impl.dart';
import 'package:jackpot/data/repositories/complements/country_repository_impl.dart';
import 'package:jackpot/data/repositories/jackpot/jackpot_repository_impl.dart';
import 'package:jackpot/data/repositories/payment/payment_repository_impl.dart';
import 'package:jackpot/data/repositories/session/create_session_repository_impl.dart';
import 'package:jackpot/data/repositories/session/delete_session_repository_impl.dart';
import 'package:jackpot/data/repositories/session/get_session_repository_impl.dart';
import 'package:jackpot/data/repositories/team/team_repository_impl.dart';
import 'package:jackpot/domain/repositories/auth/auth_repository.dart';
import 'package:jackpot/domain/repositories/award/award_repository.dart';
import 'package:jackpot/domain/repositories/bet/bet_repository.dart';
import 'package:jackpot/domain/repositories/championship/championship_repository.dart';
import 'package:jackpot/domain/repositories/complements/login_repository.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';
import 'package:jackpot/domain/repositories/payment/payment_repository.dart';
import 'package:jackpot/domain/repositories/session/session_repository.dart';
import 'package:jackpot/domain/repositories/team/team_repository.dart';
import 'package:jackpot/domain/usecases/auth/complements/country_usecase.dart';
import 'package:jackpot/domain/usecases/auth/create_user/create_user_usecase.dart';
import 'package:jackpot/domain/usecases/auth/login/check_credential_usecase.dart';
import 'package:jackpot/domain/usecases/auth/login/login_usecase.dart';
import 'package:jackpot/domain/usecases/award/fetch_all_awards_usecase.dart';
import 'package:jackpot/domain/usecases/bet/get_bet_made_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/bet/create_bet_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/bet/delete_temp_bet_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/bet/get_temp_bets_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/bet/update_temp_bet_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/fetch_all_jackpot_resume_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/fetch_all_team_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/fetch_extra_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/get_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/group_by_championship_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/list_by_championship_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/list_by_team_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/payment/card_payment_usecase.dart';
import 'package:jackpot/domain/usecases/payment/get_payment_public_key_usecase.dart';
import 'package:jackpot/domain/usecases/payment/get_pix_status_usecase.dart';
import 'package:jackpot/domain/usecases/payment/get_pix_usecase.dart';
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
import 'package:jackpot/presenter/features/extra_jackpot/coupon_select/store/extra_coupon_select_controller.dart';
import 'package:jackpot/presenter/features/extra_jackpot/extra_jackpot_controller.dart';
import 'package:jackpot/presenter/features/home/pages/home/store/home_controller.dart';
import 'package:jackpot/presenter/features/home/pages/profile/store/profile_controller.dart';
import 'package:jackpot/presenter/features/jackpot/coupon_select/store/coupon_select_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_championship/store/jackpot_championship_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_questions/store/jackpot_questions_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_team/store/jackpot_team_controller.dart';
import 'package:jackpot/presenter/features/jackpot/my_jackpots/pages/my_jackpots/store/my_jackpots_controller.dart';
import 'package:jackpot/presenter/features/jackpot/my_jackpots/pages/my_jackpots_details/store/my_jackpots_details_controller.dart';
import 'package:jackpot/presenter/features/jackpot/quick_purchase/store/quick_purchase_controller.dart';
import 'package:jackpot/presenter/features/jackpot/store/jackpot_controller.dart';
import 'package:jackpot/presenter/features/lgpd/pages/viewer_docs/store/viewer_docs_controller.dart';
import 'package:jackpot/presenter/features/payment/pages/pix_page/store/pix_controller.dart';
import 'package:jackpot/presenter/features/payment/pages/store/payment_controller.dart';
import 'package:jackpot/presenter/features/shopping_cart/store/shopping_cart_controller.dart';
import 'package:jackpot/services/cep_service/cep_service.dart';
import 'package:jackpot/services/cep_service/viacep_service_impl.dart';
import 'package:jackpot/shared/utils/routes/route_observer.dart';
import 'package:provider/provider.dart';

class Providers {
  static final providers = [
    //////////////// CREATE SESSION  //////////////////////////////
    ChangeNotifierProvider<RouteStackObserver>(
      create: (ctx) => RouteStackObserver.instance(),
    ),
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
    Provider<IGroupByChampionshipJackpotDatasource>(
      create: (ctx) => GroupByChampionshipJackpotDatasourceImpl(),
    ),
    Provider<IGroupByChampionshipJackpotRepository>(
      create: (ctx) => GroupByChampionshipJackpotRepositoryImpl(
          datasource: Provider.of<IGroupByChampionshipJackpotDatasource>(ctx,
              listen: false)),
    ),
    Provider<GroupByChampionshipJackpotUsecase>(
      create: (ctx) => GroupByChampionshipJackpotUsecase(
        repository: Provider.of<IGroupByChampionshipJackpotRepository>(ctx,
            listen: false),
      ),
    ),

//////////////// EXTRA  //////////////////////////////
    Provider<IFetchExtraJackpotDatasource>(
      create: (ctx) => FetchExtraJackpotDatasourceImpl(),
    ),
    Provider<IFetchExtraJackpotRepository>(
      create: (ctx) => FetchExtraJackpotRepositoryImpl(
          datasource:
              Provider.of<IFetchExtraJackpotDatasource>(ctx, listen: false)),
    ),
    Provider<FetchExtraJackpotUsecase>(
      create: (ctx) => FetchExtraJackpotUsecase(
        repository:
            Provider.of<IFetchExtraJackpotRepository>(ctx, listen: false),
      ),
    ),

    ChangeNotifierProvider<HomeController>(
      create: (ctx) => HomeController(
        fetchAllTeamJackpotUsecase:
            Provider.of<FetchAllTeamJackpotUsecase>(ctx, listen: false),
        groupByChampionshipJackpotUsecase:
            Provider.of<GroupByChampionshipJackpotUsecase>(ctx, listen: false),
        fetchExtraJackpotUsecase:
            Provider.of<FetchExtraJackpotUsecase>(ctx, listen: false),
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

// COUPON /////////////////////////////
    ChangeNotifierProvider<CouponSelectController>(
      create: (ctx) => CouponSelectController(),
    ),
    ChangeNotifierProvider<ExtraCouponSelectController>(
      create: (ctx) => ExtraCouponSelectController(),
    ),
// QUESTIONS /////////////////////////////
    ChangeNotifierProvider<JackpotQuestionsController>(
      create: (ctx) => JackpotQuestionsController(),
    ),
// PAYMENT /////////////////////////////
    Provider<IGetPixDatasource>(
      create: (ctx) => GetPixDatasourceImpl(),
    ),
    Provider<IGetPixRepository>(
      create: (ctx) => GetPixRepositoryImpl(
          datasource: Provider.of<IGetPixDatasource>(ctx, listen: false)),
    ),
    Provider<GetPixUsecase>(
      create: (ctx) => GetPixUsecase(
        repository: Provider.of<IGetPixRepository>(ctx, listen: false),
      ),
    ),
    Provider<IGetPixStatusDatasource>(
      create: (ctx) => GetPixStatusDatasourceImpl(),
    ),
    Provider<IGetPixStatusRepository>(
      create: (ctx) => GetPixStatusRepositoryImpl(
          datasource: Provider.of<IGetPixStatusDatasource>(ctx, listen: false)),
    ),
    Provider<GetPixStatusUsecase>(
      create: (ctx) => GetPixStatusUsecase(
        repository: Provider.of<IGetPixStatusRepository>(ctx, listen: false),
      ),
    ),
    Provider<IGetPaymentPublicKeyDatasource>(
      create: (ctx) => GetPaymentPublicKeyDatasourceImpl(),
    ),
    Provider<IGetPaymentPublicKeyRepository>(
      create: (ctx) => GetPaymentPublicKeyRepositoryImpl(
          datasource:
              Provider.of<IGetPaymentPublicKeyDatasource>(ctx, listen: false)),
    ),
    Provider<GetPaymentPublicKeyUsecase>(
      create: (ctx) => GetPaymentPublicKeyUsecase(
        repository:
            Provider.of<IGetPaymentPublicKeyRepository>(ctx, listen: false),
      ),
    ),
    Provider<ICardPaymentDatasource>(
      create: (ctx) => CardPaymentDatasourceImpl(),
    ),
    Provider<ICardPaymentRepository>(
      create: (ctx) => CardPaymentRepositoryImpl(
          datasource: Provider.of<ICardPaymentDatasource>(ctx, listen: false)),
    ),
    Provider<CardPaymentUsecase>(
      create: (ctx) => CardPaymentUsecase(
        repository: Provider.of<ICardPaymentRepository>(ctx, listen: false),
      ),
    ),
    ChangeNotifierProvider<QuickPurchaseController>(
      create: (ctx) => QuickPurchaseController(
        checkCredentialUsecase:
            Provider.of<CheckCredentialUsecase>(ctx, listen: false),
        countryUsecase: Provider.of<CountryUsecase>(ctx, listen: false),
      ),
    ),
    ChangeNotifierProvider<PaymentController>(
      create: (ctx) => PaymentController(
        cepService: Provider.of<CepService>(ctx, listen: false),
        getPixUsecase: Provider.of<GetPixUsecase>(ctx, listen: false),
        checkCredentialUsecase:
            Provider.of<CheckCredentialUsecase>(ctx, listen: false),
        getPaymentPublicKeyUsecase:
            Provider.of<GetPaymentPublicKeyUsecase>(ctx, listen: false),
        cardPaymentUsecase: Provider.of<CardPaymentUsecase>(ctx, listen: false),
      ),
    ),
    ChangeNotifierProvider<PixController>(
      create: (ctx) => PixController(
        getPixStatusUsecase:
            Provider.of<GetPixStatusUsecase>(ctx, listen: false),
      ),
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

    Provider<IFetchAllResumeJackpotDatasource>(
      create: (ctx) => FetchAllResumeJackpotDatasourceImpl(),
    ),
    Provider<IFetchAllResumeJackpotRepository>(
      create: (ctx) => FetchAllResumeJackpotRepositoryImpl(
          datasource: Provider.of<IFetchAllResumeJackpotDatasource>(ctx,
              listen: false)),
    ),
    Provider<FetchAllResumeJackpotUsecase>(
      create: (ctx) => FetchAllResumeJackpotUsecase(
        repository:
            Provider.of<IFetchAllResumeJackpotRepository>(ctx, listen: false),
      ),
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

    Provider<ICreateBetDatasource>(
      create: (ctx) => CreateBetDatasourceImpl(),
    ),
    Provider<ICreateBetRepository>(
      create: (ctx) => CreateBetRepositoryImpl(
          datasource: Provider.of<ICreateBetDatasource>(ctx, listen: false)),
    ),
    Provider<CreateBetUsecase>(
      create: (ctx) => CreateBetUsecase(
        repository: Provider.of<ICreateBetRepository>(ctx, listen: false),
      ),
    ),
    Provider<IGetJackpotsBetIdDatasource>(
      create: (ctx) => GetJackpotBetIdDatasourceImpl(),
    ),
    Provider<IGetJackpotBetIdRepository>(
      create: (ctx) => GetJackpotBetIdRepositoryImpl(
          datasource:
              Provider.of<IGetJackpotsBetIdDatasource>(ctx, listen: false)),
    ),

    Provider<IGetBetMadeDatasource>(
      create: (ctx) => GetBetMadeDatasourceImpl(),
    ),
    Provider<IGetBetMadeRepository>(
      create: (ctx) => GetBetMadeRepositoryImpl(
          datasource: Provider.of<IGetBetMadeDatasource>(ctx, listen: false)),
    ),
    Provider<GetBetMadeUsecase>(
      create: (ctx) => GetBetMadeUsecase(
        repository: Provider.of<IGetBetMadeRepository>(ctx, listen: false),
        jackpotBetIdRepository:
            Provider.of<IGetJackpotBetIdRepository>(ctx, listen: false),
      ),
    ),
    Provider<IFetchAllAwardsDatasource>(
      create: (ctx) => FetchAllAwardsDatasourceImpl(),
    ),
    Provider<IFetchAllAwardsRepository>(
      create: (ctx) => FetchAllAwardsRepositoryImpl(
          datasource:
              Provider.of<IFetchAllAwardsDatasource>(ctx, listen: false)),
    ),
    Provider<FetchAllAwardsUsecase>(
      create: (ctx) => FetchAllAwardsUsecase(
        repository: Provider.of<IFetchAllAwardsRepository>(ctx, listen: false),
      ),
    ),
    Provider<IUpdateTempBetDatasource>(
      create: (ctx) => SecureStorageUpdateTempBet(),
    ),
    Provider<IUpdateTempBetRepository>(
      create: (ctx) => UpdateTempBetRepositoryImpl(
          datasource:
              Provider.of<IUpdateTempBetDatasource>(ctx, listen: false)),
    ),
    Provider<UpdateTempBetUsecase>(
      create: (ctx) => UpdateTempBetUsecase(
        repository: Provider.of<IUpdateTempBetRepository>(ctx, listen: false),
      ),
    ),
    Provider<IDeleteTempBetDatasource>(
      create: (ctx) => SecureStorageDeleteTempBet(),
    ),
    Provider<IDeleteTempBetRepository>(
      create: (ctx) => DeleteTempBetRepositoryImpl(
          datasource:
              Provider.of<IDeleteTempBetDatasource>(ctx, listen: false)),
    ),
    Provider<DeleteTempBetUsecase>(
      create: (ctx) => DeleteTempBetUsecase(
        repository: Provider.of<IDeleteTempBetRepository>(ctx, listen: false),
      ),
    ),
    Provider<IGetTempBetsDatasource>(
      create: (ctx) => SecureStorageGetTempBets(),
    ),
    Provider<IGetTempBetRepository>(
      create: (ctx) => GetTempBetRepositoryImpl(
          datasource: Provider.of<IGetTempBetsDatasource>(ctx, listen: false)),
    ),
    Provider<GetTempBetsUsecase>(
      create: (ctx) => GetTempBetsUsecase(
        repository: Provider.of<IGetTempBetRepository>(ctx, listen: false),
        pixStatusRepository:
            Provider.of<IGetPixStatusRepository>(ctx, listen: false),
        deleteTempBetRepository:
            Provider.of<IDeleteTempBetRepository>(ctx, listen: false),
      ),
    ),

    ChangeNotifierProvider<MyJackpotsController>(
      create: (ctx) => MyJackpotsController(
        getTempBetsUsecase: Provider.of<GetTempBetsUsecase>(ctx, listen: false),
        getJackpotUsecase: Provider.of<GetJackpotUsecase>(ctx, listen: false),
        fetchAllAwardsUsecase:
            Provider.of<FetchAllAwardsUsecase>(ctx, listen: false),
        listByTeamJackpotUsecase:
            Provider.of<ListByTeamJackpotUsecase>(ctx, listen: false),
        getBetMadeUsecase: Provider.of<GetBetMadeUsecase>(ctx, listen: false),
      ),
    ),
    ChangeNotifierProvider<MyJackpotsDetailsController>(
      create: (ctx) => MyJackpotsDetailsController(
        getJackpotUsecase: Provider.of<GetJackpotUsecase>(ctx, listen: false),
        listByTeamJackpotUsecase:
            Provider.of<ListByTeamJackpotUsecase>(ctx, listen: false),
        getBetMadeUsecase: Provider.of<GetBetMadeUsecase>(ctx, listen: false),
      ),
    ),
    ChangeNotifierProvider<JackpotTeamController>(
      create: (ctx) => JackpotTeamController(
        getJackpotUsecase: Provider.of<GetJackpotUsecase>(ctx, listen: false),
        listByTeamJackpotUsecase:
            Provider.of<ListByTeamJackpotUsecase>(ctx, listen: false),
        fetchAllAwardsUsecase:
            Provider.of<FetchAllAwardsUsecase>(ctx, listen: false),
      ),
    ),
    ChangeNotifierProvider<JackpotChampionshipController>(
      create: (ctx) => JackpotChampionshipController(
        fetchAllAwardsUsecase:
            Provider.of<FetchAllAwardsUsecase>(ctx, listen: false),
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
        createBetUsecase: Provider.of<CreateBetUsecase>(ctx, listen: false),
        updateTempBetUsecase:
            Provider.of<UpdateTempBetUsecase>(ctx, listen: false),
        deleteTempBetUsecase:
            Provider.of<DeleteTempBetUsecase>(ctx, listen: false),
        fetchAllResumeJackpotsUsecase:
            Provider.of<FetchAllResumeJackpotUsecase>(ctx, listen: false),
        fetchAllAwardsUsecase:
            Provider.of<FetchAllAwardsUsecase>(ctx, listen: false),
        getJackpotUsecase: Provider.of<GetJackpotUsecase>(ctx, listen: false),
      ),
    ),
    ChangeNotifierProvider<ExtraJackpotController>(
      create: (ctx) => ExtraJackpotController(
        jackpotChampionshipController:
            Provider.of<JackpotChampionshipController>(ctx, listen: false),
        jackpotTeamController:
            Provider.of<JackpotTeamController>(ctx, listen: false),
        createBetUsecase: Provider.of<CreateBetUsecase>(ctx, listen: false),
      ),
    ),
    // SHOPPING CART /////////////////////////////
    ChangeNotifierProvider<ShoppingCartController>(
      create: (ctx) => ShoppingCartController(
        getJackpotUsecase: Provider.of<GetJackpotUsecase>(ctx, listen: false),
      ),
    ),
// CORE /////////////////////////////
    ChangeNotifierProvider<CoreController>(
      create: (ctx) => CoreController(
        loginController: Provider.of<LoginController>(ctx, listen: false),
        getSessionUseCase: Provider.of<GetSessionUseCase>(ctx, listen: false),
        deleteSessionUseCase:
            Provider.of<DeleteSessionUseCase>(ctx, listen: false),
        shoppingCartController:
            Provider.of<ShoppingCartController>(ctx, listen: false),
      ),
    ),
  ];
}
