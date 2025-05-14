import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mwan_mobile/core/theme/app_theme.dart';
import 'package:mwan_mobile/core/utils/assets.dart';
import 'package:mwan_mobile/features/home/presentation/widgets/circular_menu_button.dart';

class BottomNavBar extends StatelessWidget {
  final VoidCallback onCenterButtonTap;
  final int currentIndex;
  final Function(int) onNavItemTapped;

  const BottomNavBar({
    super.key,
    required this.onCenterButtonTap,
    required this.currentIndex,
    required this.onNavItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Assets.imagesHandArrowUp, index: 0),
          _buildNavItem(Assets.imagesTwohand, index: 1),
          Transform.translate(
            offset: const Offset(0, -20),
            child: CircularMenuButton(
              onTap: onCenterButtonTap,
              icon: SvgPicture.asset(
                Assets.imagesWaterDrop,
                width: 22,
                height: 22,
                colorFilter: const ColorFilter.mode(
                  Colors.green,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          _buildNavItem(Assets.imagesUsersThree, index: 3),
          _buildNavItem(Assets.imagesKanban, index: 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(String assetPath, {required int index}) {
    final isSelected = currentIndex == index;

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color:
            isSelected
                ? AppTheme.primaryColor.withOpacity(0.1)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border:
            isSelected
                ? Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  width: 1.5,
                )
                : null,
      ),
      child: IconButton(
        onPressed: () => onNavItemTapped(index),
        padding: EdgeInsets.zero,
        icon: SvgPicture.asset(
          assetPath,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            isSelected ? AppTheme.primaryColor : Colors.grey,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
