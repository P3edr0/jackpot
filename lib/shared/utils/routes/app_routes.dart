import 'package:jackpot/presenter/features/auth/create_user/face_detector/face_capture_page.dart';
import 'package:jackpot/presenter/features/auth/create_user/photo_help/photo_help_page.dart';
import 'package:jackpot/presenter/features/auth/create_user/preview_face_capture/preview_face_capture_page.dart';
import 'package:jackpot/presenter/features/auth/create_user/step_one/create_user_step_one_page.dart';
import 'package:jackpot/presenter/features/auth/create_user/step_two/create_user_step_two_page.dart';
import 'package:jackpot/presenter/features/auth/login/help_page.dart';
import 'package:jackpot/presenter/features/auth/login/pages/credential/credential_page.dart';
import 'package:jackpot/presenter/features/auth/login/pages/password/password_page.dart';
import 'package:jackpot/presenter/features/auth/login/pages/password/pre_login_info_page.dart';
import 'package:jackpot/presenter/features/auth/login/pages/recovery_session/recovery_sesion_page.dart';
import 'package:jackpot/presenter/features/auth/login/password_recover_email_page.dart';
import 'package:jackpot/presenter/features/auth/login/password_recover_page.dart';
import 'package:jackpot/presenter/features/auth/login/pre_create_user_page.dart';
import 'package:jackpot/presenter/features/auth/login/welcome_page.dart';
import 'package:jackpot/presenter/features/extra_jackpot/coupon_select/extra_coupon_select_page.dart';
import 'package:jackpot/presenter/features/home/pages/home/home_page.dart';
import 'package:jackpot/presenter/features/home/pages/profile/profile_page.dart';
import 'package:jackpot/presenter/features/jackpot/coupon_select/coupon_select_page.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_championship/jackpot_championship_page.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_questions/jackpot_questions_page.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_team/jackpot_team_page.dart';
import 'package:jackpot/presenter/features/jackpot/my_jackpots/pages/my_jackpots/my_jackpots_page.dart';
import 'package:jackpot/presenter/features/jackpot/my_jackpots/pages/my_jackpots_details/my_jackpots_details_page.dart';
import 'package:jackpot/presenter/features/jackpot/quick_purchase/quick_purchase_page.dart';
import 'package:jackpot/presenter/features/lgpd/pages/lgpd/lgpd_page.dart';
import 'package:jackpot/presenter/features/lgpd/pages/viewer_docs/viewer_docs_page.dart';
import 'package:jackpot/presenter/features/payment/pages/payment_page.dart';
import 'package:jackpot/presenter/features/payment/pages/pix_page/pix_page.dart';
import 'package:jackpot/presenter/features/shopping_cart/shopping_cart_page.dart';
import 'package:jackpot/presenter/features/splash/splash_page.dart';

class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const jackpotTeam = '/jackpot_team';
  static const jackpotChampionship = '/jackpot_championship';
  static const welcome = '/welcome';
  static const couponSelect = '/coupon_select';
  static const extraCouponSelect = '/extra_coupon_select';
  static const jackpotQuestions = '/questions';
  static const preCreateUser = '/pre_create_user';
  static const createUserOne = '/create_user_one';
  static const createUserTwo = '/create_user_two';
  static const lgpd = '/lgpd';
  static const photoHelp = '/photo_help';
  static const preLogin = '/pre_login';
  static const recoverySession = '/recovery_session';
  static const profile = '/profile';
  static const viewerDocs = '/viewer_docs';
  static const login = '/login';
  static const payment = '/payment';
  static const captureFace = '/captureFace';
  static const previewCapturedFace = '/previewCapturedFace';
  static const password = '/password';
  static const passwordRecover = '/password_recover';
  static const passwordRecoverEmail = '/password_recover_email';
  static const help = '/help';
  static const myJackpots = '/my_jackpots';
  static const myJackpotsDetails = '/my_jackpots_details';
  static const shoppingCart = '/shopping_cart';
  static const qrCodePix = '/qr_code_pix';
  static const quickPurchase = '/quick_purchase';

  static final routes = {
    AppRoutes.splash: (ctx) => const SplashPage(),
    AppRoutes.home: (ctx) => const HomePage(),
    AppRoutes.jackpotTeam: (ctx) => const JackpotTeamPage(),
    AppRoutes.jackpotChampionship: (ctx) => const JackpotChampionshipPage(),
    AppRoutes.profile: (ctx) => const ProfilePage(),
    AppRoutes.couponSelect: (ctx) => const CouponSelectPage(),
    AppRoutes.extraCouponSelect: (ctx) => const ExtraCouponSelectPage(),
    AppRoutes.jackpotQuestions: (ctx) => const JackpotQuestionsPage(),
    AppRoutes.viewerDocs: (ctx) => const ViewerDocsPage(),
    AppRoutes.preCreateUser: (ctx) => const PreCreateUserPage(),
    AppRoutes.welcome: (ctx) => const WelcomePage(),
    AppRoutes.lgpd: (ctx) => const LgpdPage(),
    AppRoutes.preLogin: (ctx) => const PreLoginInfoPage(),
    AppRoutes.login: (ctx) => const CredentialPage(),
    AppRoutes.password: (ctx) => const PasswordPage(),
    AppRoutes.recoverySession: (ctx) => const RecoverySessionPage(),
    AppRoutes.passwordRecover: (ctx) => const PasswordRecoverPage(),
    AppRoutes.passwordRecoverEmail: (ctx) => const PasswordRecoverEmailPage(),
    AppRoutes.help: (ctx) => const HelpPage(),
    AppRoutes.createUserOne: (ctx) => const CreateUserStepOnePage(),
    AppRoutes.createUserTwo: (ctx) => const CreateUserStepTwoPage(),
    AppRoutes.captureFace: (ctx) => const FaceCapturePage(),
    AppRoutes.previewCapturedFace: (ctx) => const PreviewCapturedFacePage(),
    AppRoutes.photoHelp: (ctx) => const PhotoHelpPage(),
    AppRoutes.payment: (ctx) => const PaymentPage(),
    AppRoutes.myJackpots: (ctx) => const MyJackpotsPage(),
    AppRoutes.myJackpotsDetails: (ctx) => const MyJackpotsDetailsPage(),
    AppRoutes.shoppingCart: (ctx) => const ShoppingCartPage(),
    AppRoutes.qrCodePix: (ctx) => const PixPage(),
    AppRoutes.quickPurchase: (ctx) => const QuickPurchasePage(),
  };
}
