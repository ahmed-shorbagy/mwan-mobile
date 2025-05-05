import 'package:flutter/material.dart';
import 'package:mwan_mobile/core/theme/app_theme.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'مبادرة 3',
                            style: TextStyle(color: Colors.green, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Icon(
                    cardData['isFavorite'] ? Icons.star : Icons.star_border,
                    color: cardData['isFavorite'] ? Colors.amber : Colors.grey,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(cardData['title'], style: AppTheme.headline5),
            const SizedBox(height: 16),
            Row(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        'https://picsum.photos/200',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        cardData['id'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildStatusIndicator(cardData['status']),
                  ],
                ),
                const Spacer(),
                _buildProgressIndicator(cardData['progress1'], Colors.blue),
                const SizedBox(width: 8),
                _buildProgressIndicator(cardData['progress2'], Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    final isAdvanced = status == 'متقدم';
    final color = isAdvanced ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(status, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(double value, Color color) {
    return SizedBox(
      width: 36,
      height: 36,
      child: Stack(
        children: [
          CircularProgressIndicator(
            value: value,
            backgroundColor: Colors.grey[800],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: 3,
          ),
          Center(
            child: Text(
              '${(value * 100).toInt()}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
