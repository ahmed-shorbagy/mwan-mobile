import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mwan_mobile/core/theme/app_theme.dart';

class MenuOption extends StatelessWidget {
  final String label;
  final String svgPath;
  final bool isActive;

  const MenuOption({
    super.key,
    required this.label,
    required this.svgPath,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 50,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primaryColor : const Color(0xFF252525),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isActive ? AppTheme.primaryColor : const Color(0xFF353535),
          width: 1,
        ),
        boxShadow: [
          if (isActive)
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(), // Empty container for equal spacing
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[400],
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color:
                    isActive
                        ? Colors.white.withOpacity(0.2)
                        : Colors.black.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgPath,
                  width: 18,
                  height: 18,
                  colorFilter: ColorFilter.mode(
                    isActive ? Colors.white : Colors.grey[400]!,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
