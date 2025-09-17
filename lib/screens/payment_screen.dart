import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';
import '../widgets/logo_widget.dart';
import '../services/payment_service.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> reservationData;

  const PaymentScreen({
    Key? key,
    required this.reservationData,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isProcessing = false;
  PaymentResult? _lastPaymentResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paiement'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textLight,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo et titre
                Center(
                  child: Column(
                    children: [
                      const LogoWidget(
                        width: 120,
                        height: 60,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Finaliser votre réservation',
                        style: AppTextStyles.headingLarge,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Résumé de la réservation
                _buildReservationSummary(),
                const SizedBox(height: 24),
                
                // Détails du paiement
                _buildPaymentDetails(),
                const SizedBox(height: 24),
                
                // Boutons de paiement
                _buildPaymentButtons(),
                
                if (_lastPaymentResult != null) ...[
                  const SizedBox(height: 24),
                  _buildPaymentResult(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReservationSummary() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Résumé de votre réservation',
            style: AppTextStyles.headingMedium,
          ),
          const SizedBox(height: 16),
          
          _buildSummaryRow('Type de service', widget.reservationData['type'] ?? 'VTC'),
          _buildSummaryRow('Trajet', widget.reservationData['trajet'] ?? 'Non spécifié'),
          _buildSummaryRow('Date', widget.reservationData['date'] ?? 'Non spécifiée'),
          _buildSummaryRow('Heure', widget.reservationData['heure'] ?? 'Non spécifiée'),
          _buildSummaryRow('Durée estimée', widget.reservationData['duree'] ?? 'Non spécifiée'),
          
          const Divider(),
          
          _buildSummaryRow(
            'Montant total',
            '€${widget.reservationData['montant']?.toStringAsFixed(2) ?? '0.00'}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: isTotal 
                ? AppTextStyles.headingSmall.copyWith(color: AppColors.primary)
                : AppTextStyles.bodyMedium,
            ),
          ),
          Text(
            value,
            style: isTotal 
              ? AppTextStyles.headingSmall.copyWith(color: AppColors.primary)
              : AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Détails du paiement',
            style: AppTextStyles.headingMedium,
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Icon(
                Icons.security,
                color: AppColors.success,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Paiement sécurisé SSL',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.credit_card,
                color: AppColors.info,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Cartes acceptées: Visa, Mastercard, American Express',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: AppColors.accent,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'PayPal accepté',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButtons() {
    return Column(
      children: [
        CustomButton(
          text: 'Payer avec Stripe',
          icon: Icons.credit_card,
          isFullWidth: true,
          onPressed: _isProcessing ? null : () => _processStripePayment(),
        ),
        const SizedBox(height: 12),
        CustomButton(
          text: 'Payer avec PayPal',
          icon: Icons.account_balance_wallet,
          isFullWidth: true,
          isPrimary: false,
          onPressed: _isProcessing ? null : () => _processPayPalPayment(),
        ),
        const SizedBox(height: 12),
        CustomButton(
          text: 'Choisir le mode de paiement',
          icon: Icons.payment,
          isFullWidth: true,
          isPrimary: false,
          onPressed: _isProcessing ? null : () => _showPaymentMethodDialog(),
        ),
      ],
    );
  }

  Widget _buildPaymentResult() {
    if (_lastPaymentResult == null) return SizedBox.shrink();

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _lastPaymentResult!.success ? Icons.check_circle : Icons.error,
                color: _lastPaymentResult!.success ? AppColors.success : AppColors.error,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                _lastPaymentResult!.success ? 'Paiement réussi!' : 'Erreur de paiement',
                style: AppTextStyles.headingSmall.copyWith(
                  color: _lastPaymentResult!.success ? AppColors.success : AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          if (_lastPaymentResult!.success) ...[
            _buildResultRow('ID de transaction', _lastPaymentResult!.transactionId ?? 'N/A'),
            _buildResultRow('Montant', '€${_lastPaymentResult!.amount?.toStringAsFixed(2) ?? '0.00'}'),
            _buildResultRow('Méthode', _lastPaymentResult!.paymentMethod ?? 'N/A'),
            _buildResultRow('Devise', _lastPaymentResult!.currency ?? 'EUR'),
            
            const SizedBox(height: 16),
            CustomButton(
              text: 'Retour à l\'accueil',
              icon: Icons.home,
              isFullWidth: true,
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ] else ...[
            Text(
              _lastPaymentResult!.error ?? 'Erreur inconnue',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
              ),
            ),
            
            const SizedBox(height: 16),
            CustomButton(
              text: 'Réessayer',
              icon: Icons.refresh,
              isFullWidth: true,
              onPressed: () {
                setState(() => _lastPaymentResult = null);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _processStripePayment() async {
    setState(() => _isProcessing = true);

    final result = await PaymentService.processStripePayment(
      amount: widget.reservationData['montant']?.toDouble() ?? 0.0,
      currency: 'EUR',
      description: 'Réservation ${widget.reservationData['type'] ?? 'VTC'}',
      context: context,
    );

    setState(() {
      _isProcessing = false;
      _lastPaymentResult = result;
    });
  }

  Future<void> _processPayPalPayment() async {
    setState(() => _isProcessing = true);

    final result = await PaymentService.processPayPalPayment(
      amount: widget.reservationData['montant']?.toDouble() ?? 0.0,
      currency: 'EUR',
      description: 'Réservation ${widget.reservationData['type'] ?? 'VTC'}',
      context: context,
    );

    setState(() {
      _isProcessing = false;
      _lastPaymentResult = result;
    });
  }

  Future<void> _showPaymentMethodDialog() async {
    await PaymentService.showPaymentMethodDialog(
      context: context,
      amount: widget.reservationData['montant']?.toDouble() ?? 0.0,
      currency: 'EUR',
      description: 'Réservation ${widget.reservationData['type'] ?? 'VTC'}',
      onPaymentComplete: (result) {
        setState(() => _lastPaymentResult = result);
      },
    );
  }
}
