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
    },
    {
      'title': 'المدخرات النقدية بالعملات الصعبة',
      'id': '1.2',
      'status': 'متقدم',
      'progress1': 0.56,
      'progress2': 0.43,
      'isFavorite': false,
    },
    {
      'title': 'زيادة القدرة التخزينية للمياه',
      'id': '0.4',
      'status': 'متأخر',
      'progress1': 0.56,
      'progress2': 0.43,
      'isFavorite': true,
    },
    {
      'title': 'نسب دعم المحتاجين في المناطق الجافه...',
      'id': '0.4',
      'status': 'متأخر',
      'progress1': 0.56,
      'progress2': 0.43,
      'isFavorite': true,
    },
    {
      'title': 'المدخرات النقدية بالعملات الصعبة',
      'id': '0.4',
      'status': 'متأخر',
      'progress1': 0.56,
      'progress2': 0.43,
      'isFavorite': true,
    },

    // Add more cards here
  ];

  List<Map<String, dynamic>> get filteredCards {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) return _cards;
    return _cards
        .where((card) => card['title'].toString().toLowerCase().contains(query))
        .toList();
  }

  void _navigateToDetails(Map<String, dynamic> cardData) {
    context.push(
      '${AppRouter.initiativeDetailsRoute}/${cardData['id']}',
      extra: cardData,
    );
  }

  void _toggleFavorite(int index) {
    setState(() {
      _cards[index]['isFavorite'] = !_cards[index]['isFavorite'];
    });
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
                child: ListView.builder(
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
