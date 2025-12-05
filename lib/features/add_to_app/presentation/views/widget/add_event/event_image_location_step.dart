import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/determine_location.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/upload_file.dart';

class EventImageLocationStep extends StatelessWidget {
  const EventImageLocationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [16.verticalSpace, const UploadFile(), 24.verticalSpace, const DetermineLocation()]);
  }
}
