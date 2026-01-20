import 'package:flutter/material.dart';
import '../../config/theme.dart';

/// Background with organic liquid shapes and gradients
class LiquidBackground extends StatelessWidget {
  final Widget child;

  const LiquidBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base background
        Container(color: AppColors.background),
        
        // Organic Shape 1 (Top Left - Brand Color)
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.brand.withValues(alpha: 0.15),
                  AppColors.brand.withValues(alpha: 0.0),
                ],
                radius: 0.6,
              ),
            ),
          ),
        ),
        
        // Organic Shape 2 (Center Right - Purple/Accent)
        Positioned(
          top: 200,
          right: -150,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color(0xFF8B5CF6).withValues(alpha: 0.1), // Purple
                  Color(0xFF8B5CF6).withValues(alpha: 0.0),
                ],
                radius: 0.6,
              ),
            ),
          ),
        ),
        
        // Organic Shape 3 (Bottom Left - Blue)
        Positioned(
          bottom: -100,
          left: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color(0xFF3B82F6).withValues(alpha: 0.1), // Blue
                  Color(0xFF3B82F6).withValues(alpha: 0.0),
                ],
                radius: 0.6,
              ),
            ),
          ),
        ),

        // Child content
        child,
      ],
    );
  }
}
