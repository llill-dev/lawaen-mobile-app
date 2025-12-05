import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_missing_place_cubit/add_missing_place_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/upload_image.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/determine_location.dart';

class MissingImageLocationStep extends StatelessWidget {
  const MissingImageLocationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMissingPlaceFormCubit, AddMissingPlaceFormState>(
      builder: (context, state) {
        return Column(
          children: [
            UploadImage(
              imageFile: state.imageFile,
              onImageSelected: (file) {
                context.read<AddMissingPlaceFormCubit>().updateImageFile(file);
              },
            ),
            SizedBox(height: 24),
            LocationPickerField(
              latitude: state.latitude,
              longitude: state.longitude,
              onLocationSelected: (lat, lng) {
                context.read<AddMissingPlaceFormCubit>().updateLocation(lat, lng);
              },
            ),
          ],
        );
      },
    );
  }
}
