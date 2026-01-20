import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../config/theme.dart';
import '../../widgets/common/tikipal_footer.dart';
import '../../widgets/common/glass_container.dart';

/// Events List Screen - Liquid Glass Style
class EventsListScreen extends StatefulWidget {
  const EventsListScreen({super.key});

  @override
  State<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  final List<Map<String, dynamic>> _events = [
    {'id': '1', 'name': 'Noche de Reggaeton', 'date': '05 Ene', 'location': 'Monaco Rooftop', 'status': 'active'},
    {'id': '2', 'name': 'Ladies Night', 'date': '12 Ene', 'location': 'Tabu Studio', 'status': 'active'},
    {'id': '3', 'name': 'Crossover Party', 'date': '19 Ene', 'location': 'Zona 85', 'status': 'draft'},
    {'id': '4', 'name': 'Fiesta VIP', 'date': '26 Ene', 'location': 'Monaco Rooftop', 'status': 'active'},
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
                    Text('Eventos', style: TextStyle(fontSize: AppTypography.h2, fontWeight: FontWeight.w600, color: AppColors.foreground)),
                    Text('${_events.length} eventos', style: TextStyle(fontSize: AppTypography.caption, color: AppColors.textSecondary)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.plus, size: 16),
                  label: const Text('Nuevo'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    backgroundColor: AppColors.brand,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Search
          GlassContainer(
            padding: EdgeInsets.zero,
            color: Colors.white.withValues(alpha: 0.5),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar evento...',
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
          
          // Events Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.82,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _events.length,
            itemBuilder: (context, index) => _buildEventGlassCard(_events[index]),
          ),
          
          const SizedBox(height: 40),
          const TikipalFooter(),
        ],
      ),
    );
  }

  Widget _buildEventGlassCard(Map<String, dynamic> event) {
    final isActive = event['status'] == 'active';
    return GlassContainer(
      padding: EdgeInsets.zero, // Padding handled inside
      color: Colors.white.withValues(alpha: 0.65),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.divider.withValues(alpha: 0.3),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)), // Match parent radius
              ),
              child: Center(child: Icon(LucideIcons.calendar, color: AppColors.textMuted.withValues(alpha: 0.5), size: 32)),
            ),
          ),
          // Info
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['name'],
                    style: TextStyle(fontSize: AppTypography.body, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(LucideIcons.mapPin, size: 11, color: AppColors.textMuted),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          event['location'],
                          style: TextStyle(fontSize: AppTypography.micro, color: AppColors.textMuted),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(event['date'], style: TextStyle(fontSize: AppTypography.caption, fontWeight: FontWeight.w600)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isActive ? AppColors.successLight.withValues(alpha: 0.8) : AppColors.warningLight.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(AppRadius.xs),
                        ),
                        child: Text(
                          isActive ? 'Activo' : 'Borrador',
                          style: TextStyle(fontSize: AppTypography.micro, fontWeight: FontWeight.w600, color: isActive ? AppColors.success : AppColors.warning),
                        ),
                      ),
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
