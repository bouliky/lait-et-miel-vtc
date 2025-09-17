import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isFullWidth;
  final IconData? icon;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isPrimary = true,
    this.isFullWidth = false,
    this.icon,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      height: 48,
      decoration: BoxDecoration(
        gradient: isPrimary ? AppGradients.primaryGradient : null,
        color: isPrimary ? null : AppColors.buttonSecondary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isPrimary ? AppColors.textLight : AppColors.textPrimary,
                      ),
                    ),
                  )
                else if (icon != null) ...[
                  Icon(
                    icon,
                    color: isPrimary ? AppColors.textLight : AppColors.textPrimary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                ],
                if (!isLoading)
                  Text(
                    text,
                    style: isPrimary 
                        ? AppTextStyles.buttonLarge
                        : AppTextStyles.buttonLarge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
