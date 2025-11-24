import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/profile/presentation/views/widget/contact_us/contact_us_form.dart';

import 'widget/contact_us/contact_us_header.dart';

@RoutePage()
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(child: Column(children: [ContactUsHeader(), 24.verticalSpace, ContactUsForm()])),
      ),
    );
  }
}
