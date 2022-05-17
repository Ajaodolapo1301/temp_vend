const bool isInDebugMode = true;

const orderApi = "https://tapi.hexlogistics.ng/order/v1";
const authService = "https://tapi.hexlogistics.ng/auth/v1";
const merchantService = "https://tapi.hexlogistics.ng/admin/v1/merchant";

// tapi.hexlogistics.ng/
class Env {
  static String _prod = "";
  static String _staging = "";
  static String _testing = "";
  static String _url = "";

  // static String _accessToken;

  static String get prod => _prod;
  static String get staging => _staging;
  static String get testing => _testing;

  static String get url => _url;

  /// Assert only runs in debug mode and can be used to test if the app is in debug mode
  /// Change the env variable to tests when in debug mode.

  void initEnv({url}) {
    _url = url;
  }
}

class SystemProperties {
  static const String payStackTestKeys =
      "pk_test_b7fde70e2247fc4a8e96e58568b9fbdaf24497a6";
  static const String flutterWaveTestKey =
      "FLWPUBK_TEST-1b82d4ea1e646afd0508910c439ed7bf-X";
  static const String flutterWaveTestEncKey = "FLWSECK_TEST9e45d3a0932f";
  static const String agoraAppID = "86b2743dd79346dcb9b8aab329b4ad9a";
  static const String payStackLiveKeys =
      "pk_live_a3e3cef87aaadfbe92f79abda448e884175384c4";
  static const String appPackageAndroid = "";
  static const String fcm =
      "AAAAm_p53H0:APA91bE65LshhbrC7_Cg0FBZ-_UCUxjG8saepQ41GIEHv9F0Au6thqExxDaJ3QhCE2W5FX0oi_jhEsz45FPsXEyxRy24cQCGUC63gdFbpmvXGLxr1W6LkEIjnhMnfxfzVcKPjMWvuxxq";
  // "AAAANXTQmEk:APA91bFp6vpY-14PDGZxDm3U-lqspP0gZD_iAJoysqvqn141DpP40XhjFKYtHcww1geMslbUuEaP-qIDj-cABGX3QH40vGM0mqqdxuLheCIZIDKzsS9U8XL903nlSYzkJNAOd2Fb7w4_";
  static const String appIDIOS = "";

  static const testingurl = "https://tapi.primhex.com/auth";

  static const staging = "staging/remote_data_source ";
  static const prod = "prod/remote_data_source ";
}
