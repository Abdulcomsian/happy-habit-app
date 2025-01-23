import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/store/services/coins_pack.dart';
import 'package:happy_habit/modules/store/services/store_item.dart';
import 'package:happy_habit/modules/store/shared/coins_pack_tile.dart';
import 'package:happy_habit/modules/store/shared/store_item_tile.dart';

import '../../../core/constants/asset_paths.dart';
import '../../../core/shared/widgets/custom_upgrade_widget.dart';

class StoreScreen extends StatefulWidget {
  static const id = 'StoreScreen';

  final bool shouldScrollToWallpaper;

  const StoreScreen({super.key, required this.shouldScrollToWallpaper});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<List<StoreItem>> _items = ValueNotifier([]);
  final ValueNotifier<List<CoinsPack>> _packs = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    if (widget.shouldScrollToWallpaper) {
      WidgetsBinding.instance.addPostFrameCallback(_scrollToWallpaper);
    }
  }

  // Function to scroll to a specific wallpaper index
  void _scrollToWallpaper([_]) {
    // Calculate the position to scroll to
    double position = 960.h; // Adjust item height if needed

    // Use animateTo to smoothly scroll to the wallpaper
    _scrollController.animateTo(
      position,
      duration: Duration(milliseconds: 500), // Scroll duration
      curve: Curves.easeInOut, // Scroll curve
    );
  }

  @override
  void dispose() {
    _items.dispose();
    _packs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Store',
      child: ListView(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          20.height,
          CustomUpgradeWidget(
            svg: AppIcons.crown,
            title: 'Pricing Plan',
            buttonText: 'Upgrade Plan',
            description: 'Lorem ipsum dolor sit amet,',
            onTap: _scrollToWallpaper,
          ),
          15.height,
          Text(
            'Accessories',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          10.height,
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: StoreItem.accessories.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 11.r,
              crossAxisSpacing: 11.r,
              childAspectRatio: 160.w / 230.h,
            ),
            itemBuilder: (context, i) => StoreItemTile(
              item: StoreItem.accessories[i],
              onTap: (value) => _items.value = [..._items.value, value],
            ),
          ),
          15.height,
          Text(
            'Outfits',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          10.height,
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: StoreItem.outfits.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15.r,
              crossAxisSpacing: 15.r,
              childAspectRatio: 160.w / 230.h,
            ),
            itemBuilder: (context, i) => StoreItemTile(
              onTap: _manageItems,
              item: StoreItem.outfits[i],
            ),
          ),
          15.height,
          Text(
            'Wallpapers',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          10.height,
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: StoreItem.wallpapers.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15.r,
              crossAxisSpacing: 15.r,
              childAspectRatio: 160.w / 230.h,
            ),
            itemBuilder: (context, i) => StoreItemTile(
              areWallpapers: true,
              onTap: _manageItems,
              item: StoreItem.wallpapers[i],
            ),
          ),
          20.height,
          Text(
            'XP boosts',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          15.height,
          CustomUpgradeWidget(
            svg: AppIcons.xp,
            title: 'XP boosts',
            buttonText: 'Boost XP Now',
            description: 'Lorem ipsum dolor sit amet,',
          ),
          20.height,
          Text(
            'Coins',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          15.height,
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: CoinsPack.pack.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 15.r,
              crossAxisSpacing: 15.r,
              childAspectRatio: 104.w / 115.h,
            ),
            itemBuilder: (context, i) => CoinsPackTile(
              onTap: _managePacks,
              pack: CoinsPack.pack[i],
            ),
          ),
          40.height,
        ],
      ),
    );
  }

  void _manageItems(StoreItem value) {
    if (_items.value.contains(value)) {
      _items.value = _items.value.where((item) => item != value).toList(); // Removes the item
    } else {
      _items.value = [..._items.value, value];
    }
  }

  void _managePacks(CoinsPack value) {
    if (_packs.value.contains(value)) {
      _packs.value = _packs.value.where((pack) => pack != value).toList(); // Removes the item
    } else {
      _packs.value = [..._packs.value, value];
    }
  }
}
