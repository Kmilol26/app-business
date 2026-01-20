import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../config/theme.dart';
import '../../widgets/common/tikipal_footer.dart';
import '../../widgets/common/glass_container.dart';

/// Sales Screen - Liquid Glass Style
class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  String _selectedSpace = 'Monaco Rooftop';
  String _selectedDate = '05/Junio/2025';
  
  final List<String> _spaces = ['Monaco Rooftop', 'Tabu Studio', 'Zona 85'];
  final List<String> _dates = ['05/Junio/2025', '12/Junio/2025', '19/Junio/2025'];
  
  // Mock data
  final int _ticketsSold = 50;
  final int _ticketLimit = 500;
  
  final List<Map<String, dynamic>> _ticketSummary = [
    {'label': 'Intentos de compra', 'value': 80, 'color': const Color(0xFFFFB299), 'icon': LucideIcons.shoppingCart},
    {'label': 'Tickets', 'value': 50, 'color': const Color(0xFF4CAF50), 'icon': LucideIcons.ticket},
    {'label': 'Entradas', 'value': 60, 'color': const Color(0xFFFF7043), 'icon': LucideIcons.doorOpen},
    {'label': 'Ingresos', 'value': 10, 'color': const Color(0xFF9C27B0), 'icon': LucideIcons.dollarSign},
  ];
  
  final List<Map<String, dynamic>> _recentSales = [
    {'buyer': 'María García', 'amount': 35000, 'time': 'Hace 2h', 'tickets': 2},
    {'buyer': 'Carlos López', 'amount': 70000, 'time': 'Hace 3h', 'tickets': 4},
    {'buyer': 'Ana Martínez', 'amount': 52500, 'time': 'Ayer', 'tickets': 3},
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
            child: Text('Ventas', style: TextStyle(fontSize: AppTypography.h2, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 20),
          
          // Filters Wrapper Glass
          GlassContainer(
            padding: const EdgeInsets.all(16),
            color: Colors.white.withValues(alpha: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Espacios o eventos activos', 'Selecciona el espacio/evento'),
                const SizedBox(height: 10),
                _buildDropdown(_selectedSpace, _spaces, (val) => setState(() => _selectedSpace = val!)),
                const SizedBox(height: 20),
                _buildSectionTitle('Fechas activas', 'Selecciona la fecha de operación'),
                const SizedBox(height: 10),
                _buildDropdown(_selectedDate, _dates, (val) => setState(() => _selectedDate = val!)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Activity Glass
          GlassContainer(
            padding: const EdgeInsets.all(16),
            color: Colors.white.withValues(alpha: 0.6),
            child: _buildActivitySection(),
          ),
          const SizedBox(height: 24),
          
          // Ticket Summary Glass
          GlassContainer(
            padding: const EdgeInsets.all(16),
            color: Colors.white.withValues(alpha: 0.7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Resumen de tickets', style: TextStyle(fontSize: AppTypography.h3, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                ..._ticketSummary.map((item) => _buildTicketRow(item)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Recent Sales Glass
          GlassContainer(
            padding: const EdgeInsets.all(16),
            color: Colors.white.withValues(alpha: 0.6),
            child: _buildRecentSales(),
          ),
          
          const SizedBox(height: 40),
          const TikipalFooter(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: AppTypography.h3, fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(subtitle, style: TextStyle(fontSize: AppTypography.caption, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildDropdown(String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.brand.withValues(alpha: 0.5), width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(LucideIcons.chevronDown, color: AppColors.foreground, size: 18),
          style: TextStyle(fontSize: AppTypography.body, color: AppColors.foreground, fontWeight: FontWeight.w500),
          items: items.map((item) => DropdownMenuItem(value: item, child: Row(
            children: [
              Icon(LucideIcons.square, size: 14, color: AppColors.textMuted),
              const SizedBox(width: 10),
              Text(item),
            ],
          ))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildActivitySection() {
    final progress = _ticketsSold / _ticketLimit;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Actividad', style: TextStyle(fontSize: AppTypography.h3, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: '$_ticketsSold ', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.brand)),
                  TextSpan(text: 'tickets', style: TextStyle(fontSize: AppTypography.body, color: AppColors.brand)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'límite ', style: TextStyle(fontSize: AppTypography.caption, color: AppColors.textMuted)),
                  TextSpan(text: '$_ticketLimit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.success)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.divider,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildTicketRow(Map<String, dynamic> item) {
    final maxValue = _ticketSummary.map((e) => e['value'] as int).reduce((a, b) => a > b ? a : b);
    final progress = (item['value'] as int) / maxValue;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: item['color'],
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(item['icon'], size: 14, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      item['label'],
                      style: TextStyle(fontSize: AppTypography.small, fontWeight: FontWeight.w600, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final barWidth = constraints.maxWidth * progress;
                return Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: barWidth,
                        height: 36,
                        decoration: BoxDecoration(
                          color: (item['color'] as Color).withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${item['value']}',
                          style: TextStyle(fontSize: AppTypography.body, fontWeight: FontWeight.w700, color: item['color']),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSales() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ventas recientes', style: TextStyle(fontSize: AppTypography.h3, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        ..._recentSales.map((sale) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.metricGreenBg,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(LucideIcons.shoppingBag, size: 16, color: AppColors.metricGreen),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sale['buyer'], style: TextStyle(fontSize: AppTypography.body, fontWeight: FontWeight.w600)),
                    Text('${sale['tickets']} tickets · ${sale['time']}', style: TextStyle(fontSize: AppTypography.caption, color: AppColors.textMuted)),
                  ],
                ),
              ),
              Text('\$${(sale['amount'] / 1000).toStringAsFixed(0)}K', style: TextStyle(fontSize: AppTypography.body, fontWeight: FontWeight.w700, color: AppColors.success)),
            ],
          ),
        )),
      ],
    );
  }
}
