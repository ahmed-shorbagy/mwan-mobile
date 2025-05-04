import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mwan_mobile/core/utils/assets.dart';
import 'package:mwan_mobile/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:mwan_mobile/features/home/presentation/widgets/menu_option.dart';
import 'package:mwan_mobile/features/home/presentation/widgets/side_menu.dart';
import 'package:mwan_mobile/features/home/presentation/widgets/user_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _isMenuOpen = false;
  bool _showSideMenu = false;
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

  void _openSideMenu() {
    setState(() {
      _isMenuOpen = false;
      _menuAnimationController.reverse();
      _showSideMenu = true;
    });
  }

  void _closeSideMenu() {
    setState(() {
      _showSideMenu = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            _buildMainContent(),
            if (_isMenuOpen) _buildOverlayMenu(),
            if (_showSideMenu) SideMenu(onClose: _closeSideMenu),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return SafeArea(
      child: Column(
        children: [
          const UserHeader(),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [],
              ),
            ),
          ),
          BottomNavBar(onCenterButtonTap: _toggleMenu),
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
        'onTap': _openSideMenu,
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
                                child: GestureDetector(
                                  onTap: () {
                                    if (menuItems[index]['onTap'] != null) {
                                      (menuItems[index]['onTap'] as Function)();
                                    }
                                  },
                                  child: MenuOption(
                                    label: menuItems[index]['label'] as String,
                                    svgPath: menuItems[index]['svg'] as String,
                                    isActive:
                                        menuItems[index]['active'] as bool? ??
                                        false,
                                  ),
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
