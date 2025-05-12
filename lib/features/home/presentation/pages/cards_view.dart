import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mwan_mobile/core/router/app_router.dart';
import 'package:mwan_mobile/core/theme/app_theme.dart';
import 'package:mwan_mobile/features/home/presentation/widgets/initiative_card.dart';

class CardsView extends StatefulWidget {
  const CardsView({super.key});

  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  int _selectedTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _tabs = [
    'الكل',
    'المفضلة',
    'المعتمدة',
    'غير المعتمدة',
    'المتأخرة',
  ];

  final List<Map<String, dynamic>> _cards = [
    {
      'title': 'المدخرات النقدية بالعملات الصعبة',
      'id': '1.2',
      'status': 'متقدم',
      'progress1': 0.56,
      'progress2': 0.43,
      'isFavorite': false,
      'user': {
        'name': 'أحمد محمد',
        'title': 'مدير المبادرة',
        'email': 'ahmed@example.com',
        'image': 'https://picsum.photos/id/1/200',
      },
    },
    {
      'title': 'المدخرات النقدية بالعملات الصعبة',
      'id': '1.2',
      'status': 'متقدم',
      'progress1': 0.56,
      'progress2': 0.43,
      'isFavorite': false,
      'user': {
        'name': 'سارة أحمد',
        'title': 'منسق المبادرة',
        'email': 'sara@example.com',
        'image': 'https://picsum.photos/id/2/200',
      },
    },
    {
      'title': 'زيادة القدرة التخزينية للمياه',
      'id': '0.4',
      'status': 'متأخر',
      'progress1': 0.56,
      'progress2': 0.43,
      'isFavorite': true,
      'user': {
        'name': 'محمد علي',
        'title': 'مدير المشروع',
        'email': 'mohamed@example.com',
        'image': 'https://picsum.photos/id/3/200',
      },
    },
    {
      'title': 'نسب دعم المحتاجين في المناطق الجافه...',
      'id': '0.4',
      'status': 'متأخر',
      'progress1': 0.56,
      'progress2': 0.43,
      'isFavorite': true,
      'user': {
        'name': 'فاطمة خالد',
        'title': 'مشرف المبادرة',
        'email': 'fatima@example.com',
        'image': 'https://picsum.photos/id/4/200',
      },
    },
    {
      'title': 'المدخرات النقدية بالعملات الصعبة',
      'id': '0.4',
      'status': 'متأخر',
      'progress1': 0.56,
      'progress2': 0.43,
      'isFavorite': true,
      'user': {
        'name': 'خالد عبدالله',
        'title': 'مدير التنفيذ',
        'email': 'khalid@example.com',
        'image': 'https://picsum.photos/id/5/200',
      },
    },

    // Add more cards here
  ];

  List<Map<String, dynamic>> get filteredCards {
    // First filter by search query
    List<Map<String, dynamic>> results =
        _searchController.text.isEmpty
            ? _cards
            : _cards
                .where(
                  (card) => card['title'].toString().toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ),
                )
                .toList();

    // Then filter by selected tab
    switch (_selectedTabIndex) {
      case 1: // المفضلة (Favorites)
        return results.where((card) => card['isFavorite'] == true).toList();
      case 2: // المعتمدة (Approved)
        return results.where((card) => card['status'] == 'متقدم').toList();
      case 3: // غير المعتمدة (Not Approved)
        // Return cards that are not "متقدم" (advanced)
        return results.where((card) => card['status'] != 'متقدم').toList();
      case 4: // المتأخرة (Delayed)
        return results.where((card) => card['status'] == 'متأخر').toList();
      default: // الكل (All)
        return results;
    }
  }

  void _navigateToDetails(Map<String, dynamic> cardData) {
    context.push(
      '${AppRouter.initiativeDetailsRoute}/${cardData['id']}',
      extra: cardData,
    );
  }

  void _toggleFavorite(int index) {
    // Find the index in the original _cards list
    final card = filteredCards[index];
    final originalIndex = _cards.indexWhere(
      (c) =>
          c['id'] == card['id'] &&
          c['title'] == card['title'] &&
          c['user']['name'] == card['user']['name'],
    );

    if (originalIndex != -1) {
      setState(() {
        _cards[originalIndex]['isFavorite'] =
            !_cards[originalIndex]['isFavorite'];
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabs(),
              Expanded(
                child:
                    filteredCards.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: filteredCards.length,
                          itemBuilder: (context, index) {
                            final card = filteredCards[index];
                            return InitiativeCard(
                              cardData: card,
                              onTap: () => _navigateToDetails(card),
                              onFavoriteToggle: () => _toggleFavorite(index),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    String message;
    switch (_selectedTabIndex) {
      case 1:
        message = 'لا توجد مبادرات مفضلة';
        break;
      case 2:
        message = 'لا توجد مبادرات معتمدة';
        break;
      case 3:
        message = 'لا توجد مبادرات غير معتمدة';
        break;
      case 4:
        message = 'لا توجد مبادرات متأخرة';
        break;
      default:
        message = 'لا توجد مبادرات';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open, size: 64, color: Colors.grey[600]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(color: Colors.grey[400], fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text('البطاقات', style: AppTheme.headline2),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[850]!, width: 1),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() {}),
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey, size: 20),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Icon(
            FontAwesomeIcons.sliders,
            color: AppTheme.primaryColor,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 30,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _tabs.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedTabIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedTabIndex = index),
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              child:
                  isSelected
                      ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppTheme.cardColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            _tabs[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      : Center(
                        child: Text(
                          _tabs[index],
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
            ),
          );
        },
      ),
    );
  }
}
