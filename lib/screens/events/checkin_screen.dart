import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../config/theme.dart';

/// Check-in Screen - QR Scanner + Manual Search (Luma style)
class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  bool _isScanning = true;
  String? _lastResult;
  String? _resultStatus; // 'success', 'already', 'notfound'
  
  // Mock guests
  final List<Map<String, dynamic>> _guests = [
    {'id': 'TK001', 'name': 'María García', 'email': 'maria@gmail.com', 'ticket': 'VIP', 'checkedIn': false},
    {'id': 'TK002', 'name': 'Carlos Rodríguez', 'email': 'carlos@gmail.com', 'ticket': 'General', 'checkedIn': true},
    {'id': 'TK003', 'name': 'Ana Martínez', 'email': 'ana@gmail.com', 'ticket': 'VIP', 'checkedIn': false},
    {'id': 'TK004', 'name': 'Pedro López', 'email': 'pedro@gmail.com', 'ticket': 'General', 'checkedIn': false},
  ];
  
  int get _totalGuests => _guests.length;
  int get _checkedInCount => _guests.where((g) => g['checkedIn'] == true).length;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _simulateQRScan() {
    // Simulate finding a guest
    final guest = _guests.firstWhere(
      (g) => g['checkedIn'] == false,
      orElse: () => <String, dynamic>{},
    );
    
    if (guest.isEmpty) {
      _showResult('notfound', null);
    } else {
      setState(() {
        guest['checkedIn'] = true;
      });
      _showResult('success', guest);
    }
  }

  void _showResult(String status, Map<String, dynamic>? guest) {
    setState(() {
      _resultStatus = status;
      _lastResult = guest?['name'];
    });
    
    // Auto-hide after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _resultStatus = null;
          _lastResult = null;
        });
      }
    });
  }

  void _checkInManually(Map<String, dynamic> guest) {
    if (guest['checkedIn'] == true) {
      _showResult('already', guest);
    } else {
      setState(() {
        guest['checkedIn'] = true;
      });
      _showResult('success', guest);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Check-in'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Counter badge
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$_checkedInCount / $_totalGuests',
                  style: TextStyle(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Toggle
          _buildTabToggle(),
          
          // Content
          Expanded(
            child: _isScanning ? _buildScannerView() : _buildSearchView(),
          ),
          
          // Result Overlay
          if (_resultStatus != null) _buildResultOverlay(),
        ],
      ),
    );
  }

  Widget _buildTabToggle() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isScanning = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _isScanning ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  boxShadow: _isScanning ? AppShadows.sm : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.scanLine,
                      size: 18,
                      color: _isScanning ? AppColors.brand : AppColors.textMuted,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Escanear QR',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _isScanning ? AppColors.foreground : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isScanning = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !_isScanning ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  boxShadow: !_isScanning ? AppShadows.sm : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.search,
                      size: 18,
                      color: !_isScanning ? AppColors.brand : AppColors.textMuted,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Buscar',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: !_isScanning ? AppColors.foreground : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerView() {
    return GestureDetector(
      onTap: _simulateQRScan,
      child: Container(
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Scanner area
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _pulseAnimation,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.brand, width: 3),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: const Icon(
                      LucideIcons.scanLine,
                      size: 64,
                      color: Colors.white54,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Apunta al código QR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Toca para simular escaneo',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            
            // Corner markers
            Positioned(
              top: 60,
              left: 60,
              child: _buildCorner(true, true),
            ),
            Positioned(
              top: 60,
              right: 60,
              child: _buildCorner(true, false),
            ),
            Positioned(
              bottom: 60,
              left: 60,
              child: _buildCorner(false, true),
            ),
            Positioned(
              bottom: 60,
              right: 60,
              child: _buildCorner(false, false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorner(bool isTop, bool isLeft) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? BorderSide(color: AppColors.brand, width: 3) : BorderSide.none,
          bottom: !isTop ? BorderSide(color: AppColors.brand, width: 3) : BorderSide.none,
          left: isLeft ? BorderSide(color: AppColors.brand, width: 3) : BorderSide.none,
          right: !isLeft ? BorderSide(color: AppColors.brand, width: 3) : BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSearchView() {
    final filteredGuests = _guests.where((g) {
      final query = _searchController.text.toLowerCase();
      return g['name'].toLowerCase().contains(query) ||
             g['email'].toLowerCase().contains(query);
    }).toList();

    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Buscar por nombre o email...',
              prefixIcon: const Icon(LucideIcons.search, size: 20),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(LucideIcons.x, size: 18),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Guest List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filteredGuests.length,
            itemBuilder: (context, index) {
              final guest = filteredGuests[index];
              final isCheckedIn = guest['checkedIn'] == true;
              
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: isCheckedIn ? AppColors.success : AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isCheckedIn ? AppColors.successLight : AppColors.divider,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isCheckedIn ? LucideIcons.userCheck : LucideIcons.user,
                        color: isCheckedIn ? AppColors.success : AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            guest['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            guest['email'],
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Ticket Type Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: guest['ticket'] == 'VIP' 
                            ? AppColors.warningLight 
                            : AppColors.divider,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        guest['ticket'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: guest['ticket'] == 'VIP' 
                              ? AppColors.warning 
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Action Button
                    GestureDetector(
                      onTap: () => _checkInManually(guest),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isCheckedIn ? AppColors.successLight : AppColors.brand,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          isCheckedIn ? LucideIcons.check : LucideIcons.arrowRight,
                          color: isCheckedIn ? AppColors.success : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResultOverlay() {
    Color bgColor;
    IconData icon;
    String title;
    String subtitle;
    
    switch (_resultStatus) {
      case 'success':
        bgColor = AppColors.success;
        icon = LucideIcons.checkCircle;
        title = '¡Check-in exitoso!';
        subtitle = _lastResult ?? '';
        break;
      case 'already':
        bgColor = AppColors.warning;
        icon = LucideIcons.alertCircle;
        title = 'Ya registrado';
        subtitle = 'Este ticket ya fue usado';
        break;
      default:
        bgColor = AppColors.error;
        icon = LucideIcons.xCircle;
        title = 'No encontrado';
        subtitle = 'Ticket no válido';
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
