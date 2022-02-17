import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golab/const/color.dart';
import 'package:golab/const/email_regular_expression.dart';
import 'package:golab/repository/repository_auth.dart';
import 'package:golab/view_model/view_model_auth.dart';
import 'package:golab/widget/appbutton.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'confirm_sign_up.dart';

final passwordViewProvider = StateProvider.autoDispose((ref) => false);
final checkPasswordViewProvider = StateProvider.autoDispose((ref) => false);
final errorTextProvider = StateProvider.autoDispose((ref) => '');
final emailErrorTextProvider = StateProvider.autoDispose((ref) => '');
final passwordErrorTextProvider = StateProvider.autoDispose((ref) => '');
final checkPasswordErrorTextProvider = StateProvider.autoDispose((ref) => '');
final emailLengthProvider = StateProvider.autoDispose((ref) => 0);
final passwordLengthProvider = StateProvider.autoDispose((ref) => 0);
final checkPasswordLengthProvider = StateProvider.autoDispose((ref) => 0);
final accountTypeProvider = StateProvider.autoDispose((ref) => true);
final nameLengthProvider = StateProvider.autoDispose((ref) => 0);
final universityLengthProvider = StateProvider.autoDispose((ref) => 0);
final schoolLengthProvider = StateProvider.autoDispose((ref) => 0);
final departmentLengthProvider = StateProvider.autoDispose((ref) => 0);
final graduateSchoolLengthProvider = StateProvider.autoDispose((ref) => 0);

