import 'package:flutter/material.dart';

import 'SafeScroll.dart';

class KeyboardAwareScrollView extends StatelessWidget {
  const KeyboardAwareScrollView({Key? key,  required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context, constraints)=> SafeScroll(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ConstrainedBox(
            constraints: BoxConstraints( maxHeight: constraints.maxHeight),
            child: child,
          ),
        ),
      ),
    );
  }
}
