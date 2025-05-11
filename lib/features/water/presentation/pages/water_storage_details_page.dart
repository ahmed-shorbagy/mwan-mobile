import 'package:flutter/material.dart';
import 'package:mwan_mobile/core/theme/app_theme.dart';

class WaterStorageDetailsPage extends StatelessWidget {
  final Map<String, dynamic> cardData;

  const WaterStorageDetailsPage({super.key, required this.cardData});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cardData['title'] as String, style: AppTheme.headline3),
              const SizedBox(height: 24),
              _buildStorageIndicator(),
              const SizedBox(height: 24),
              _buildExpandableSection(
                title: 'الأهداف المقررة',
                content: Column(
                  children: [
                    for (final objective in cardData['objectives'] as List)
                      _buildTimelineItem(
                        date: objective['date'] as String,
                        description: objective['description'] as String,
                        progress: objective['progress'] as double,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildExpandableSection(
                title: 'الخطة الحالية',
                content: Text(
                  'تفاصيل الخطة الحالية وخطوات التنفيذ...',
                  style: AppTheme.bodyText1,
                ),
              ),
              const SizedBox(height: 16),
              _buildExpandableSection(
                title: 'المستهدفات',
                content: Text(
                  'تفاصيل المستهدفات المطلوب تحقيقها...',
                  style: AppTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStorageIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('نسبة الإنجاز', style: AppTheme.headline6),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: cardData['progress'] as double,
              backgroundColor: AppTheme.dividerColor,
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${((cardData['progress'] as double) * 100).toInt()}%',
                style: AppTheme.bodyText2,
              ),
              Text(cardData['targetDate'] as String, style: AppTheme.caption),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required Widget content,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(title, style: AppTheme.headline6),
          collapsedIconColor: AppTheme.textColor,
          iconColor: AppTheme.textColor,
          children: [
            Padding(padding: const EdgeInsets.all(16.0), child: content),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required String date,
    required String description,
    required double progress,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              Container(width: 2, height: 40, color: AppTheme.dividerColor),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: AppTheme.caption),
                const SizedBox(height: 4),
                Text(description, style: AppTheme.bodyText2),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppTheme.dividerColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryColor,
                    ),
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
