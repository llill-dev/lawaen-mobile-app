import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/primary_back_button.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import '../../../../app/resources/color_manager.dart';
import 'widgets/mune/mune_header.dart';
import 'widgets/mune/mune_item.dart';
import 'widgets/mune/opening_closing_time.dart';

@RoutePage()
class MuneScreen extends StatelessWidget {
  const MuneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MuneItemModel> menuItems = [
      MuneItemModel(
        title: "Bruschetta Trio",
        price: "12\$",
        description: "Three varieties of artisan bread topped with heirloom tomatoes, olive tapenade, and ricotta.",
        tag: "Vegetarian",
        tagColor: ColorManager.muneGreen,
        image: ImageManager.mune,
      ),
      MuneItemModel(
        title: "Keto Chicken Bowl",
        price: "18\$",
        description: "Grilled chicken served with avocado, cauliflower rice, and olive oil dressing.",
        tag: "Keto",
        tagColor: ColorManager.muneGreen,
        image: ImageManager.mune,
      ),
      MuneItemModel(
        title: "Vegan Delight",
        price: "15\$",
        description: "A fresh mix of quinoa, chickpeas, and roasted veggies with tahini sauce.",
        tag: "Vegan",
        tagColor: ColorManager.muneGreen,
        image: ImageManager.mune,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            SliverToBoxAdapter(child: PrimaryBackButton(iconOnlay: true).horizontalPadding(padding: 16.w)),
            const MenuHeader(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => MuneItme(item: menuItems[index]),
                childCount: menuItems.length,
              ),
            ),
            const OpeningClosingTime(),
          ],
        ),
      ),
    );
  }
}
