import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mwan_mobile/core/theme/app_theme.dart';
import 'package:mwan_mobile/core/utils/assets.dart';
import 'package:mwan_mobile/features/home/presentation/pages/cards_view.dart';

class SideMenuView extends StatelessWidget {
  const SideMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  children: [
                    _buildMenuItem(
                      context,
                      'البطاقات',
                      Assets.imagesCardsThree,
                      onTap:
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CardsView(),
                            ),
                          ),
                    ),
                    _buildMenuItem(
                      context,
                      'المبادرات',
                      Assets.imagesCrosshair,
                    ),
                    _buildMenuItem(
                      context,
                      'مؤشرات الأداء',
                      Assets.imagesTrendUp,
                    ),
                    _buildMenuItem(
                      context,
                      'الحالة الحالية',
                      Assets.imagesCurrencyEth,
                    ),
                    _buildMenuItem(context, 'التقارير', Assets.imagesFileText),
                    _buildMenuItem(
                      context,
                      'المختصين',
                      Assets.imagesFileDashed,
                    ),
                    _buildMenuItem(
                      context,
                      'متابعة مباشرة',
                      Assets.imagesMonitorPlay,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    String svgPath, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xff0D2C0F),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgPath,
                  width: 34,
                  height: 34,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(title, style: AppTheme.headline5),
          ],
        ),
      ),
    );
  }
}
