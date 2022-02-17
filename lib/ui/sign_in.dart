import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:golab/const/color.dart';
import 'package:golab/const/email_regular_expression.dart';
import 'package:golab/repository/repository_auth.dart';
import 'package:golab/ui/sign_up.dart';
import 'package:golab/view_model/view_model_auth.dart';
import 'package:golab/widget/appbutton.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';

final passwordViewProvider = StateProvider.autoDispose((ref) => false);
final errorTextProvider = StateProvider.autoDispose((ref) => '');
final emailErrorTextProvider = StateProvider.autoDispose((ref) => '');
final passwordErrorTextProvider = StateProvider.autoDispose((ref) => '');
final emailLengthProvider = StateProvider.autoDispose((ref) => 0);
final passwordLengthProvider = StateProvider.autoDispose((ref) => 0);

class SignIn extends HookWidget {
  static Future pushReplacement(BuildContext context) {
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SignIn(fullscreenDialog: false),
          fullscreenDialog: false,
        ));
  }

  static Future pushAsFullscreenDialog(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SignIn(fullscreenDialog: true),
          fullscreenDialog: true,
        ));
  }

  final bool fullscreenDialog;

  const SignIn({Key? key, required this.fullscreenDialog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fullscreenDialog ? AppBar(
        iconTheme: const IconThemeData(color: AppColor.registration),
        leading: InkWell(
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text('ログイン', style: TextStyle(color: AppColor.text),),
        backgroundColor: AppColor.registration,
      ) : null,
      body: SafeArea(
        child: Container(
          margin: fullscreenDialog ? null : MediaQuery.of(context).padding,
          child: GestureDetector(
            onTap: () {FocusScope.of(context).unfocus();},
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  buildSignInForm(context),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignInForm(BuildContext context) {
    final emailCtl = useTextEditingController();
    final passwordCtl = useTextEditingController();
    final authController = useProvider(authControllerProvider.notifier);
    final passwordView = useProvider(passwordViewProvider);
    final errorText = useProvider(errorTextProvider);
    final emailErrorText = useProvider(emailErrorTextProvider);
    final passwordErrorText = useProvider(passwordErrorTextProvider);
    final emailLength = useProvider(emailLengthProvider);
    final passwordLength = useProvider(passwordLengthProvider);


    bool validate() {
      return emailCtl.text.isNotEmpty &&
          AppRegExp.email(emailCtl.text) &&
          passwordCtl.text.isNotEmpty &&
          emailCtl.text.length < 201 &&
          passwordCtl.text.length > 7 &&
          passwordCtl.text.length < 51;
    }

    Future<void> submit(BuildContext context) async {
      authController.signInWithEmailAndPassword(emailCtl.text, passwordCtl.text);
      if (!authController.isSigningIn()) {
        errorText.state = 'アカウントが見つかりませんでした';
        return;
      } else {
        final isStudent = await AuthRepository.isStudent();
        final isResearcher = await AuthRepository.isResearcher();

        if (fullscreenDialog) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (isStudent){
          Navigator.of(context).pushReplacementNamed('/student');
        } else if (isResearcher){
          Navigator.of(context).pushReplacementNamed('/researcher');
        }
      }
    }

    return Column(
      children: [
        Container(
          color: AppColor.registration,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Text(
                  'ログイン',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColor.text),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: buildLabel('メールアドレス'),),
                  Text(
                    emailLength.state.toString() + '/200  ',
                    style: const TextStyle(fontSize: 12, color: AppColor.text),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              TextFormField(
                decoration: const InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'golab@gmail.com',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green),),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ),
                ),
                style: const TextStyle(fontSize: 16.0, color: AppColor.text),
                keyboardType: TextInputType.emailAddress,
                controller: emailCtl,
                onChanged: (value) {
                  emailLength.state = emailCtl.text.length;
                  if (!AppRegExp.email(value)) {
                    emailErrorText.state = '正しいメールアドレスを入力してください';
                  } else {
                    emailErrorText.state = '';
                  }},
                maxLength: 200,
              ),
              SizedBox(
                height: 35.0,
                child: Text(
                  emailErrorText.state,
                  style: const TextStyle(color: AppColor.error, fontSize: 12.0),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: buildLabel('パスワード（8文字以上）'),),
                  Text(
                    passwordLength.state.toString() + '/50  ',
                    style: const TextStyle(fontSize: 12, color: AppColor.text),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              TextFormField(
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.green),),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ),
                  suffixIcon: IconButton(
                    color: Colors.grey,
                    disabledColor: AppColor.text,
                    onPressed: () {passwordView.state = !passwordView.state;},
                    icon: Icon(
                        passwordView.state ? Icons.visibility_off_rounded : Icons.visibility_rounded),
                    ),
                  ),
                style: const TextStyle(fontSize: 16.0, color: AppColor.text),
                obscureText: !passwordView.state,
                controller: passwordCtl,
                onChanged: (value) {
                  passwordLength.state = passwordCtl.text.length;
                  if (value.length < 8) {
                    passwordErrorText.state = '8文字以上にしてください';
                  } else {
                    passwordErrorText.state = '';
                  }},
                maxLength: 50,
                keyboardType: TextInputType.visiblePassword,
              ),
              if (errorText.state.isEmpty) ...[
                SizedBox(
                  height: 20.0,
                  child: Text(
                    passwordErrorText.state,
                    style: const TextStyle(color: AppColor.error, fontSize: 12.0),
                    ),
                  ),
                ],
              ],
            ),
          ),
        if (errorText.state.isNotEmpty) ...[
          SizedBox(
            height: 20,
            child: Center(
              child: Text(
                errorText.state,
                style: const TextStyle(color: AppColor.error),
              ),
            ),
          ),
        ],
        const SizedBox(height: 10),
        SizedBox(
          width: 260,
          child: AppButton.primary(
            text: 'ログイン',
            onPressed: !validate() ? null : () async {
              try {await submit(context);} on FirebaseAuthException catch (e) {
                FlutterError.dumpErrorToConsole(
                    FlutterErrorDetails(
                      exception: e,
                      context: ErrorSummary('SignIn'),
                    )
                );
                errorText.state = AuthViewModel.getErrorMessage(e);
              } on Exception catch (e) {
                FlutterError.dumpErrorToConsole(
                    FlutterErrorDetails(
                      exception: e,
                      context: ErrorSummary('SignIn'),
                    ));
                errorText.state = 'ログインに失敗しました';
              }
            },
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            SignUp.push(context);
          },
          child: const Text('ユーザー登録はこちらから'),
        ),
      ],
    );
  }

  Widget buildLabel(String title) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(color: AppColor.text),
        ),
      ],
    );
  }
}