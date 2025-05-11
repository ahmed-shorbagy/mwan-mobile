import 'package:flutter/material.dart';
import 'package:mwan_mobile/features/home/presentation/pages/initiative_expandable_details_page.dart';

class InitiativeDetailsPage extends StatefulWidget {
  final Map<String, dynamic> initiativeData;

  const InitiativeDetailsPage({super.key, required this.initiativeData});

  @override
  State<InitiativeDetailsPage> createState() => _InitiativeDetailsPageState();
}

class _InitiativeDetailsPageState extends State<InitiativeDetailsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onInitiativeSelected(Map<String, dynamic> initiative) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) =>
                InitiativeExpandableDetailsPage(initiative: initiative),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.initiativeData['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildSearchBar(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildInitiativeCard(
                      title: 'المدخرات النقدية بالعملات الصعبة',
                      id: '1.2',
                      status: 'متقدم',
                      progress1: 0.56,
                      progress2: 0.43,
                      isFavorite: false,
                      onTap:
                          () => _onInitiativeSelected({
                            'title': 'المدخرات النقدية بالعملات الصعبة',
                            'progress': 0.56,
                            'targetDate': '05/25/2026',
                            'objectives': [
                              {
                                'date': '05/25/2026',
                                'description':
                                    'استكمال المشروع وتشغيله بالكامل',
                                'progress': 0.56,
                              },
                              {
                                'date': '05/25/2022',
                                'description':
                                    'بدء تنفيذ المشروع وفق الخطة الزمنية المحددة',
                                'progress': 0.43,
                              },
                            ],
                          }),
                    ),
                    _buildInitiativeCard(
                      title: 'زيادة القدرة التخزينية للمياه',
                      id: '0.4',
                      status: 'متأخر',
                      progress1: 0.56,
                      progress2: 0.43,
                      isFavorite: true,
                      onTap:
                          () => _onInitiativeSelected({
                            'title': 'زيادة القدرة التخزينية للمياه',
                            'progress': 0.1,
                            'targetDate': '05/25/2026',
                            'objectives': [
                              {
                                'date': '05/25/2026',
                                'description':
                                    'استكمال المشروع وتشغيله بالكامل',
                                'progress': 0.1,
                              },
                              {
                                'date': '05/25/2022',
                                'description':
                                    'بدء تنفيذ المشروع وفق الخطة الزمنية المحددة',
                                'progress': 0.1,
                              },
                            ],
                          }),
                    ),
                    _buildInitiativeCard(
                      title: 'نسب دعم المحتاجين في المناطق الجا...',
                      id: '0.6',
                      status: 'متقدم',
                      progress1: 0.56,
                      progress2: 0.43,
                      isFavorite: false,
                      onTap:
                          () => _onInitiativeSelected({
                            'title': 'نسب دعم المحتاجين في المناطق الجا...',
                            'progress': 0.56,
                            'targetDate': '05/25/2026',
                            'objectives': [
                              {
                                'date': '05/25/2026',
                                'description':
                                    'استكمال المشروع وتشغيله بالكامل',
                                'progress': 0.56,
                              },
                              {
                                'date': '05/25/2022',
                                'description':
                                    'بدء تنفيذ المشروع وفق الخطة الزمنية المحددة',
                                'progress': 0.43,
                              },
                            ],
                          }),
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

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white.withOpacity(0.8),
            ),
            color: Colors.white.withOpacity(0.8),
          ),
          Icon(
            Icons.favorite_border,
            color: Colors.white.withOpacity(0.8),
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.white.withOpacity(0.3), size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'البحث',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitiativeCard({
    required String title,
    required String id,
    required String status,
    required double progress1,
    required double progress2,
    required bool isFavorite,
    VoidCallback? onTap,
  }) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.amber : Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage('https://picsum.photos/200'),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF333333),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    id,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        status == 'متقدم'
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: status == 'متقدم' ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: TextStyle(
                          color: status == 'متقدم' ? Colors.green : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                _buildProgressIndicator(progress1, Colors.blue),
                const SizedBox(width: 8),
                _buildProgressIndicator(progress2, Colors.green),
              ],
            ),
          ],
        ),
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
            backgroundColor: Colors.grey[850],
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
