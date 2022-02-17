import 'package:flutter/material.dart';

class ShowProgress{
  static void showProgressDialog(context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }
}