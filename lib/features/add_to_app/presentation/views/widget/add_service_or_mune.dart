import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_container.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/conditions_widget.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class AddServiceOrMune extends StatefulWidget {
  const AddServiceOrMune({super.key});

  @override
  State<AddServiceOrMune> createState() => _AddServiceOrMuneState();
}

class _AddServiceOrMuneState extends State<AddServiceOrMune> {
  bool services = false;
  bool menu = false;
  @override
  Widget build(BuildContext context) {
    return AddContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.addServiceOrMenuTitle.tr(), style: Theme.of(context).textTheme.headlineMedium),
          10.verticalSpace,
          CheckBoxRow(
            title: LocaleKeys.services.tr(),
            value: services,
            onChanged: (value) {
              setState(() {
                services = value!;
              });
              if (services) {
                context.pushRoute(ServicesManagerRoute());
              }
            },
          ),
          CheckBoxRow(
            title: LocaleKeys.menu.tr(),
            value: menu,
            onChanged: (value) {
              setState(() {
                menu = value!;
                context.pushRoute(MuneManagerRoute());
              });
            },
          ),
        ],
      ),
    );
  }
}
