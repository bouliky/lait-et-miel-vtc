import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:paypal_payment/paypal_payment.dart';
import '../constants/app_colors.dart';

class PaymentService {
  static const String _stripePublishableKey = 'pk_test_your_stripe_publishable_key_here';
  static const String _paypalClientId = 'your_paypal_client_id_here';
  
  static Future<void> initializeStripe() async {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: _stripePublishableKey,
        merchantId: "Test",
        androidPayMode: 'test',
      ),
    );
  }

  static Future<PaymentResult> processStripePayment({
    required double amount,
    required String currency,
    required String description,
    required BuildContext context,
  }) async {
    try {
      // Créer un token de paiement
      final token = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(
          card: CreditCard(
            number: '4242424242424242', // Carte de test
            expMonth: 12,
            expYear: 2025,
            cvc: '123',
          ),
        ),
      );

      if (token != null) {
        // Simuler le traitement du paiement
        await Future.delayed(Duration(seconds: 2));
        
        return PaymentResult(
          success: true,
          transactionId: 'stripe_${DateTime.now().millisecondsSinceEpoch}',
          amount: amount,
          currency: currency,
          paymentMethod: 'Stripe',
        );
      } else {
        return PaymentResult(
          success: false,
          error: 'Impossible de créer le token de paiement',
        );
      }
    } catch (e) {
      return PaymentResult(
        success: false,
        error: 'Erreur lors du paiement Stripe: $e',
      );
    }
  }

  static Future<PaymentResult> processPayPalPayment({
    required double amount,
    required String currency,
    required String description,
    required BuildContext context,
  }) async {
    try {
      final result = await PayPalPayment.requestPayment(
        amount: amount.toString(),
        currency: currency,
        description: description,
        clientId: _paypalClientId,
        environment: PayPalEnvironment.sandbox,
      );

      if (result != null && result.status == PayPalPaymentStatus.success) {
        return PaymentResult(
          success: true,
          transactionId: result.transactionId ?? 'paypal_${DateTime.now().millisecondsSinceEpoch}',
          amount: amount,
          currency: currency,
          paymentMethod: 'PayPal',
        );
      } else {
        return PaymentResult(
          success: false,
          error: 'Paiement PayPal annulé ou échoué',
        );
      }
    } catch (e) {
      return PaymentResult(
        success: false,
        error: 'Erreur lors du paiement PayPal: $e',
      );
    }
  }

  static Future<void> showPaymentMethodDialog({
    required BuildContext context,
    required double amount,
    required String currency,
    required String description,
    required Function(PaymentResult) onPaymentComplete,
  }) async {
    showDialog(
      context: context,
      builder: (context) => PaymentMethodDialog(
        amount: amount,
        currency: currency,
        description: description,
        onPaymentComplete: onPaymentComplete,
      ),
    );
  }
}

class PaymentResult {
  final bool success;
  final String? transactionId;
  final double? amount;
  final String? currency;
  final String? paymentMethod;
  final String? error;

  PaymentResult({
    required this.success,
    this.transactionId,
    this.amount,
    this.currency,
    this.paymentMethod,
    this.error,
  });
}

class PaymentMethodDialog extends StatefulWidget {
  final double amount;
  final String currency;
  final String description;
  final Function(PaymentResult) onPaymentComplete;

  const PaymentMethodDialog({
    Key? key,
    required this.amount,
    required this.currency,
    required this.description,
    required this.onPaymentComplete,
  }) : super(key: key);

  @override
  _PaymentMethodDialogState createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends State<PaymentMethodDialog> {
  bool _isProcessing = false;
  String? _selectedMethod;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choisir un mode de paiement'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Montant: ${widget.amount.toStringAsFixed(2)} ${widget.currency}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          
          // Stripe
          _buildPaymentOption(
            'Stripe',
            'Carte bancaire',
            Icons.credit_card,
            AppColors.primary,
            'stripe',
          ),
          const SizedBox(height: 12),
          
          // PayPal
          _buildPaymentOption(
            'PayPal',
            'Compte PayPal',
            Icons.account_balance_wallet,
            AppColors.info,
            'paypal',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isProcessing ? null : () => Navigator.pop(context),
          child: Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: _isProcessing || _selectedMethod == null
              ? null
              : _processPayment,
          child: _isProcessing
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.textLight),
                  ),
                )
              : Text('Payer'),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String value,
  ) {
    final isSelected = _selectedMethod == value;
    
    return GestureDetector(
      onTap: () {
        setState(() => _selectedMethod = value);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? color : AppColors.textSecondary.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? color.withOpacity(0.1) : AppColors.surface,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? color : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: color,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _processPayment() async {
    setState(() => _isProcessing = true);

    PaymentResult result;
    
    if (_selectedMethod == 'stripe') {
      result = await PaymentService.processStripePayment(
        amount: widget.amount,
        currency: widget.currency,
        description: widget.description,
        context: context,
      );
    } else if (_selectedMethod == 'paypal') {
      result = await PaymentService.processPayPalPayment(
        amount: widget.amount,
        currency: widget.currency,
        description: widget.description,
        context: context,
      );
    } else {
      result = PaymentResult(
        success: false,
        error: 'Méthode de paiement non supportée',
      );
    }

    setState(() => _isProcessing = false);

    if (result.success) {
      Navigator.pop(context);
      widget.onPaymentComplete(result);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Paiement réussi! ID: ${result.transactionId}'),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur de paiement: ${result.error}'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}
