import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:golab/const/color.dart';
import 'package:golab/components/login/progress.dart';
import 'package:golab/ui/sign_in.dart';
import 'package:golab/widget/appbutton.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';

final isAgreedProvider = StateProvider.autoDispose((ref) => false);

class ConfirmSignUp extends HookWidget {

  final bool closable;
  final bool type;
  final String email;
  final String password;
  final String name;
  final String university;
  final String school;
  final String department;
  final String graduateSchool;

  const ConfirmSignUp({
    Key? key,
    required this.email,
    required this.password,
    required this.name,
    required this.university,
    required this.type,
    required this.department,
    required this.school,
    required this.graduateSchool,
    this.closable = true
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final authController = useProvider(authControllerProvider.notifier);
    final isAgreed = useProvider(isAgreedProvider);
    final errorText = useProvider(errorTextProvider);
    final Size size = MediaQuery.of(context).size;

    Future<void> submit(BuildContext context) async {
      try {
        ShowProgress.showProgressDialog(context);
        await authController.signUpWithEmailAndPassword(
            email, password, type,
            university, name, school,
            department, graduateSchool
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
        if (!closable) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      } on FirebaseAuthException catch (e) {
        FlutterError.dumpErrorToConsole(FlutterErrorDetails(
          exception: e,
          context: ErrorSummary('ConfirmSignUp'),
        ));
        errorText.state = e.message != null
            ? 'そのメールアドレスはご利用いただけません'
            : 'エラーが発生しました もう一度お試しください';
        Navigator.of(context).pop();
      } on Exception catch (e) {
        FlutterError.dumpErrorToConsole(FlutterErrorDetails(
          exception: e,
          context: ErrorSummary('ConfirmSignUp'),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.grey),
        title: const Text('利用規約', style: TextStyle(color: AppColor.text),),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: AppColor.background,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                _termsTextBox(size),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text('利用規約に同意する', style: TextStyle(fontSize: 12.0, color: AppColor.text),),
                    Checkbox(
                      activeColor: AppColor.main,
                      value: isAgreed.state,
                      onChanged: (bool? value) {
                        isAgreed.state = !isAgreed.state;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                AppButton.primary(
                  width: 260.0,
                  text: "登録する",
                  onPressed: !isAgreed.state
                      ? null
                      : () async {
                    await submit(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _termsTextBox(Size size) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.term, width: 1),
        color: Colors.white,
      ),
      width: size.width * 0.9,
      height: size.height * 0.65,
      padding: const EdgeInsets.all(8.0),
      child: const Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(
            '利用規約' +
                '\n\nこんにちはこんにちは' +
                '\n\nこんにちはこんにちは' +
                '\n\nこんにちはこんにちは' +
                '\n\nこんにちはこんにちは' +
                '\n\nこんにちはこんにちは' +
                '\n\nこんにちはこんにちは',
            style: TextStyle(color: AppColor.text),
          ),
        ),
      ),
    );
  }
}