import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golab/main.dart';
import 'package:golab/ui/sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SettingPage extends HookWidget {
  const SettingPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SettingPage()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = useProvider(authControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Settings'),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text('ログアウト'),
                enabled: true,
                onTap: () {
                  authNotifier.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignIn(fullscreenDialog: false)
                      )
                  );
                },
              )
          )
      ),
    );
  }
}