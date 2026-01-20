import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/common/tikipal_footer.dart';
import '../../widgets/common/glass_container.dart';


/// Dashboard Screen - Liquid Glass Style
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, dynamic>> _upcomingEvents = [
    {'name': 'Noche de Reggaeton', 'date': 'Hoy, 10pm', 'sold': 156, 'capacity': 200},
    {'name': 'Ladies Night', 'date': 'Mañana, 9pm', 'sold': 234, 'capacity': 300},
    {'name': 'Crossover Party', 'date': '24 Ene', 'sold': 78, 'capacity': 150},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(),
          const SizedBox(height: 24),
          
          // Metrics
          _buildMetrics(),
          const SizedBox(height: 24),
          
          // Quick Actions
          _buildQuickActions(),
          const SizedBox(height: 24),
          
          // Upcoming Events
          _buildUpcomingEvents(),
          const SizedBox(height: 40),
          
          const TikipalFooter(),
        ],
      ),
    );
  }


  Widget _buildHeader() {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      color: Colors.white.withValues(alpha: 0.6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Hola! 👋',
                  style: TextStyle(
                    fontSize: AppTypography.h2,
                    fontWeight: FontWeight.w600,
                    color: AppColors.foreground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Resumen de tu negocio',
                  style: TextStyle(
                    fontSize: AppTypography.small,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppRadius.full),
              boxShadow: AppShadows.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.calendar, size: 14, color: AppColors.brand),
                const SizedBox(width: 6),
                Text(
                  'Ene 2026',
                  style: TextStyle(
                    fontSize: AppTypography.caption,
                    fontWeight: FontWeight.w600,
                    color: AppColors.foreground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetrics() {
    return Row(
      children: [
        Expanded(child: _buildMetricGlassCard('Ventas', '\$4.2M', '+12%', LucideIcons.dollarSign, AppColors.metricOrange, AppColors.metricOrangeBg)),
        const SizedBox(width: 12),
        Expanded(child: _buildMetricGlassCard('Tickets', '1,234', '+8%', LucideIcons.ticket, AppColors.metricGreen, AppColors.metricGreenBg)),
        const SizedBox(width: 12),
        Expanded(child: _buildMetricGlassCard('Check-ins', '89', 'Hoy', LucideIcons.userCheck, AppColors.metricPurple, AppColors.metricPurpleBg)),
      ],
    );
  }

  Widget _buildMetricGlassCard(String title, String value, String badge, IconData icon, Color color, Color bgColor) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      color: Colors.white.withValues(alpha: 0.7),
      borderColor: Colors.white.withValues(alpha: 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: bgColor.withValues(alpha: 0.8), // Slightly transparent bg
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(icon, size: 18, color: color),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.successLight.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontSize: AppTypography.micro,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 24, // Slightly larger for impact
              fontWeight: FontWeight.w700,
              color: AppColors.foreground,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: AppTypography.caption,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': LucideIcons.plus, 'label': 'Crear', 'route': '/events/create', 'color': AppColors.brand},
      {'icon': LucideIcons.scanLine, 'label': 'Check-in', 'route': '/checkin', 'color': AppColors.metricGreen},
      {'icon': LucideIcons.barChart3, 'label': 'Analytics', 'route': '/analytics', 'color': AppColors.metricPurple},
      {'icon': LucideIcons.users, 'label': 'Invitados', 'route': '/guests', 'color': AppColors.metricBlue},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Acciones rápidas',
            style: TextStyle(
              fontSize: AppTypography.h3,
              fontWeight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute evenly
          children: actions.asMap().entries.map((entry) {
            final action = entry.value;
            final color = action['color'] as Color;
            // Add spacing except for last item
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: entry.key != actions.length - 1 ? 10 : 0),
                child: GlassContainer(
                  color: Colors.white.withValues(alpha: 0.65),
                  onTap: () => context.push(action['route'] as String),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          shape: BoxShape.circle, // Rounded icon bg
                        ),
                        child: Icon(action['icon'] as IconData, size: 20, color: color),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        action['label'] as String,
                        style: TextStyle(
                          fontSize: AppTypography.caption,
                          fontWeight: FontWeight.w600,
                          color: AppColors.foreground,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildUpcomingEvents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Próximos eventos',
                style: TextStyle(
                  fontSize: AppTypography.h3,
                  fontWeight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
              GestureDetector(
                onTap: () => context.push('/events'),
                child: Text(
                  'Ver todos',
                  style: TextStyle(
                    fontSize: AppTypography.caption,
                    fontWeight: FontWeight.w600,
                    color: AppColors.brand,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...(_upcomingEvents.map((event) => _buildEventGlassRow(event))),
      ],
    );
  }

  Widget _buildEventGlassRow(Map<String, dynamic> event) {
    final progress = event['sold'] / event['capacity'];
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassContainer(
        padding: const EdgeInsets.all(14),
        color: Colors.white.withValues(alpha: 0.75),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                borderRadius: BorderRadius.circular(AppRadius.md),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.brand.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(LucideIcons.partyPopper, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['name'],
                    style: TextStyle(
                      fontSize: AppTypography.body,
                      fontWeight: FontWeight.w600,
                      color: AppColors.foreground,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(LucideIcons.clock, size: 12, color: AppColors.textMuted),
                      const SizedBox(width: 4),
                      Text(
                        event['date'],
                        style: TextStyle(
                          fontSize: AppTypography.caption,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: AppColors.divider,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              progress > 0.8 ? AppColors.success : AppColors.brand,
                            ),
                            minHeight: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${event['sold']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.foreground,
                          fontFamily: 'Inter' // Ensure consistent font
                        )
                      ),
                      TextSpan(
                        text: '/${event['capacity']}',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                          fontFamily: 'Inter'
                        )
                      ),
                    ],
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
