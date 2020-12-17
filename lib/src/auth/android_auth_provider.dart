import 'package:chat_app/src/auth/auth_provider_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class _AndroidAuthProvider implements AuthProviderBase {
  
  @override
  Future<FirebaseApp> initialize() async {
    return await Firebase.initializeApp(
      name: "Chat App",
      options: FirebaseOptions(
        apiKey: "AIzaSyD-agD_pdwTzqtLFHendC8FvMnMsKAkOpI",
        authDomain: "chat-app-9d22d.firebaseapp.com",
        projectId: "chat-app-9d22d",
        storageBucket: "chat-app-9d22d.appspot.com",
        messagingSenderId: "315081151411",
        appId: "1:315081151411:android:6eab0198f35bf43b2b71c6"
      )
    );
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}

class AuthProvider extends _AndroidAuthProvider {}