import 'package:flutter/material.dart';
import 'package:iamtalking/core/extensions/center_extension.dart';
import 'package:iamtalking/generated/l10n.dart';

class AuthBanner extends StatelessWidget {
  const AuthBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Text(
        S.of(context).iamtalking,
      ).center(),
    );
  }
}
