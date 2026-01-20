import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../config/theme.dart';

/// Analytics Screen - Performance insights (Airbnb + Luma inspired)
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _selectedPeriod = '30d';
  
  // Mock data
  final Map<String, dynamic> _metrics = {
    'totalSales': 4250000,
    'ticketsSold': 1234,
    'avgTicketPrice': 35000,
    'checkInRate': 0.87,
    'noShowRate': 0.13,
    'peakHour': '10:00 PM',
    'topEvent': 'Noche de Reggaeton',
    'conversionRate': 0.65,
  };
  
  final List<Map<String, dynamic>> _salesBySource = [
    {'source': 'Directo', 'value': 45, 'color': AppColors.metricOrange},
    {'source': 'Instagram', 'value': 28, 'color': AppColors.metricPurple},
    {'source': 'Referidos', 'value': 15, 'color': AppColors.metricGreen},
    {'source': 'WhatsApp', 'value': 12, 'color': AppColors.metricBlue},
  ];
  
  final List<Map<String, dynamic>> _topEvents = [
    {'name': 'Noche de Reggaeton', 'tickets': 456, 'revenue': 15960000},
    {'name': 'Ladies Night', 'tickets': 324, 'revenue': 9720000},
    {'name': 'Crossover Party', 'tickets': 234, 'revenue': 8190000},
    {'name': 'Fiesta VIP', 'tickets': 120, 'revenue': 7200000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Export Button
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(LucideIcons.download, size: 18),
              label: const Text('Exportar'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Period Selector
                _buildPeriodSelector(),
                const SizedBox(height: 32),
                
                // Key Metrics
                _buildKeyMetrics(),
                const SizedBox(height: 32),
                
                // Sales & Attendance Row
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isSmall = constraints.maxWidth < 700;
                    if (isSmall) {
                      return Column(
                        children: [
                          _buildSalesBySourceCard(),
                          const SizedBox(height: 24),
                          _buildAttendanceCard(),
                        ],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildSalesBySourceCard()),
                        const SizedBox(width: 24),
                        Expanded(child: _buildAttendanceCard()),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),
                
                // Top Events
                _buildTopEventsCard(),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    final periods = [
      {'id': '7d', 'label': '7 días'},
      {'id': '30d', 'label': '30 días'},
      {'id': '90d', 'label': '90 días'},
      {'id': 'year', 'label': 'Este año'},
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: periods.map((period) {
          final isSelected = _selectedPeriod == period['id'];
          return GestureDetector(
            onTap: () => setState(() => _selectedPeriod = period['id']!),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                boxShadow: isSelected ? AppShadows.sm : null,
              ),
              child: Text(
                period['label']!,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppColors.foreground : AppColors.textMuted,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildKeyMetrics() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 600;
        final cardWidth = isSmall ? (constraints.maxWidth - 12) / 2 : (constraints.maxWidth - 36) / 4;
        
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildMetricCard(
              title: 'Ventas Totales',
              value: '\$${(_metrics['totalSales'] / 1000000).toStringAsFixed(1)}M',
              icon: LucideIcons.dollarSign,
              color: AppColors.metricOrange,
              width: cardWidth,
            ),
            _buildMetricCard(
              title: 'Tickets Vendidos',
              value: '${_metrics['ticketsSold']}',
              icon: LucideIcons.ticket,
              color: AppColors.metricGreen,
              width: cardWidth,
            ),
            _buildMetricCard(
              title: 'Tasa Check-in',
              value: '${(_metrics['checkInRate'] * 100).toInt()}%',
              icon: LucideIcons.userCheck,
              color: AppColors.metricPurple,
              width: cardWidth,
            ),
            _buildMetricCard(
              title: 'Hora Pico',
              value: _metrics['peakHour'],
              icon: LucideIcons.clock,
              color: AppColors.metricBlue,
              width: cardWidth,
            ),
          ],
        );
      },
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required double width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.sm,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesBySourceCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.sm,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ventas por Fuente',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 24),
          
          // Progress bars
          ..._salesBySource.map((source) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: source['color'],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            source['source'],
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Text(
                        '${source['value']}%',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: source['color'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: source['value'] / 100,
                      backgroundColor: AppColors.divider,
                      valueColor: AlwaysStoppedAnimation<Color>(source['color']),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard() {
    final checkInRate = _metrics['checkInRate'] as double;
    final noShowRate = _metrics['noShowRate'] as double;
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.sm,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Asistencia',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 24),
          
          // Donut chart simulation with stacked circles
          Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: checkInRate,
                      strokeWidth: 20,
                      backgroundColor: AppColors.errorLight,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${(checkInRate * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.foreground,
                        ),
                      ),
                      Text(
                        'Check-in',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Asistieron', AppColors.success, '${(checkInRate * 100).toInt()}%'),
              const SizedBox(width: 24),
              _buildLegendItem('No-shows', AppColors.error, '${(noShowRate * 100).toInt()}%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$label: $value',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildTopEventsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.sm,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Eventos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Por ingresos',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.divider)),
            ),
            child: Row(
              children: [
                const Expanded(flex: 3, child: Text('#', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                const Expanded(flex: 5, child: Text('Evento', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                const Expanded(flex: 2, child: Text('Tickets', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                const Expanded(flex: 3, child: Text('Ingresos', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
              ],
            ),
          ),
          
          // Rows
          ...(_topEvents.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.divider.withValues(alpha: 0.5))),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: index < 3 ? AppColors.brand : AppColors.divider,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: index < 3 ? Colors.white : AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      event['name'],
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${event['tickets']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      '\$${(event['revenue'] / 1000000).toStringAsFixed(1)}M',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
            );
          })),
        ],
      ),
    );
  }
}
