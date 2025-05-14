import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mwan_mobile/core/utils/assets.dart';

class InitiativeCard extends StatelessWidget {
  final Map<String, dynamic> cardData;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const InitiativeCard({
    super.key,
    required this.cardData,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  void _showUserInfoDialog(BuildContext context) {
    final userData = cardData['user'] as Map<String, dynamic>;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=100&auto=format&fit=crop',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  userData['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'المسمى الوظيفي: ${userData['title']}',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'البريد الإلكتروني: ${userData['email']}',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 16),
                TextButton(
                  child: const Text('إغلاق'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = cardData['user'] as Map<String, dynamic>;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[900]!, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Initiative badge at top
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Initiative badge (left for RTL view)
                Row(
                  children: [
                    const Text(
                      '3 مبادرة',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    SvgPicture.asset(
                      Assets.imagesSealCheck,
                      width: 18,
                      height: 18,
                    ),
                  ],
                ),
                // Favorite icon (right for RTL)
                GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Icon(
                    cardData['isFavorite'] ? Icons.star : Icons.star_outline,
                    color:
                        cardData['isFavorite']
                            ? Colors.amber
                            : Colors.grey[600],
                    size: 24,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Title with padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                cardData['title'],
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Bottom row with user avatar, ID, status and progress indicators
            Row(
              children: [
                // Progress indicators on left side for RTL
                _buildProgressIndicator(cardData['progress2'], Colors.green),
                const SizedBox(width: 10),
                _buildProgressIndicator(cardData['progress1'], Colors.blue),

                const SizedBox(width: 12),

                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusBackgroundColor(cardData['status']),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    cardData['status'],
                    style: TextStyle(
                      color: _getStatusTextColor(cardData['status']),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Spacer(),

                // ID badge and User avatar on right side for RTL
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF333333),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    cardData['id'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // User avatar
                GestureDetector(
                  onTap: () => _showUserInfoDialog(context),
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=100&auto=format&fit=crop',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case 'متقدم':
        return Colors.green.withOpacity(0.2);
      case 'متأخر':
        return Colors.red.withOpacity(0.2);
      default:
        return Colors.orange.withOpacity(0.2);
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'متقدم':
        return Colors.green;
      case 'متأخر':
        return Colors.white;
      default:
        return Colors.orange;
    }
  }

  Widget _buildProgressIndicator(double value, Color color) {
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value,
            backgroundColor: Colors.grey[850],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: 4,
          ),
          Text(
            '${(value * 100).toInt()}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
