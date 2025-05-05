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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Notification icon with badge

          // User info with avatar
          const CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/men/32.jpg',
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحباً بك',
                style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w400),
              ),
              Text(
                'محمد أشرف👋',
                style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Spacer(),
          Stack(
            children: [
              const Icon(FontAwesomeIcons.bell, color: Colors.white, size: 28),
              Positioned(
                right: 0,
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
        ],
      ),
    );
  }
}
