import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class WeDontCollectDataText extends StatelessWidget {
  const WeDontCollectDataText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.noDataCollection.tr(),
      style: Theme.of(context).textTheme.headlineSmall,
      textAlign: TextAlign.center,
    ).horizontalPadding(padding: 16.w);
  }
}
