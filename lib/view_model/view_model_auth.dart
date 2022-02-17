import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:golab/repository/repository_auth.dart';

class AuthViewModel extends StateNotifier<User?> {
  AuthViewModel({User? initialUser}) : super(initialUser) {
    auth.userChanges().listen((user) { state = user; });
  }

  static getErrorMessage(FirebaseException exception) {
    switch (exception.code) {
      case "wrong-password":
      case 'user-not-found':
        return 'メールアドレスかパスワードが正しくありません';
      case 'user-disabled':
      case 'operation-not-allowed':
      case 'email-already-in-use':
        return '利用できないメールアドレスです';
      case 'too-many-requests':
        return 'しばらく待ってから再度お試しください';
      default:
        return 'ログインに失敗しました';
    }
  }

  static final auth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = await AuthRepository.signIn(email, password);
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password,
      bool type, String university,
      String name, String school,
      String department, String graduateSchool
      ) async {
    state = await AuthRepository.signUp(email, password);
    await AuthRepository.setUser(
        state!, type, name,
        university, school,
        department, graduateSchool
    );
  }

  bool isSigningIn() {
    return state != null;
  }

  Future<bool> isStudent() async {
    return await AuthRepository.isStudent();
  }

  Future<bool> isResearcher() async {
    return await AuthRepository.isResearcher();
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}