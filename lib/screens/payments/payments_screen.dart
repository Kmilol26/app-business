import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../config/theme.dart';
import '../../widgets/common/tikipal_footer.dart';
import '../../widgets/common/glass_container.dart';

/// Payments Screen - Liquid Glass Style
class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

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
            child: Text('Pagos y Facturación', style: TextStyle(fontSize: AppTypography.h2, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 20),

          // Current Plan
          GlassContainer(
            padding: const EdgeInsets.all(16),
            color: Colors.white.withValues(alpha: 0.65),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tu Plan Actual', style: TextStyle(fontSize: AppTypography.h3, fontWeight: FontWeight.w600)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: AppColors.brandGradient,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                      child: Text('PRO', style: TextStyle(fontSize: AppTypography.caption, fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text('\$29.99', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.brand)),
                    Text('/mes', style: TextStyle(fontSize: AppTypography.body, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Próximo cobro: 05 Feb, 2026', style: TextStyle(fontSize: AppTypography.caption, color: AppColors.textMuted)),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.brand),
                      foregroundColor: AppColors.brand,
                    ),
                    child: const Text('Administrar Plan'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Payment Methods
          GlassContainer(
            padding: const EdgeInsets.all(16),
            color: Colors.white.withValues(alpha: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Método de Pago', style: TextStyle(fontSize: AppTypography.h3, fontWeight: FontWeight.w600)),
                    TextButton(onPressed: () {}, child: const Text('Editar')),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                  ),
                  child: Row(
                    children: [
                      Icon(LucideIcons.creditCard, size: 20, color: AppColors.textSecondary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text('•••• •••• •••• 4242', style: TextStyle(fontSize: AppTypography.body, fontWeight: FontWeight.w500)),
                      ),
                      Text('Visa', style: TextStyle(fontSize: AppTypography.caption, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Invoices
          GlassContainer(
            padding: const EdgeInsets.all(16),
            color: Colors.white.withValues(alpha: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Historial de Facturas', style: TextStyle(fontSize: AppTypography.h3, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                _buildInvoiceItem('Ene 05, 2026', '\$29.99', 'Pagado'),
                _buildInvoiceItem('Dic 05, 2025', '\$29.99', 'Pagado'),
                _buildInvoiceItem('Nov 05, 2025', '\$29.99', 'Pagado'),
              ],
            ),
          ),

          const SizedBox(height: 40),
          const TikipalFooter(),
        ],
      ),
    );
  }

  Widget _buildInvoiceItem(String date, String amount, String status) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(LucideIcons.fileText, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 12),
              Text(date, style: TextStyle(fontSize: AppTypography.body, color: AppColors.foreground)),
            ],
          ),
          Row(
            children: [
              Text(amount, style: TextStyle(fontSize: AppTypography.body, fontWeight: FontWeight.w600)),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.successLight.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
                child: Text(status, style: TextStyle(fontSize: AppTypography.micro, fontWeight: FontWeight.w600, color: AppColors.success)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
