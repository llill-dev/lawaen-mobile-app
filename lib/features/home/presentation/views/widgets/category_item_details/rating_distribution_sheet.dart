import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../app/resources/color_manager.dart';

class RatingDistributionSheet extends StatelessWidget {
  final Map<String, dynamic> distribution;

  const RatingDistributionSheet({super.key, required this.distribution});

  /// Normalize API keys (handles: two / tow / three / etc)
  Map<int, int> _normalizeDistribution() {
    final Map<int, int> result = {};

    for (final entry in distribution.entries) {
      final key = entry.key.toLowerCase();
      final value = (entry.value as num?)?.toInt() ?? 0;

      if (key.contains('one')) result[1] = value;
      if (key.contains('two') || key.contains('tow')) result[2] = value;
      if (key.contains('three')) result[3] = value;
      if (key.contains('four')) result[4] = value;
      if (key.contains('five')) result[5] = value;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final normalized = _normalizeDistribution();
    final totalRatings = normalized.values.fold<int>(0, (a, b) => a + b);

    if (normalized.isEmpty || totalRatings == 0) {
      return Padding(
        padding: EdgeInsets.all(24.w),
        child: Center(child: Text("No ratings yet", style: Theme.of(context).textTheme.labelMedium)),
      );
    }

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          final star = 5 - index;
          final count = normalized[star] ?? 0;
          final percent = count / totalRatings;

          return _RatingBarRow(star: star, count: count, percent: percent);
        }),
      ),
    );
  }
}

class _RatingBarRow extends StatelessWidget {
  final int star;
  final int count;
  final double percent;

  const _RatingBarRow({required this.star, required this.count, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Text("$star", style: Theme.of(context).textTheme.labelMedium),
          4.horizontalSpace,
          Icon(Icons.star, color: ColorManager.orange, size: 16.r),
          8.horizontalSpace,
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: percent,
                minHeight: 8.h,
                backgroundColor: ColorManager.lightGrey,
                valueColor: AlwaysStoppedAnimation(ColorManager.orange),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
