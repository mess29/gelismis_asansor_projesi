import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_provider.g.dart';

// Bu enum, kullanıcının o anki kimlik durumunu temsil eder.
enum AuthStatus {
  unknown,      // Durum henüz bilinmiyor (Uygulama ilk açıldığında)
  authenticated,  // Kullanıcı giriş yapmış
  unauthenticated, // Kullanıcı giriş yapmamış
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthStatus build() {
    _initAuthListener();
    return AuthStatus.unknown;
  }

  void _initAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        state = AuthStatus.authenticated;
      } else {
        state = AuthStatus.unauthenticated;
      }
    });
  }

  Future<void> register(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // FirebaseAuth signIn işlemini otomatik yapar ve state listener (authStateChanges) günceller.
      // E-postayı hatırlaması için kaydediyoruz:
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('savedEmail', email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('Sağlanan şifre çok zayıf.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Bu e-posta adresi için zaten bir hesap mevcut.');
      } else {
        throw Exception(e.message ?? 'Kayıt olurken bir hata oluştu.');
      }
    } catch (e) {
      throw Exception('Kayıt başarısız oldu.');
    }
  }

  Future<void> login(String email, String password, {bool rememberMe = false}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final prefs = await SharedPreferences.getInstance();
      if (rememberMe) {
        await prefs.setString('savedEmail', email);
      }
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        throw Exception('Hatalı e-posta veya şifre girdiniz.');
      } else {
        throw Exception(e.message ?? 'Giriş yaparken bir hata oluştu.');
      }
    } catch (e) {
      throw Exception('Giriş başarısız oldu.');
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      try {
        await GoogleSignIn.instance.initialize();
      } catch (_) {}

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, // Sadece idToken yeterlidir
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('savedEmail', googleUser.email);
      
    } catch (e) {
      throw Exception('Google ile giriş başarısız.\nLütfen SHA-1 sertifikanızı Firebase\'e eklediğinizden emin olun.');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
       throw Exception(e.message ?? 'Şifre sıfırlama talebi başarısız oldu.');
    } catch (e) {
       throw Exception('Şifre sıfırlama hatası.');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
  }
}