import 'package:flutter/material.dart';
import 'package:mwan_mobile/core/theme/app_theme.dart';

class SideMenu extends StatelessWidget {
  final VoidCallback onClose;

  const SideMenu({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    const menuIcons = [
      Icons.credit_card_outlined,
      Icons.auto_graph_outlined,
      Icons.show_chart,
      Icons.medical_information_outlined,
      Icons.description_outlined,
      Icons.bar_chart,
      Icons.format_list_bulleted,
    ];

    const menuLabels = [
      'البطاقات',
      'المبادرات',
      'مؤشرات الأداء',
      'الحالة الحالية',
      'التقارير',
      'الإحصائيات',
      'قائمة مبادرات',
    ];

    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            // Header with notification bell and user info
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Row(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: onClose,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'مرحباً بك',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text('👋', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 4),
                      Text(
                        'محمد الشريف',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          'https://randomuser.me/api/portraits/men/32.jpg',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Menu items
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: menuLabels.length,
                itemBuilder: (context, index) {
                  final bool isActive = index == 2; // مؤشرات الأداء is active

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isActive ? Color(0xFF003D29) : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        // Active indicator
                        Container(
                          width: 4,
                          height: 56,
                          color:
                              isActive
                                  ? AppTheme.primaryColor
                                  : Colors.transparent,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color:
                                        isActive
                                            ? AppTheme.primaryColor
                                            : Color(0xFF2A2A2A),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    menuIcons[index],
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  menuLabels[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom floating action button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
