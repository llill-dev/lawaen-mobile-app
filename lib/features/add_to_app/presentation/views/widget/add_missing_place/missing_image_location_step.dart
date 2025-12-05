import 'package:flutter/material.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/upload_file.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/determine_location.dart';

class MissingImageLocationStep extends StatelessWidget {
  const MissingImageLocationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: const [UploadFile(), SizedBox(height: 24), DetermineLocation()]);
  }
}
