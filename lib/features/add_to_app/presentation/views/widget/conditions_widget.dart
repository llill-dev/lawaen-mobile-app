import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class CheckBoxRow extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool?)? onChanged;
  const CheckBoxRow({super.key, required this.title, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          checkColor: ColorManager.primary,
          activeColor: ColorManager.blackSwatch[3],
        ),
        4.horizontalSpace,
        Flexible(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorManager.blackSwatch[12]),
          ),
        ),
      ],
    );
  }
}

class ConditionsWidget extends StatefulWidget {
  const ConditionsWidget({super.key});

  @override
  State<ConditionsWidget> createState() => _ContionsState();
}

class _ContionsState extends State<ConditionsWidget> {
  bool acceptTerms = false;
  bool acceptSubscriptionCost = false;
  bool acceptInformation = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          CheckBoxRow(
            title: "I accept the terms and conditions",
            value: acceptTerms,
            onChanged: (value) {
              setState(() {
                acceptTerms = value!;
              });
            },
          ),
          8.verticalSpace,
          CheckBoxRow(
            title: "I have reviewed the subscription cost",
            value: acceptSubscriptionCost,
            onChanged: (value) {
              setState(() {
                acceptSubscriptionCost = value!;
              });
            },
          ),
          8.verticalSpace,
          CheckBoxRow(
            title: "All the information that I have filled in is correct and at my own risk",
            value: acceptInformation,
            onChanged: (value) {
              setState(() {
                acceptInformation = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
