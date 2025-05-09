import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:flutter/cupertino.dart';

class Indicator extends StatelessWidget {
  const Indicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      color: AppStyles.textMain,
    );
  }
}
