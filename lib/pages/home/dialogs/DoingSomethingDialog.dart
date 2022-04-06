import 'dart:math';

import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class DoingSomethingDialog extends StatefulWidget {
  const DoingSomethingDialog({Key? key}) : super(key: key);

  @override
  State<DoingSomethingDialog> createState() => _DoingSomethingDialogState();
}

class _DoingSomethingDialogState extends State<DoingSomethingDialog> {


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Dialog(shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0))),
      insetPadding: const EdgeInsets.symmetric(horizontal: 15,),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(mainAxisSize : MainAxisSize.min,  children: [
          Text(
            S.of(context).doing_something,
            style: theme.textTheme.headline4
                ?.copyWith(color: theme.colorScheme.primary),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset("assets/images/robot.png", fit: BoxFit.fitWidth),
          ),


        ],),
      ),);
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: Random().nextInt(5)+1)).whenComplete((){if(mounted){
      Navigator.of(context).pop();
    }});
    super.initState();
  }
}
