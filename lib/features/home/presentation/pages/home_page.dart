import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mwan_mobile/core/utils/assets.dart';
import 'package:mwan_mobile/features/home/presentation/pages/dummy_views.dart';
import 'package:mwan_mobile/features/home/presentation/pages/side_menu_view.dart';
import 'package:mwan_mobile/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:mwan_mobile/features/home/presentation/widgets/menu_option.dart';
import 'package:mwan_mobile/features/home/presentation/widgets/user_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _isMenuOpen = false;
  late AnimationController _menuAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  int _currentIndex = 4; // Start with Kanban (home) selected

  @override
  void initState() {
    super.initState();
    _initMenuAnimations();
    // Set app to RTL mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void _initMenuAnimations() {
    _menuAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _menuAnimationController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _menuAnimationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _menuAnimationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _menuAnimationController.forward();
      } else {
        _menuAnimationController.reverse();
      }
    });
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getCurrentView() {
    switch (_currentIndex) {
      case 0: // HandArrowUp - Side Menu View
        return const SideMenuView();
      case 1: // TwoHands
        return const TwoHandsView();
      case 2: // Center Button - No view
        return const SizedBox();
      case 3: // Users
        return const UsersView();
      case 4: // Kanban (Home)
      default:
        return _buildHomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const UserHeader(),
                Expanded(child: _getCurrentView()),
                BottomNavBar(
                  onCenterButtonTap: _toggleMenu,
                  currentIndex: _currentIndex,
                  onNavItemTapped: _onNavItemTapped,
                ),
              ],
            ),
          ),
          if (_isMenuOpen) _buildOverlayMenu(),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [],
      ),
    );
  }

  Widget _buildOverlayMenu() {
    final menuItems = [
      {'label': 'أمن الدولة', 'svg': Assets.imagesSheild},
      {'label': 'المياه', 'svg': Assets.imagesWaterDrop, 'active': false},
      {'label': 'الطاقة', 'svg': Assets.imagesEnergy},
      {'label': 'الغذاء', 'svg': Assets.imagesCarrot},
      {'label': 'الصحة', 'svg': Assets.imagesAmbulance},
    ];

    return Positioned.fill(
      child: GestureDetector(
        onTap: _toggleMenu,
        behavior: HitTestBehavior.opaque,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            color: const Color(0xDD212121),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(menuItems.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: AnimatedBuilder(
                          animation: _menuAnimationController,
                          builder: (context, child) {
                            final delay = index * 0.1;
                            final value =
                                _menuAnimationController.value > delay
                                    ? (_menuAnimationController.value - delay) /
                                        (1 - delay)
                                    : 0.0;

                            return Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: Opacity(
                                opacity: value,
                                child: MenuOption(
                                  label: menuItems[index]['label'] as String,
                                  svgPath: menuItems[index]['svg'] as String,
                                  isActive:
                                      menuItems[index]['active'] as bool? ??
                                      false,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
