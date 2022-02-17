import 'package:flutter/material.dart';
import 'package:golab/main.dart';
import 'package:golab/ui/sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Launcher extends HookWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userNotifier = useProvider(authControllerProvider.notifier);

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final isStudent = await userNotifier.isStudent();
      final isResearcher = await userNotifier.isResearcher();

      if(userNotifier.isSigningIn() && isStudent){
        Navigator.pushReplacementNamed(context, '/student');
      } else if(userNotifier.isSigningIn() && isResearcher){
        Navigator.pushReplacementNamed(context, '/researcher');
      } else {
        SignIn.pushReplacement(context);
      }
    });

    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            semanticsLabel: 'Now Launching',
          ),
        ),
      ),
    );
  }
}