import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/firebase_service.dart';
import 'screens/home_screen.dart';
import 'screens/vtc_screen.dart';
import 'screens/location_screen.dart';
import 'screens/reservation_screen.dart';
import 'screens/profil_screen.dart';
import 'screens/map_screen.dart';
import 'screens/driver_screen.dart';
import 'screens/reservation_form_screen.dart';
import 'screens/admin/admin_login_screen.dart';
import 'constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService.initialize();
  runApp(LaitEtMielApp());
}

class LaitEtMielApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lait et Miel',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFD4AF37, {
          50: Color(0xFFFFF8DC),
          100: Color(0xFFFFF0B3),
          200: Color(0xFFFFE680),
          300: Color(0xFFFFDD4D),
          400: Color(0xFFD4AF37),
          500: Color(0xFFD4AF37),
          600: Color(0xFFB8860B),
          700: Color(0xFF9A7209),
          800: Color(0xFF7C5E07),
          900: Color(0xFF5E4A05),
        }),
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.textSecondary.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.textSecondary.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/vtc': (context) => VtcScreen(),
        '/location': (context) => LocationScreen(),
        '/reservation': (context) => ReservationScreen(),
        '/profil': (context) => ProfilScreen(),
        '/map': (context) => MapScreen(),
        '/reservation_form': (context) => ReservationFormScreen(),
        '/driver': (context) => DriverScreen(),
        '/admin': (context) => AdminLoginScreen(),
      },
    );
  }
}
