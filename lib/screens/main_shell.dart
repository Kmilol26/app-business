import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:ui';
import '../config/theme.dart';
import '../widgets/common/liquid_background.dart';

/// Main Shell - Liquid Glass Style (Transparent Scaffold)
class MainShell extends StatefulWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _navItems = [
    {'icon': LucideIcons.layoutDashboard, 'label': 'Dashboard', 'path': '/'},
    {'icon': LucideIcons.mapPin, 'label': 'Espacios', 'path': '/spaces'},
    {'icon': LucideIcons.calendar, 'label': 'Eventos', 'path': '/events'},
    {'icon': LucideIcons.shoppingBag, 'label': 'Ventas', 'path': '/sales'},
    {'icon': LucideIcons.users, 'label': 'Listas', 'path': '/guests'},
  ];

  int _getCurrentIndex(String location) {
    for (int i = 0; i < _navItems.length; i++) {
      if (location == _navItems[i]['path'] || 
          (location.startsWith('${_navItems[i]['path']}/') && _navItems[i]['path'] != '/')) {
        return i;
      }
    }
    return 0; // Default
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final currentIndex = _getCurrentIndex(location);

    return LiquidBackground( // Global animated background
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent, // Make scaffold transparent
        extendBody: true, // Allow body to extend behind bottom nav
        extendBodyBehindAppBar: true, // Allow body behind app bar
        
        appBar: AppBar(
          backgroundColor: Colors.white.withValues(alpha: 0.7), // Glassy app bar
          elevation: 0,
          toolbarHeight: 50,
          flexibleSpace: ClipRRect( // Frosted effect for app bar
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.transparent),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Center(
              child: Text(
                'tikipal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.brand,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          leadingWidth: 80,
          actions: [
            IconButton(
              onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
              icon: Icon(LucideIcons.menu, color: AppColors.foreground, size: 22),
            ),
            const SizedBox(width: 8),
          ],
        ),
        
        endDrawer: _buildDrawer(context),
        
        body: SafeArea(
          bottom: false, 
          child: widget.child,
        ),
        
        bottomNavigationBar: ClipRRect( // Glassy bottom nav
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.5))),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _navItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final isActive = index == currentIndex;
                      return _buildNavItem(
                        icon: item['icon'],
                        label: item['label'],
                        isActive: isActive,
                        onTap: () => context.go(item['path']),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.brand.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: isActive ? AppColors.brand : AppColors.textMuted),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? AppColors.brand : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      width: 280,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SafeArea(
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(gradient: AppColors.brandGradient),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                          child: const Icon(LucideIcons.building2, color: AppColors.brand, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Club Nocturno', style: TextStyle(color: Colors.white, fontSize: AppTypography.body, fontWeight: FontWeight.w600)),
                              Text('Plan Pro', style: TextStyle(color: Colors.white70, fontSize: AppTypography.caption)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildMenuItem(LucideIcons.building2, 'Mi Negocio', () { Navigator.pop(context); context.push('/negocio'); }),
                  _buildMenuItem(LucideIcons.creditCard, 'Pagos', () { Navigator.pop(context); context.push('/payments'); }),
                  _buildMenuItem(LucideIcons.barChart3, 'Analytics', () { Navigator.pop(context); context.push('/analytics'); }),
                  _buildMenuItem(LucideIcons.scanLine, 'Check-in QR', () { Navigator.pop(context); context.push('/checkin'); }),
                  const Divider(height: 24),
                  _buildMenuItem(LucideIcons.settings, 'Configuración', () => Navigator.pop(context)),
                  _buildMenuItem(LucideIcons.helpCircle, 'Ayuda', () => Navigator.pop(context)),
                  const Spacer(),
                  _buildMenuItem(LucideIcons.logOut, 'Cerrar Sesión', () { Navigator.pop(context); context.go('/login'); }, isDestructive: true),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? AppColors.error : AppColors.textSecondary, size: 20),
      title: Text(label, style: TextStyle(color: isDestructive ? AppColors.error : AppColors.foreground, fontSize: AppTypography.body, fontWeight: FontWeight.w500)),
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
