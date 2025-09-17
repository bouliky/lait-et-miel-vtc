import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/logo_widget.dart';
import 'admin_dashboard_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulation d'authentification
    await Future.delayed(Duration(seconds: 2));

    // Pour la démo, accepte n'importe quel email/mot de passe
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email et mot de passe requis'),
          backgroundColor: AppColors.error,
        ),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  
                  // Logo et titre
                  const LogoWidget(
                    width: 150,
                    height: 80,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Administration',
                    style: AppTextStyles.headingLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Accès réservé aux administrateurs',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Formulaire de connexion
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connexion',
                          style: AppTextStyles.headingMedium,
                        ),
                        const SizedBox(height: 20),
                        
                        // Email
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: 'admin@laitetmiel.com',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez saisir votre email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Mot de passe
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            prefixIcon: Icon(Icons.lock_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword 
                                  ? Icons.visibility_off 
                                  : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez saisir votre mot de passe';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        
                        // Bouton de connexion
                        CustomButton(
                          text: _isLoading ? 'Connexion...' : 'Se connecter',
                          isFullWidth: true,
                          onPressed: _isLoading ? null : _login,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Informations de démo
                  CustomCard(
                    child: Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.info,
                          size: 24,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Mode Démo',
                          style: AppTextStyles.headingSmall.copyWith(
                            color: AppColors.info,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Saisissez n\'importe quel email et mot de passe pour accéder au dashboard',
                          style: AppTextStyles.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
