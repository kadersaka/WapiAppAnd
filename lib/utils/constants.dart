

///////////////////////////////////////////////////////////////////////////////
class APIConstants {
  static const String OCTET_STREAM_ENCODING = "application/octet-stream";
  static const String API_BASE_URL = "http://totche.com/phpbackend/";
}

///////////////////////////////////////////////////////////////////////////////
class APIOperations {
  static const String LOGIN = "login";
  static const String REGISTER = "register";
  static const String CHANGE_PASSWORD = "chgPass";
  static const String SUCCESS = "success";
  static const String FAILURE = "failure";
}

///////////////////////////////////////////////////////////////////////////////
class EventConstants {
  static const int NO_INTERNET_CONNECTION = 0;

///////////////////////////////////////////////////////////////////////////////
  static const int LOGIN_USER_SUCCESSFUL = 500;
  static const int LOGIN_USER_UN_SUCCESSFUL = 501;

///////////////////////////////////////////////////////////////////////////////
  static const int USER_REGISTRATION_SUCCESSFUL = 502;
  static const int USER_REGISTRATION_UN_SUCCESSFUL = 503;
  static const int USER_ALREADY_REGISTERED = 504;

///////////////////////////////////////////////////////////////////////////////
  static const int CHANGE_PASSWORD_SUCCESSFUL = 505;
  static const int CHANGE_PASSWORD_UN_SUCCESSFUL = 506;
  static const int INVALID_OLD_PASSWORD = 507;
///////////////////////////////////////////////////////////////////////////////
}

///////////////////////////////////////////////////////////////////////////////
class APIResponseCode {
  static const int SC_OK = 200;
}
///////////////////////////////////////////////////////////////////////////////

class SharedPreferenceKeys {
  static const String IS_USER_LOGGED_IN = "IS_USER_LOGGED_IN";
  static const String USER = "USER";
}

///////////////////////////////////////////////////////////////////////////////
class ProgressDialogTitles {
  static const String IN_PROGRESS = "Traitement en cours...";
  static const String USER_LOG_IN = "Connexionen cours...";
  static const String USER_CHANGE_PASSWORD = "Chargement...";
  static const String USER_REGISTER = "Inscription...";
  static const String DATA_SAVE = "Enregistrement en cours...";
}

///////////////////////////////////////////////////////////////////////////////
class SnackBarText {
  static const String NO_INTERNET_CONNECTION = "Pas de connexion internet";
  static const String LOGGED_SUCCESSFUL = "Vous êtes déjà connecté";
  static const String LOGIN_SUCCESSFUL = "Connexion réussie";
  static const String LOGIN_UN_SUCCESSFUL = "Connexion échouée";
  static const String CHANGE_PASSWORD_SUCCESSFUL = "Changement de mot de passe réussi";
  static const String CHANGE_PASSWORD_UN_SUCCESSFUL = "Echec de changement de mot de passe";
  static const String REGISTER_SUCCESSFUL = "Inscription réussie";
  static const String REGISTER_UN_SUCCESSFUL = "Inscription échouée";
  static const String USER_ALREADY_REGISTERED = "Ce numéro est déjàa ssocié à un compte";
  static const String ENTER_PASS = "Veuillez saisir votre mot de passe";
  static const String ENTER_NEW_PASS = "veuillez entrer votre nouveau mot de passe";
  static const String ENTER_OLD_PASS = "Veuillez entrer votre ancien mot de passse";
  static const String ENTER_EMAIL = "Veuillez saisir votre email";
  static const String ENTER_VALID_MAIL = "VEuillez saisir un email valid";
  static const String ENTER_NAME = "Veuillez saisir votre nom";
  static const String ENTER_PHONE = "Veuillez entrer votre numero de téléphone";
  static const String INVALID_OLD_PASSWORD = "Ancien mot de passe non valide";
  static const String INVALID_CODE = "Code nom valide";
}

///////////////////////////////////////////////////////////////////////////////
class Texts {
  static const String REGISTER_NOW = "Pas encore inscrit? Inscrivez-vous!";
  static const String LOGIN_NOW = "Déjà inscrit? connectez-vous!";
  static const String LOGIN = "CONNEXION";
  static const String REGISTER = "INSCRIPTION";
  static const String PASSWORD = "Mot de passse";
  static const String OLD_PASSWORD = "Ancien mot de passe";
  static const String NEW_PASSWORD = "Nouveau mot de passe";
  static const String CHANGE_PASSWORD = "CHANGEMENT DE MOT DE PASSE";
  static const String LOGOUT = "DECONNEXION";
  static const String EMAIL = "Email";
  static const String NAME = "Nom";
  static const String CODE = "Code";
  static const String PHONE = "Téléphone";
}
///////////////////////////////////////////////////////////////////////////////
