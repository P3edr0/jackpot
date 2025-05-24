class I18n {
  static const login = 'login';
  static const password = 'password';
  static const email = 'email';
  static const forgotPassword = 'forgotPassword';
  static const forgotYourPassword = 'forgotYourPassword';
  static const backToLogin = 'backToLogin';
  static const minerContinue = 'minerContinue';
  static const kpis = 'kpis';
  static const alerts = 'alerts';
  static const users = 'users';
  static const update = 'update';
  static const clients = 'clients';
  static const help = 'help';
  static const name = 'name';
  static const role = 'role';
  static const creationDate = 'creationDate';
  static const createUser = 'createUser';
  static const action = 'action';
  static const master = 'master';
  static const admin = 'admin';
  static const analyst = 'analyst';
  static const updateUser = 'updateUser';
  static const userName = 'userName';
  static const profile = 'profile';
  static const canOptimize = 'canOptimize';
  static const initialPassword = 'initialPassword';
  static const confirmInitialPassword = 'confirmInitialPassword';
  static const cancel = 'cancel';
  static const save = 'save';
  static const logout = 'logout';
  static const logoutApplication = 'logoutApplication';
  static const yes = 'yes';
  static const enterYourEmailAddressAndWeWillSendYou =
      'enterYourEmailAddressAndWeWillSendYou';

  static String plural(
    int count, {
    required String singular,
    required String plural,
  }) {
    late final String response;
    if (count > 1) {
      response = plural;
    } else {
      response = singular;
    }

    return response.replaceAll('%i', count.toString());
  }

  static String removeLastString(String value) {
    return value.substring(0, value.length - 1);
  }
}
