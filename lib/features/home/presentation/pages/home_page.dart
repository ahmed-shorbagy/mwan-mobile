import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mwan_mobile/core/router/app_router.dart';
import 'package:mwan_mobile/core/utils/assets.dart';
import 'package:mwan_mobile/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:mwan_mobile/features/home/presentation/widgets/menu_option.dart';
import 'package:mwan_mobile/features/home/presentation/widgets/user_header.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex;
  final Widget child;

  const HomePage({super.key, required this.selectedIndex, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _isMenuOpen = false;
  late AnimationController _menuAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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
    switch (index) {
      case 0:
        GoRouter.of(context).go(AppRouter.sideMenuRoute);
        break;
      case 1:
        GoRouter.of(context).go(AppRouter.twoHandsRoute);
        break;
      case 3:
        GoRouter.of(context).go(AppRouter.usersRoute);
        break;
      case 4:
        GoRouter.of(context).go(AppRouter.homeKanbanRoute);
        break;
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
                Expanded(child: widget.child),
                BottomNavBar(
                  onCenterButtonTap: _toggleMenu,
                  currentIndex: widget.selectedIndex,
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

  Widget _buildOverlayMenu() {
    final menuItems = [
      {'label': 'أمن الدولة', 'svg': Assets.imagesSheild},
      {
        'label': 'المياه',
        'svg': Assets.imagesWaterDrop,
        'active': false,
        'onTap': () {
          _toggleMenu();
          GoRouter.of(context).push(AppRouter.waterStorageDetailsRoute);
        },
      },
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
                      final item = menuItems[index];
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
                                  label: item['label'] as String,
                                  svgPath: item['svg'] as String,
                                  isActive: item['active'] as bool? ?? false,
                                  onTap: item['onTap'] as VoidCallback?,
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
