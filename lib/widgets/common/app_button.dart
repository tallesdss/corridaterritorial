import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

enum AppButtonType { primary, secondary, outline, danger, ghost }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;
  final double? width;
  final double height;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.fullWidth = true,
    this.width,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    return SizedBox(
      width: fullWidth ? double.infinity : width,
      height: height,
      child: _buildButton(context, isDisabled),
    );
  }

  Widget _buildButton(BuildContext context, bool isDisabled) {
    final Widget content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading)
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getForegroundColor(isDisabled),
              ),
            ),
          )
        else ...[
          if (icon != null) ...[
            Icon(icon, size: 20, color: _getForegroundColor(isDisabled)),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _getForegroundColor(isDisabled),
            ),
          ),
        ],
      ],
    );

    switch (type) {
      case AppButtonType.primary:
      case AppButtonType.secondary:
      case AppButtonType.danger:
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: _getBackgroundColor(),
            disabledBackgroundColor: _getBackgroundColor().withValues(alpha: 0.5),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
          child: content,
        );
      case AppButtonType.outline:
        return OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: isDisabled 
                  ? AppColors.borderDefault.withValues(alpha: 0.5) 
                  : _getBorderColor(),
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
          child: content,
        );
      case AppButtonType.ghost:
        return TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
          child: content,
        );
    }
  }

  Color _getBackgroundColor() {
    switch (type) {
      case AppButtonType.primary:
        return AppColors.primary;
      case AppButtonType.secondary:
        return AppColors.backgroundSecondary;
      case AppButtonType.danger:
        return AppColors.error;
      default:
        return Colors.transparent;
    }
  }

  Color _getForegroundColor(bool isDisabled) {
    if (isDisabled) return AppColors.textMuted;
    
    switch (type) {
      case AppButtonType.primary:
      case AppButtonType.danger:
        return Colors.white;
      case AppButtonType.secondary:
      case AppButtonType.outline:
      case AppButtonType.ghost:
        return AppColors.textPrimary;
    }
  }

  Color _getBorderColor() {
    if (type == AppButtonType.danger) return AppColors.error;
    return AppColors.primary;
  }
}
