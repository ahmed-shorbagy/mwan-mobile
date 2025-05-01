import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mwan_mobile/core/constants/app_constants.dart';
import 'package:mwan_mobile/core/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        title: Text('محادثاتك', style: AppTheme.headline4),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Online users
                Text('متصل الآن', style: AppTheme.headline5),
                const SizedBox(height: 16),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[800],
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppTheme.backgroundColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'المستخدم ${index + 1}',
                              style: AppTheme.caption.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Recent chats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('المحادثات الأخيرة', style: AppTheme.headline5),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'عرض الكل',
                        style: AppTheme.bodyText2.copyWith(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey[800],
                          child: Icon(Icons.person, color: Colors.grey[600]),
                        ),
                        title: Text(
                          'محمد النور ${index + 1}',
                          style: AppTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'مرحبا، كيف حالك؟',
                          style: AppTheme.bodyText2.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '12:30',
                              style: AppTheme.caption.copyWith(
                                color: Colors.grey[400],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '2',
                                style: AppTheme.caption.copyWith(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          // Navigate to chat screen
                          context.go(AppConstants.chatRoute);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Floating menu items (displayed when center button is pressed)
          if (_isMenuOpen) _buildFloatingMenu(),

          // Semi-transparent background overlay when menu is open
          if (_isMenuOpen)
            GestureDetector(
              onTap: _toggleMenu,
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppTheme.bottomNavBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.grid_view, 'الرئيسية', 0),
          _buildNavItem(Icons.people_outline, 'الاتصالات', 1),
          _buildCenterButton(),
          _buildNavItem(Icons.chat_bubble_outline, 'المحادثات', 3),
          _buildNavItem(Icons.shield_outlined, 'الأمان', 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = index == 0; // Currently on home page

    return InkWell(
      onTap: () {
        // Handle navigation
        switch (index) {
          case 3: // Chat
            context.go(AppConstants.chatRoute);
            break;
          // Add other cases for other pages
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color:
                isSelected
                    ? AppTheme.primaryColor
                    : AppTheme.bottomNavUnselectedColor,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTheme.caption.copyWith(
              color:
                  isSelected
                      ? AppTheme.primaryColor
                      : AppTheme.bottomNavUnselectedColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: _toggleMenu,
      child: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            shape: BoxShape.circle,
          ),
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animationController,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingMenu() {
    return Positioned(
      bottom: 90,
      left: 0,
      right: 0,
      child: Column(
        children: [
          _buildFloatingMenuItem('الصداقة', Icons.verified_user, onTap: () {}),
          const SizedBox(height: 16),
          _buildFloatingMenuItem('المكالمة', Icons.phone, onTap: () {}),
          const SizedBox(height: 16),
          _buildFloatingMenuItem('الطاقة', Icons.flash_on, onTap: () {}),
          const SizedBox(height: 16),
          _buildFloatingMenuItem('الخدمة', Icons.business_center, onTap: () {}),
          const SizedBox(height: 16),
          _buildFloatingMenuItem('أمن الدولة', Icons.shield, onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildFloatingMenuItem(
    String label,
    IconData icon, {
    required Function() onTap,
  }) {
    return Center(
      child: GestureDetector(
        onTap: () {
          onTap();
          _toggleMenu();
        },
        child: Container(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTheme.bodyText2),
              Icon(icon, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
