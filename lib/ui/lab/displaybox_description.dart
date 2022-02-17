import 'package:flutter/material.dart';
import 'package:golab/main.dart';
import 'package:golab/ui/lab/lab_editing_description.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DescriptionDisplayBoxWidget extends HookWidget {

  const DescriptionDisplayBoxWidget({Key? key,}) : super(key: key);

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
              state.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis
            ),
          ),
          IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GetDescription()
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
