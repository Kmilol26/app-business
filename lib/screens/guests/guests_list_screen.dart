import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../config/theme.dart';
import '../../widgets/common/tikipal_footer.dart';
import '../../widgets/common/glass_container.dart';

/// Guests List Screen - Liquid Glass Style
class GuestsListScreen extends StatefulWidget {
  const GuestsListScreen({super.key});

  @override
  State<GuestsListScreen> createState() => _GuestsListScreenState();
}

class _GuestsListScreenState extends State<GuestsListScreen> {
  String _selectedSpace = 'Monaco Rooftop';
  String _selectedDate = '05/Junio/2025';
  
  final List<String> _spaces = ['Monaco Rooftop', 'Tabu Studio', 'Zona 85'];
  final List<String> _dates = ['05/Junio/2025', '12/Junio/2025', '19/Junio/2025'];
  
  // Mock data
  final int _registered = 50;
  final int _limit = 500;
  
  final List<Map<String, dynamic>> _waitlist = [
    {'name': 'Pedro Ruiz', 'email': 'pedro@gmail.com', 'date': 'Hace 2h'},
    {'name': 'Laura Torres', 'email': 'laura@gmail.com', 'date': 'Hace 5h'},
    {'name': 'Miguel Sánchez', 'email': 'miguel@gmail.com', 'date': 'Ayer'},
  ];
  
  final List<Map<String, dynamic>> _guests = [
    {'name': 'María García', 'email': 'maria@gmail.com', 'ticket': 'VIP', 'status': 'checked'},
    {'name': 'Carlos López', 'email': 'carlos@gmail.com', 'ticket': 'General', 'status': 'pending'},
    {'name': 'Ana Martínez', 'email': 'ana@gmail.com', 'ticket': 'VIP', 'status': 'checked'},
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
            child: Text('Listas', style: TextStyle(fontSize: AppTypography.h2, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 20),
          
          // Filters
          GlassContainer(
            padding: const EdgeInsets.all(16),
            color: Colors.white.withValues(alpha: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Espacios o eventos activos', 'Selecciona el espacio/evento a editar'),
                const SizedBox(height: 10),
                _buildDropdown(_selectedSpace, _spaces, (val) => setState(() => _selectedSpace = val!)),
                const SizedBox(height: 20),
                _buildSectionTitle('Fechas activas', 'Selecciona la fecha a editar'),
                const SizedBox(height: 10),
                _buildDropdown(_selectedDate, _dates, (val) => setState(() => _selectedDate = val!)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Activity
          GlassContainer(
            padding: const EdgeInsets.all(16),
            color: Colors.white.withValues(alpha: 0.6),
            child: _buildActivitySection(),
          ),
          const SizedBox(height: 24),
          
          // Waitlist
          GlassContainer(
            padding: const EdgeInsets.all(16),
            color: Colors.white.withValues(alpha: 0.6),
            child: _buildWaitlist(),
          ),
          const SizedBox(height: 24),
          
          // Confirmed Guests
          GlassContainer(
            padding: const EdgeInsets.all(16),
            color: Colors.white.withValues(alpha: 0.7),
            child: _buildConfirmedGuests(),
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
    final progress = _registered / _limit;
    
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
                  TextSpan(text: '$_registered ', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.brand)),
                  TextSpan(text: 'registrados', style: TextStyle(fontSize: AppTypography.body, color: AppColors.brand)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'límite ', style: TextStyle(fontSize: AppTypography.caption, color: AppColors.textMuted)),
                  TextSpan(text: '$_limit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.success)),
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

  Widget _buildWaitlist() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Lista de espera', style: TextStyle(fontSize: AppTypography.h3, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text('Aprueba los registros que quieras de los eventos gratis', style: TextStyle(fontSize: AppTypography.caption, color: AppColors.textSecondary)),
        const SizedBox(height: 12),
        
        ..._waitlist.map((person) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.warningLight),
            boxShadow: [BoxShadow(color: AppColors.warning.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.warningLight,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(LucideIcons.clock, size: 18, color: AppColors.warning),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(person['name'], style: TextStyle(fontSize: AppTypography.body, fontWeight: FontWeight.w600)),
                    Text(person['email'], style: TextStyle(fontSize: AppTypography.caption, color: AppColors.textMuted)),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Icon(LucideIcons.check, size: 16, color: AppColors.success),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.errorLight,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Icon(LucideIcons.x, size: 16, color: AppColors.error),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildConfirmedGuests() {
    final checked = _guests.where((g) => g['status'] == 'checked').length;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Confirmados', style: TextStyle(fontSize: AppTypography.h3, fontWeight: FontWeight.w600)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Text('$checked/${_guests.length} check-in', style: TextStyle(fontSize: AppTypography.caption, fontWeight: FontWeight.w600, color: AppColors.success)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        ..._guests.map((guest) {
          final isChecked = guest['status'] == 'checked';
          final isVip = guest['ticket'] == 'VIP';
          
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isChecked ? AppColors.successLight.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: isChecked ? AppColors.success.withValues(alpha: 0.3) : AppColors.border.withValues(alpha: 0.5)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isChecked ? AppColors.successLight : AppColors.divider,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(isChecked ? LucideIcons.userCheck : LucideIcons.user, size: 16, color: isChecked ? AppColors.success : AppColors.textMuted),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(guest['name'], style: TextStyle(fontSize: AppTypography.body, fontWeight: FontWeight.w600)),
                      Text(guest['email'], style: TextStyle(fontSize: AppTypography.caption, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isVip ? AppColors.warningLight : AppColors.divider,
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                  ),
                  child: Text(guest['ticket'], style: TextStyle(fontSize: AppTypography.micro, fontWeight: FontWeight.w600, color: isVip ? AppColors.warning : AppColors.textSecondary)),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
