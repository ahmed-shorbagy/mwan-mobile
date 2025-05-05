import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuOption extends StatelessWidget {
  final String label;
  final String svgPath;
  final bool isActive;
  final VoidCallback? onTap;

  const MenuOption({
    super.key,
    required this.label,
    required this.svgPath,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF333333), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              SvgPicture.asset(
                svgPath,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
