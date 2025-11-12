import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';

import '../../../../../../app/core/widgets/primary_button.dart';

class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({super.key});

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  int selectedRating = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16.w, right: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) {
              final isSelected = index < selectedRating;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRating = index + 1;
                  });
                },
                child: Icon(
                  Icons.star_rounded,
                  size: 28.r,
                  color: isSelected ? ColorManager.orange : ColorManager.darkGrey,
                ),
              );
            }),
          ),
          16.verticalSpace,
          Text(
            "Writ your feedback :",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.orange),
          ),
          16.verticalSpace,
          Container(
            height: 120.h,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: ColorManager.white,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withValues(alpha: .25),
                  blurRadius: 13,
                  offset: const Offset(-3, 4),
                ),
              ],
              border: Border.all(color: ColorManager.primary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _controller,
              maxLines: null,
              expands: true,
              style: Theme.of(context).textTheme.headlineMedium,
              decoration: InputDecoration(
                hintText: "Write your feedback...",
                hintStyle: Theme.of(context).textTheme.headlineSmall,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          24.verticalSpace,
          Center(
            child: PrimaryButton(
              text: "Send",
              width: 150.w,
              onPressed: () {
                final feedback = _controller.text.trim();
                final rating = selectedRating;
                if (feedback.isEmpty || rating == 0) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Please provide both rating and feedback.")));
                  return;
                }
              },
            ),
          ),
          24.verticalSpace,
        ],
      ),
    );
  }
}
