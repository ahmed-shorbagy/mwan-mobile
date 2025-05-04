import 'package:flutter/material.dart';
import 'package:mwan_mobile/core/theme/app_theme.dart';
import 'package:mwan_mobile/features/home/presentation/widgets/circular_menu_button.dart';

class BottomNavBar extends StatelessWidget {
  final VoidCallback onCenterButtonTap;

  const BottomNavBar({super.key, required this.onCenterButtonTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Icons.grid_view_rounded, isSelected: true),
          _buildNavItem(Icons.star_border_outlined),
          CircularMenuButton(onTap: onCenterButtonTap),
          _buildNavItem(Icons.pie_chart_outline),
          _buildNavItem(Icons.shield_outlined),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, {bool isSelected = false}) {
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
        onPressed: () {},
        padding: EdgeInsets.zero,
        icon: Icon(
          icon,
          color: isSelected ? AppTheme.primaryColor : Colors.grey,
          size: 24,
        ),
      ),
    );
  }
}
