import 'package:ecommerce/screens/widgets/snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi{
  
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() {
    try {
      return _googleSignIn.signIn();
    } catch (e) {
      return showErrorSnackBar('User Auth', 'There are error');
    }
  }
  
}