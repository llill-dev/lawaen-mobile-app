import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_event_cubit/add_event_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/determine_location.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/upload_image.dart';

class EventImageLocationStep extends StatelessWidget {
  const EventImageLocationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventFormCubit, AddEventFormState>(
      builder: (context, state) {
        return Column(
          children: [
            16.verticalSpace,

            UploadImage(
              imageFile: state.params.imageFile,
              onImageSelected: (file) {
                context.read<AddEventFormCubit>().updateImage(file);
              },
            ),

            24.verticalSpace,
            LocationPickerField(
              latitude: state.params.location.lat,
              longitude: state.params.location.lng,
              onLocationSelected: (lat, lng) {
                context.read<AddEventFormCubit>().updateLocation(lat, lng);
              },
            ),
          ],
        );
      },
    );
  }
}
