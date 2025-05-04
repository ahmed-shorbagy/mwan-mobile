import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mwan_mobile/core/theme/app_theme.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Notification icon with badge
          Stack(
            children: [
              const Icon(FontAwesomeIcons.bell, color: Colors.white, size: 28),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          // User info with avatar
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'مرحباً بك',
                    style: AppTheme.headline4.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '👋محمد أشرف',
                    style: AppTheme.headline4.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/32.jpg',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
