import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/features/offers/presentation/cubit/offers_cubit/offers_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class OffersFilterBottomSheet extends StatefulWidget {
  const OffersFilterBottomSheet({super.key});

  @override
  State<OffersFilterBottomSheet> createState() => _OffersFilterBottomSheetState();
}

class _OffersFilterBottomSheetState extends State<OffersFilterBottomSheet> {
  late Set<String> selected;

  @override
  void initState() {
    super.initState();
    selected = Set.from(context.read<OffersCubit>().selectedTypes);
  }

  @override
  Widget build(BuildContext context) {
    final offerTypes = context.read<OffersCubit>().state.offerTypes;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: offerTypes.map((type) {
                  final isSelected = selected.contains(type.id);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected ? selected.remove(type.id) : selected.add(type.id);
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? ColorManager.green : ColorManager.lightGrey,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected ? ColorManager.green : Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          Expanded(child: Text(type.name)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          24.verticalSpace,

          PrimaryButton(
            text: LocaleKeys.apply.tr(),
            onPressed: () {
              final cubit = context.read<OffersCubit>();
              cubit.updateSelectedTypes(selected);

              if (selected.isNotEmpty) {
                cubit.getOffersForSelectedTypes();
              }

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