class SignUp extends HookWidget {
  static Future push(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SignUp(closable: false),
          fullscreenDialog: false,
        ));
  }

  static Future pushAsFullscreenDialog(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SignUp(closable: true),
          fullscreenDialog: true,
        ));
  }

  final bool closable;

  const SignUp({Key? key, this.closable = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailCtl = useTextEditingController();
    final passwordCtl = useTextEditingController();
    final checkPasswordCtl = useTextEditingController();
    final nameCtl = useTextEditingController();
    final universityCtl = useTextEditingController();
    final schoolCtl = useTextEditingController();
    final departmentCtl = useTextEditingController();
    final graduateSchoolCtl = useTextEditingController();

    final passwordView = useProvider(passwordViewProvider);
    final checkPasswordView = useProvider(checkPasswordViewProvider);
    final errorText = useProvider(errorTextProvider);
    final emailErrorText = useProvider(emailErrorTextProvider);
    final passwordErrorText = useProvider(passwordErrorTextProvider);
    final checkPasswordErrorText = useProvider(checkPasswordErrorTextProvider);
    final emailLength = useProvider(emailLengthProvider);
    final passwordLength = useProvider(passwordLengthProvider);
    final checkPasswordLength = useProvider(checkPasswordLengthProvider);
    final universityLength = useProvider(universityLengthProvider);
    final nameLength = useProvider(nameLengthProvider);
    final accountType = useProvider(accountTypeProvider);
    final schoolLength = useProvider(schoolLengthProvider);
    final departmentLength = useProvider(departmentLengthProvider);
    final graduateSchoolLength = useProvider(graduateSchoolLengthProvider);

    bool checkRequirement() {
      if (emailCtl.text.isNotEmpty &&
          AppRegExp.email(emailCtl.text) &&
          passwordCtl.text.isNotEmpty &&
          passwordCtl.text == checkPasswordCtl.text &&
          emailCtl.text.length < 201 &&
          passwordCtl.text.length > 7 &&
          passwordCtl.text.length < 51 &&
          universityCtl.text.isNotEmpty &&
          nameCtl.text.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }

    Future<void> submit(BuildContext context) async {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmSignUp(
            email: emailCtl.text,
            password: passwordCtl.text,
            closable: closable,
            type: accountType.state,
            university: universityCtl.text,
            name: nameCtl.text,
            school: schoolCtl.text,
            department: departmentCtl.text,
            graduateSchool: graduateSchoolCtl.text,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: closable ? const Icon(Icons.close) : const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('ユーザー登録', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: AppColor.registration,
      body: GestureDetector(
        onTap: () { FocusScope.of(context).unfocus(); },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColor.registration,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    textFormDecoration('名前', nameLength.state, 20, true),
                    const SizedBox(height: 5.0),
                    textFormField((text) { nameLength.state = nameCtl.text.length; },
                        '青葉太郎', nameCtl, 20, TextInputType.name),
                    const SizedBox(height: 35.0),
                    textFormDecoration('大学', universityLength.state, 20, true),
                    const SizedBox(height: 5.0),
                    textFormField((text) { universityLength.state = universityCtl.text.length; },
                        '東北大学', universityCtl, 20, TextInputType.name),
                    const SizedBox(height: 35.0),
                    textFormDecoration('メールアドレス', emailLength.state, 200, true),
                    const SizedBox(height: 5.0),
                    textFormField(
                        (text) {
                          emailLength.state = emailCtl.text.length;
                          if (!AppRegExp.email(text)) {
                            emailErrorText.state = '正しいメールアドレスを入力してください';
                          } else {
                            emailErrorText.state = '';
                          }
                        },
                      'golab@gmail.com', emailCtl, 200, TextInputType.emailAddress
                    ),
                    SizedBox(
                      height: 35.0,
                      child: Text(
                        emailErrorText.state,
                        style: const TextStyle(color: AppColor.error, fontSize: 12.0),
                        ),
                      ),
                    textFormDecoration('学部(学部生用)', schoolLength.state, 20, false),
                    const SizedBox(height: 5.0),
                    textFormField(
                            (text) { schoolLength.state = schoolCtl.text.length; },
                        '工学部', schoolCtl, 20, TextInputType.text
                    ),
                    const SizedBox( height: 35.0 ),
                    textFormDecoration('学科(学部生用)', departmentLength.state, 20, false),
                    const SizedBox(height: 5.0),
                    textFormField(
                            (text) { departmentLength.state = departmentCtl.text.length; },
                        '電気情報物理工学科', departmentCtl, 20, TextInputType.text
                    ),
                    const SizedBox( height: 35.0 ),
                    textFormDecoration('研究科(大学院生、研究者用)', graduateSchoolLength.state, 20, false),
                    const SizedBox(height: 5.0),
                    textFormField(
                            (text) { graduateSchoolLength.state = graduateSchoolCtl.text.length; },
                        '工学研究科', graduateSchoolCtl, 20, TextInputType.text
                    ),
                    const SizedBox( height: 35.0 ),
                    textFormDecoration('パスワード（8文字以上）', passwordLength.state, 50, true),
                    const SizedBox(height: 5.0),
                    passwordFormField(
                            (text) {
                              passwordLength.state = passwordCtl.text.length;
                              if (text.length < 8) {
                                passwordErrorText.state = '8文字以上にしてください';
                              } else {
                                passwordErrorText.state = '';
                              }
                            },
                            () { passwordView.state = !passwordView.state; },
                        passwordCtl, passwordView.state,
                        50, TextInputType.visiblePassword
                    ),
                    SizedBox(
                      height: 35.0,
                      child: Text(
                        passwordErrorText.state,
                        style: const TextStyle(color: AppColor.error, fontSize: 12.0),
                        ),
                      ),
                    textFormDecoration('パスワード（確認）', checkPasswordLength.state, 50, true),
                    const SizedBox(height: 5.0),
                    passwordFormField(
                            (text) {
                              checkPasswordLength.state = checkPasswordCtl.text.length;
                            if (text != passwordCtl.text) {
                              checkPasswordErrorText.state = 'パスワードが違います';
                            } else {
                              checkPasswordErrorText.state = '';
                            } },
                            () { checkPasswordView.state = !checkPasswordView.state; },
                        checkPasswordCtl, checkPasswordView.state,
                        50, TextInputType.visiblePassword
                    ),
                    SizedBox(
                      height: 15.0,
                      child: Text(
                        checkPasswordErrorText.state,
                        style: const TextStyle(color: AppColor.error, fontSize: 12.0),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RadioListTile(
                              title: const Text('Student', style: TextStyle(color: AppColor.text)),
                              value: true,
                              groupValue: accountType.state,
                              onChanged: (_) { accountType.state = !accountType.state; }
                              ),
                        ),
                        Expanded(
                          child: RadioListTile(
                              title: const Text('Researcher', style: TextStyle(color: AppColor.text),),
                              value: false,
                              groupValue: accountType.state,
                              onChanged: (_) { accountType.state = !accountType.state; }
                              ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
                child: Text(
                  errorText.state,
                  style: const TextStyle(color: AppColor.error),
                ),
              ),
              AppButton.primary(
                width: 260.0,
                text: '次へ進む',
                onPressed: !checkRequirement() ? null : () async {
                  try {
                    List<String> isAlready =
                    await AuthRepository.checkIsAlreadyUser(emailCtl.text);
                    if (isAlready.contains('password')) {
                      errorText.state = 'このメールアドレスはすでに登録されています';
                      return print('すでに登録されています');
                    }
                    await submit(context);
                  } on FirebaseAuthException catch (e) {
                    FlutterError.dumpErrorToConsole(FlutterErrorDetails(
                      exception: e,
                      context: ErrorSummary('SignUp'),
                    ));
                    errorText.state = AuthViewModel.getErrorMessage(e);
                  } on Exception catch (e) {
                    FlutterError.dumpErrorToConsole(FlutterErrorDetails(
                      exception: e,
                      context: ErrorSummary('SignUp'),
                    ));
                    errorText.state = 'メールアドレスが正しくありません';
                  }
                },
              ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }

  Widget formTitle(String title,bool isRequired) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(color: AppColor.text),
        ),
        Text(isRequired ? '*' : '', style: const TextStyle(color: Colors.red),
        ),
      ],
    );
  }

  TextFormField textFormField(
      void Function(String)? _onChanged,
      String _hintText, TextEditingController _controller,
      int _maxLength, TextInputType _keyboardType
      ){
    return TextFormField(
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: Colors.white,
        hintText: _hintText,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.main),),
        contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0,),
      ),
      style: const TextStyle(fontSize: 16.0, color: AppColor.text),
      keyboardType: _keyboardType,
      controller: _controller,
      onChanged: _onChanged,
      maxLength: _maxLength,
    );
  }

  TextFormField passwordFormField(
      void Function(String)? _onChanged, void Function()? _onPressed,
      TextEditingController _controller, bool visible,
      int _maxLength, TextInputType _keyboardType
      ){
    return TextFormField(
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.main),),
        contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0,),
        suffixIcon: IconButton(
          color: Colors.grey,
          disabledColor: AppColor.text,
          onPressed: _onPressed,
          icon: Icon(visible ? Icons.visibility_rounded : Icons.visibility_off_rounded),
        ),
      ),
      style: const TextStyle(fontSize: 16.0, color: AppColor.text),
      obscureText: !visible,
      controller: _controller,
      onChanged: _onChanged,
      maxLength: _maxLength,
      keyboardType: _keyboardType,
    );
  }

  Row textFormDecoration(String title, int textLength, int maxLength, bool isRequired){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: formTitle(title,isRequired),
        ),
        Text(
          textLength.toString() + '/' + maxLength.toString() + '  ',
          style: const TextStyle(fontSize: 12, color: AppColor.text),
        ),
      ],
    );
  }
}