import 'package:flutter/material.dart';
import 'package:golab/ui/lab/lab_editing_application.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../main.dart';

class ApplicationDisplayBoxWidget extends HookWidget {

  const ApplicationDisplayBoxWidget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(labProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 100),borderRadius: BorderRadius.circular(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              state.application,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
              onPressed: (){ Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GetApplication()
                    )
                );
              },
              icon: const Icon(Icons.edit),
              color: const Color.fromRGBO(150, 150, 150, 100)
          )
        ],
      ),
    );
  }
}
