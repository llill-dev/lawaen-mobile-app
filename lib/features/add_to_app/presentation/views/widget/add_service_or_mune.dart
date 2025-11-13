import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_container.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/conditions_widget.dart';

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
          Text("Add services or menu", style: Theme.of(context).textTheme.headlineMedium),
          10.verticalSpace,
          CheckBoxRow(
            title: "services",
            value: services,
            onChanged: (value) {
              setState(() {
                services = value!;
              });
            },
          ),
          CheckBoxRow(
            title: "menu",
            value: menu,
            onChanged: (value) {
              setState(() {
                menu = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
