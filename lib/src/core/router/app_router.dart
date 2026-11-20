import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gelismis_asansor_projesi/src/presentation/settings/screens/settings_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/widgets/scaffold_with_navbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/presentation/auth/screens/splash_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/auth/screens/login_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/auth/screens/register_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/auth/screens/forgot_password_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/auth/screens/profile_setup_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/dashboard/screens/dashboard_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/auth/providers/auth_provider.dart';
import 'package:gelismis_asansor_projesi/src/presentation/daily_route/screens/create_daily_route_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/daily_route/screens/daily_route_detail_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/maintenance/screens/maintenance_form_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/faults/screens/fault_form_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/faults/screens/fault_resolution_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/assets/elevator_logbook_screen.dart';

import 'package:gelismis_asansor_projesi/src/presentation/customers/customer_list_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/customers/customer_detail_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/customers/add_customer_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/assets/elevator_detail_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/assets/add_elevator_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/customers/customer_ledger_screen.dart';
import 'package:gelismis_asansor_projesi/src/data/models/customer_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/elevator_model.dart';
import 'package:gelismis_asansor_projesi/src/presentation/maintenance/maintenance_group_list_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/maintenance/maintenance_group_detail_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/inventory/screens/van_stock_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/faults/screens/troubleshooting_guide_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/maintenance/screens/periodic_inspection_form_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const vanStock = '/van-stock';
  static const troubleshooting = '/troubleshooting';
  static const createDailyRoute = 'create_daily_route';
  static const dailyRouteDetail = 'daily_route_detail/:routeId';
  static const faultResolution = 'fault_resolution/:faultId';
  static const forgotPassword = '/forgot-password';
  static const register = '/register';
  static const profileSetup = '/profile-setup';
}




final rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final authStream = StreamController<void>.broadcast();
  
  // Listen to auth state changes and notify the stream
  final subscription = ref.listen(authProvider, (previous, next) {
    authStream.add(null);
  });

  ref.onDispose(() {
    authStream.close();
    subscription.close();
  });

  return GoRouter(
    initialLocation: AppRoutes.splash,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.profileSetup,
        name: AppRoutes.profileSetup,
        builder: (context, state) => const ProfileSetupScreen(),
      ),

      // Shell Route for Bottom Navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.dashboard,
                name: AppRoutes.dashboard,
                builder: (context, state) => const DashboardScreen(),
                routes: [
                  GoRoute(
                    path: AppRoutes.createDailyRoute,
                    name: AppRoutes.createDailyRoute,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const CreateDailyRouteScreen(),
                  ),
                  GoRoute(
                    path: AppRoutes.dailyRouteDetail,
                    name: 'daily_route_detail',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final routeId = int.parse(state.pathParameters['routeId']!);
                      return DailyRouteDetailScreen(routeId: routeId);
                    },
                  ),
                  GoRoute(
                    path: AppRoutes.faultResolution,
                    name: 'fault_resolution',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final faultId = int.parse(state.pathParameters['faultId']!);
                      return FaultResolutionScreen(faultId: faultId);
                    },
                  ),
                ],
              ),
            ],
          ),
          
          // Branch 2: Customers
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/customers',
                name: 'customers',
                builder: (context, state) => const CustomerListScreen(),
                routes: [
                  GoRoute(
                    path: 'add',
                    name: 'add_customer',
                    parentNavigatorKey: rootNavigatorKey, // Hide bottom nav
                    builder: (context, state) {
                      final customerToEdit = state.extra as CustomerModel?;
                      return AddCustomerScreen(customerToEdit: customerToEdit);
                    },
                  ),
                  GoRoute(
                    path: 'detail/:customerId',
                    name: 'customer_detail',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                       final customerId = state.pathParameters['customerId']!;
                       return CustomerDetailScreen(customerId: customerId);
                    },
                    routes: [
                       GoRoute(
                        path: 'ledger',
                        name: 'customer_ledger',
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (context, state) {
                           final customerId = state.pathParameters['customerId']!;
                           return CustomerLedgerScreen(customerId: customerId);
                        },
                       ),
                       GoRoute(
                        path: 'elevator/add',
                        name: 'add_elevator',
                        parentNavigatorKey: rootNavigatorKey, // Hide bottom nav
                        builder: (context, state) {
                           // ID path'den de gelebilir, query'den de (eski usul)
                           final customerId = state.pathParameters['customerId'] ?? state.uri.queryParameters['customerId'];
                           final elevatorToEdit = state.extra as ElevatorModel?;
                           return AddElevatorScreen(customerId: customerId, elevatorToEdit: elevatorToEdit);
                        },
                      ),
                        GoRoute(
                          path: ':elevatorId/detail',
                          name: 'elevator_detail',
                          parentNavigatorKey: rootNavigatorKey,
                          builder: (context, state) {
                             final elevatorId = state.pathParameters['elevatorId']!;
                             final customerId = state.pathParameters['customerId'];
                             return ElevatorDetailScreen(elevatorId: elevatorId, customerId: customerId);
                          },
                          routes: [
                             GoRoute(
                               path: 'maintenance-form',
                               name: 'maintenance_form',
                               parentNavigatorKey: rootNavigatorKey,
                               builder: (context, state) {
                                 final elevatorId = state.pathParameters['elevatorId']!;
                                 final customerId = state.pathParameters['customerId']!;
                                 return MaintenanceFormScreen(elevatorId: elevatorId, customerId: customerId);
                               },
                             ),
                             GoRoute(
                               path: 'logbook',
                               name: 'elevator_logbook',
                               parentNavigatorKey: rootNavigatorKey,
                               builder: (context, state) {
                                 final elevatorId = state.pathParameters['elevatorId']!;
                                 final customerId = state.pathParameters['customerId']!;
                                 return ElevatorLogbookScreen(elevatorId: elevatorId, customerId: customerId);
                               },
                             ),
                             GoRoute(
                               path: 'fault-form',
                               name: 'fault_form',
                               parentNavigatorKey: rootNavigatorKey,
                               builder: (context, state) {
                                 final elevatorId = state.pathParameters['elevatorId']!;
                                 final customerId = state.pathParameters['customerId']!;
                                 return FaultFormScreen(elevatorId: elevatorId, customerId: customerId);
                               },
                             ),
                             GoRoute(
                               path: 'inspection-form',
                               name: 'inspection_form',
                               parentNavigatorKey: rootNavigatorKey,
                               builder: (context, state) {
                                 final elevatorId = state.pathParameters['elevatorId']!;
                                 final customerId = state.pathParameters['customerId']!;
                                 return PeriodicInspectionFormScreen(elevatorId: elevatorId, customerId: customerId);
                               },
                             ),
                          ],
                        ),
                    ]
                  ),
                  GoRoute(
                    path: 'van-stock',
                    name: 'van_stock',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const VanStockScreen(),
                  ),
                  GoRoute(
                    path: 'troubleshooting',
                    name: 'troubleshooting',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const TroubleshootingGuideScreen(),
                  ),
                  GoRoute(
                    path: 'maintenance-groups',
                    name: 'maintenance_groups',
                    builder: (context, state) => const MaintenanceGroupListScreen(),
                    routes: [
                      GoRoute(
                        path: ':groupId',
                        name: 'maintenance_group_detail',
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (context, state) {
                          final groupId = int.parse(state.pathParameters['groupId']!);
                          return MaintenanceGroupDetailScreen(groupId: groupId);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Branch 3: Settings (Renumbered)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final status = ref.read(authProvider);
      final isAtLogin = state.matchedLocation == AppRoutes.login;
      final isAtRegister = state.matchedLocation == AppRoutes.register;
      final isAtForgotPwd = state.matchedLocation == AppRoutes.forgotPassword;
      final isAtSplash = state.matchedLocation == AppRoutes.splash;

      if (status == AuthStatus.unknown) {
        return isAtSplash ? null : AppRoutes.splash;
      }
      
      if (status == AuthStatus.authenticated) {
        if (isAtLogin || isAtRegister || isAtForgotPwd || isAtSplash) return AppRoutes.dashboard;
      } else { // unauthenticated
        final isAuthRoute = isAtLogin || isAtRegister || isAtForgotPwd;
        if (!isAuthRoute) return AppRoutes.login;
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(authStream.stream),
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}