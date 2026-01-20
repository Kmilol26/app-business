import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../config/theme.dart';

/// Tikipal Footer - Clean, minimal
class TikipalFooter extends StatelessWidget {
  const TikipalFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.divider.withValues(alpha: 0.5),
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          // Social Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(LucideIcons.instagram),
              const SizedBox(width: 16),
              _buildSocialIcon(LucideIcons.facebook),
              const SizedBox(width: 16),
              _buildSocialIcon(LucideIcons.linkedin),
              const SizedBox(width: 16),
              _buildSocialIcon(LucideIcons.mail),
            ],
          ),
          const SizedBox(height: 16),
          
          // Copyright
          Text(
            '© 2026 Tikipal · Privacidad · Términos',
            style: TextStyle(
              fontSize: AppTypography.micro,
              color: AppColors.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.brand,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 14, color: Colors.white),
    );
  }
}
