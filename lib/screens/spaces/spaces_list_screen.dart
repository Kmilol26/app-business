import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../config/theme.dart';
import '../../widgets/common/tikipal_footer.dart';
import '../../widgets/common/glass_container.dart';

/// Spaces List Screen - Liquid Glass Style
class SpacesListScreen extends StatefulWidget {
  const SpacesListScreen({super.key});

  @override
  State<SpacesListScreen> createState() => _SpacesListScreenState();
}

class _SpacesListScreenState extends State<SpacesListScreen> {
  final List<Map<String, dynamic>> _spaces = [
    {'name': 'Monaco Rooftop', 'location': 'Bogotá', 'capacity': 200, 'events': 12},
    {'name': 'Tabu Studio Bar', 'location': 'Bogotá', 'capacity': 150, 'events': 8},
    {'name': 'Zona 85', 'location': 'Bogotá', 'capacity': 300, 'events': 15},
    {'name': 'Restaurante VIP', 'location': 'Medellín', 'capacity': 80, 'events': 4},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white.withValues(alpha: 0.6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Espacios', style: TextStyle(fontSize: AppTypography.h2, fontWeight: FontWeight.w600)),
                    Text('${_spaces.length} espacios', style: TextStyle(fontSize: AppTypography.caption, color: AppColors.textSecondary)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.plus, size: 16),
                  label: const Text('Nuevo'),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          GlassContainer(
            padding: EdgeInsets.zero,
            color: Colors.white.withValues(alpha: 0.5),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar espacio...',
                prefixIcon: Icon(LucideIcons.search, size: 18, color: AppColors.textMuted),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Spaces Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.88,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _spaces.length,
            itemBuilder: (context, index) => _buildSpaceGlassCard(_spaces[index]),
          ),
          
          const SizedBox(height: 40),
          const TikipalFooter(),
        ],
      ),
    );
  }

  Widget _buildSpaceGlassCard(Map<String, dynamic> space) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      color: Colors.white.withValues(alpha: 0.65),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.divider.withValues(alpha: 0.3),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Center(child: Icon(LucideIcons.mapPin, color: AppColors.textMuted.withValues(alpha: 0.5), size: 32)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(space['name'], style: TextStyle(fontSize: AppTypography.body, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(space['location'], style: TextStyle(fontSize: AppTypography.caption, color: AppColors.textMuted)),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(LucideIcons.users, size: 11, color: AppColors.textMuted),
                      const SizedBox(width: 3),
                      Text('${space['capacity']}', style: TextStyle(fontSize: AppTypography.caption, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Text('${space['events']} eventos', style: TextStyle(fontSize: AppTypography.micro, color: AppColors.brand)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
