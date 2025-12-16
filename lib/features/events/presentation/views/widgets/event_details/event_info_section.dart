import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class EventInfoSection extends StatelessWidget {
  final String? description;
  final String? note;

  const EventInfoSection({super.key, this.description, this.note});

  bool get _hasDescription => description != null && description!.trim().isNotEmpty;

  bool get _hasNote => note != null && note!.trim().isNotEmpty;

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: ColorManager.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: ColorManager.primary),
      boxShadow: [
        BoxShadow(color: ColorManager.black.withValues(alpha: .25), blurRadius: 4, offset: const Offset(0, 4)),
      ],
    );
  }

  Widget _buildInfoContainer({required BuildContext context, required String title, required String content}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 12.w),
      decoration: _buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          8.verticalSpace,
          Text(content, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    if (_hasDescription) {
      children.add(
        _buildInfoContainer(context: context, title: LocaleKeys.description.tr(), content: description!.trim()),
      );
    }

    if (_hasNote) {
      if (children.isNotEmpty) children.add(12.verticalSpace);
      children.add(_buildInfoContainer(context: context, title: LocaleKeys.note.tr(), content: note!.trim()));
    }

    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }
}
