import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_with_provider_template/themes/app_theme.dart';

import '../themes/app_colors.dart';
import '../themes/app_sizes.dart';

enum AppButtonAlignment {
  horizontal,
  vertical,
}

class AppButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? fontSize;
  final double? borderWidth;
  final double borderRadius;
  final double loadingIndicatorSize;
  final EdgeInsets padding;
  final EdgeInsets textPadding;
  final bool enable;
  final bool rounded;
  final bool showBoxShadow;
  final bool isLoading;
  final bool center;
  final List<BoxShadow>? boxShadow;
  final Color? buttonColor;
  final Color? disabledButtonColor;
  final Color? disabledTextColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Color? loadingIndicatorColor;
  final String? text;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefixIconWidget;
  final Widget? textWidget;
  final Widget? suffixIconWidget;
  final AppButtonAlignment alignment;
  final Function() onTap;
  final List<Color>? colorGradient;
  final bool isGradient;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;

  const AppButton({
    super.key,
    this.width,
    this.height,
    this.fontSize,
    this.borderWidth,
    this.borderRadius = 6,
    this.loadingIndicatorSize = 22,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSizes.padding * 2, vertical: AppSizes.padding),
    this.textPadding = const EdgeInsets.symmetric(horizontal: AppSizes.padding / 2),
    this.enable = true,
    this.rounded = true,
    this.showBoxShadow = false,
    this.isLoading = false,
    this.center = true,
    this.boxShadow,
    this.buttonColor,
    this.disabledButtonColor,
    this.disabledTextColor,
    this.textColor,
    this.borderColor,
    this.prefixIconColor,
    this.suffixIconColor,
    this.loadingIndicatorColor,
    this.text,
    this.fontWeight = FontWeight.bold,
    this.fontFamily,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconWidget,
    this.textWidget,
    this.suffixIconWidget,
    this.alignment = AppButtonAlignment.horizontal,
    required this.onTap,
    this.isGradient = false,
    this.begin,
    this.end,
    this.colorGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(rounded ? 100 : borderRadius),
      color: buttonColor ?? AppTheme().colorScheme.primary,
      child: InkWell(
        onTap: enable && !isLoading ? onTap : null,
        splashFactory: InkRipple.splashFactory,
        highlightColor: !enable ? Colors.transparent : null,
        borderRadius: BorderRadius.circular(rounded ? 100 : borderRadius),
        child: Ink(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            gradient: isGradient
                ? LinearGradient(
                    colors: colorGradient ?? [AppColors.blue, AppColors.darkBlue],
                    begin: begin ?? Alignment.centerLeft,
                    end: end ?? Alignment.centerRight,
                  )
                : null,
            color: enable
                ? (buttonColor ?? AppTheme().colorScheme.primary)
                : (disabledButtonColor ?? AppTheme().colorScheme.surface),
            borderRadius: BorderRadius.circular(rounded ? 100 : borderRadius),
            border: borderWidth != null
                ? Border.all(
                    width: borderWidth!,
                    color: borderColor ?? AppTheme().colorScheme.outline,
                  )
                : null,
            boxShadow: showBoxShadow && enable ? boxShadow : null,
          ),
          child: center ? Center(child: child()) : child(),
        ),
      ),
    );
  }

  Widget child() {
    if (isLoading) {
      return loadingIndicatorWidget();
    }

    if (alignment == AppButtonAlignment.vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          leftWidget(),
          buttonText(),
          rightWidget(),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        leftWidget(),
        buttonText(),
        rightWidget(),
      ],
    );
  }

  Widget buttonText() {
    if (textWidget != null) {
      return textWidget!;
    }

    if (text == null) {
      return const SizedBox.shrink();
    }

    return Flexible(
      child: Padding(
        padding: textPadding,
        child: Text(
          text!,
          overflow: TextOverflow.ellipsis,
          style: AppTheme().textTheme.bodyLarge?.copyWith(
                fontSize: fontSize ?? 16,
                color: enable
                    ? (textColor ?? AppTheme().colorScheme.onPrimary)
                    : (disabledTextColor ?? AppTheme().colorScheme.onSurface),
                fontWeight: fontWeight,
                fontFamily: fontFamily,
              ),
        ),
      ),
    );
  }

  Widget leftWidget() {
    if (prefixIconWidget != null) {
      return prefixIconWidget!;
    }

    if (prefixIcon != null) {
      return Icon(
        prefixIcon,
        color: enable ? prefixIconColor ?? textColor ?? AppTheme().colorScheme.onPrimary : disabledTextColor,
        size: (fontSize ?? 16) + 2,
      );
    }

    return const SizedBox.shrink();
  }

  Widget rightWidget() {
    if (suffixIconWidget != null) {
      return suffixIconWidget!;
    }

    if (suffixIcon != null) {
      return Icon(
        suffixIcon,
        color: enable
            ? (suffixIconColor ?? textColor ?? AppTheme().colorScheme.onPrimary)
            : disabledTextColor ?? AppTheme().colorScheme.onSurface,
        size: (fontSize ?? 16) + 2,
      );
    }

    return const SizedBox.shrink();
  }

  Widget loadingIndicatorWidget() {
    return SizedBox(
      width: loadingIndicatorSize,
      height: loadingIndicatorSize,
      child: CircularProgressIndicator(
        color: loadingIndicatorColor ?? AppTheme().colorScheme.onPrimary,
      ),
    );
  }
}
