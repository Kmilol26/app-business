import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../config/theme.dart';

class EventDetailScreen extends StatelessWidget {
  final String eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    // Mock data - TODO: Cargar desde API
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Detalle del Evento'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/events'),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.edit),
            onPressed: () {
              // TODO: Editar evento
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.share2),
            onPressed: () {
              // TODO: Compartir evento
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event header
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: const Center(
                child: Icon(
                  LucideIcons.image,
                  size: 64,
                  color: AppColors.mutedForeground,
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Title and status
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Noche de Reggaeton',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Publicado',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Info cards
            Row(
              children: [
                _buildInfoCard(LucideIcons.calendar, '25 Ene 2026', 'Fecha'),
                const SizedBox(width: 12),
                _buildInfoCard(LucideIcons.clock, '10:00 PM', 'Hora'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildInfoCard(LucideIcons.mapPin, 'Salón Principal', 'Espacio'),
                const SizedBox(width: 12),
                _buildInfoCard(LucideIcons.users, '89/150', 'Capacidad'),
              ],
            ),
            const SizedBox(height: 24),
            
            // Stats
            const Text(
              'Estadísticas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _buildStatRow('Ventas totales', '\$2,450,000'),
                  const Divider(height: 24),
                  _buildStatRow('Tickets vendidos', '89'),
                  const Divider(height: 24),
                  _buildStatRow('Invitados confirmados', '65'),
                  const Divider(height: 24),
                  _buildStatRow('Check-ins', '0'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Ver invitados
                    },
                    icon: const Icon(LucideIcons.users),
                    label: const Text('Ver Invitados'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Escanear QR
                    },
                    icon: const Icon(LucideIcons.scan),
                    label: const Text('Escanear QR'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(icon, size: 20, color: AppColors.foreground),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.mutedForeground,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.mutedForeground,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
