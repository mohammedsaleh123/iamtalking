import 'package:flutter/material.dart';
import 'package:iamtalking/generated/l10n.dart';

class PeopleView extends StatelessWidget {
  const PeopleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).people),
      ),
    );
  }
}
