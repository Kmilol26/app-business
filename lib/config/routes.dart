import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/events/events_list_screen.dart';
import '../screens/events/event_detail_screen.dart';
import '../screens/events/create_event_screen.dart';
import '../screens/events/checkin_screen.dart';
import '../screens/spaces/spaces_list_screen.dart';
import '../screens/guests/guests_list_screen.dart';
import '../screens/sales/sales_screen.dart';
import '../screens/payments/payments_screen.dart';
import '../screens/business/business_screen.dart';
import '../screens/analytics/analytics_screen.dart';
import '../screens/main_shell.dart';

/// App Routes Configuration
final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    // Auth routes
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    
    // Main app with header + tabs navigation
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        // Dashboard (default)
        GoRoute(
          path: '/',
          name: 'dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        // Negocio
        GoRoute(
          path: '/negocio',
          name: 'negocio',
          builder: (context, state) => const BusinessScreen(),
        ),
        // Espacios
        GoRoute(
          path: '/spaces',
          name: 'spaces',
          builder: (context, state) => const SpacesListScreen(),
        ),
        // Eventos
        GoRoute(
          path: '/events',
          name: 'events',
          builder: (context, state) => const EventsListScreen(),
          routes: [
            GoRoute(
              path: 'create',
              name: 'create-event',
              builder: (context, state) => const CreateEventScreen(),
            ),
            GoRoute(
              path: ':id',
              name: 'event-detail',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return EventDetailScreen(eventId: id);
              },
            ),
          ],
        ),
        // Ventas
        GoRoute(
          path: '/sales',
          name: 'sales',
          builder: (context, state) => const SalesScreen(),
        ),
        // Listas (Guests)
        GoRoute(
          path: '/guests',
          name: 'guests',
          builder: (context, state) => const GuestsListScreen(),
        ),
        // Pagos
        GoRoute(
          path: '/payments',
          name: 'payments',
          builder: (context, state) => const PaymentsScreen(),
        ),
        // Analytics
        GoRoute(
          path: '/analytics',
          name: 'analytics',
          builder: (context, state) => const AnalyticsScreen(),
        ),
        // Check-in
        GoRoute(
          path: '/checkin',
          name: 'checkin',
          builder: (context, state) => const CheckinScreen(),
        ),
      ],
    ),
  ],
);
