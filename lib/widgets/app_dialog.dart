import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_with_provider_template/themes/app_theme.dart';

import '../themes/app_sizes.dart';
import 'app_button.dart';

class AppDialog {
  static Future<dynamic> show(
    NavigatorState navigator, {
    Widget? child,
    String? title,
    String? text,
    String? leftButtonText,
    String? rightButtonText,
    Color? backgroundColor,
    Color? leftButtonTextColor,
    Color? rightButtonTextColor,
    EdgeInsets? padding,
    double? elevation,
    bool dismissible = true,
    Function()? onTapLeftButton,
    Function()? onTapRightButton,
  }) async {
    return showDialog(
      context: navigator.context,
      builder: (context) {
        return AppDialogWidget(
          title: title,
          text: text,
          padding: padding,
          rightButtonText: rightButtonText,
          leftButtonText: leftButtonText,
          backgroundColor: backgroundColor,
          onTapLeftButton: onTapLeftButton,
          onTapRightButton: onTapRightButton,
          dismissible: dismissible,
          leftButtonTextColor: leftButtonTextColor,
          rightButtonTextColor: rightButtonTextColor,
          elevation: elevation,
          child: child,
        );
      },
    );
  }

  static Future<void> showErrorDialog(
    NavigatorState navigator, {
    String? title,
    String? message,
    String? error,
  }) async {
    showDialog(
      context: navigator.context,
      barrierDismissible: false,
      builder: (context) {
        return AppDialogWidget(
          title: title ?? 'Oops!',
          leftButtonText: 'Close',
          child: Column(
            children: [
              Text(
                message ?? 'Something went wrong, please contact your system administrator or try restart the app',
                textAlign: TextAlign.center,
                style: AppTheme().textTheme.bodyMedium,
              ),
              if (error != null)
                Padding(
                  padding: const EdgeInsets.only(top: AppSizes.padding),
                  child: Text(
                    error.toString().length > 35 ? error.toString().substring(0, 35) : error.toString(),
                    textAlign: TextAlign.center,
                    style: AppTheme().textTheme.bodySmall?.copyWith(color: AppTheme().colorScheme.onSurface),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showDialogProgress(
    NavigatorState navigator, {
    bool dismissible = false,
  }) async {
    showDialog(
      context: navigator.context,
      builder: (context) {
        return AppDialogWidget(
          dismissible: kDebugMode ? true : dismissible,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const CircularProgressIndicator(),
        );
      },
    );
  }
}

// Default Dialog
class AppDialogWidget extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? text;
  final String? leftButtonText;
  final String? rightButtonText;
  final Color? backgroundColor;
  final Color? leftButtonTextColor;
  final Color? rightButtonTextColor;
  final EdgeInsets? padding;
  final double? elevation;
  final bool dismissible;
  final Function()? onTapLeftButton;
  final Function()? onTapRightButton;

  const AppDialogWidget({
    super.key,
    this.child,
    this.title,
    this.text,
    this.leftButtonText,
    this.rightButtonText,
    this.backgroundColor,
    this.leftButtonTextColor,
    this.rightButtonTextColor,
    this.padding,
    this.elevation,
    this.dismissible = true,
    this.onTapLeftButton,
    this.onTapRightButton,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: dismissible,
      child: Dialog(
        elevation: elevation,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 512),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                dialogTitle(),
                dialogBody(),
                dialogButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dialogTitle() {
    if (title == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Text(
        title!,
        textAlign: TextAlign.center,
        style: AppTheme().textTheme.titleLarge,
      ),
    );
  }

  Widget dialogBody() {
    return Container(
      padding: padding ?? const EdgeInsets.all(AppSizes.padding),
      alignment: Alignment.center,
      child: text != null
          ? Text(
              text!,
              textAlign: TextAlign.center,
              style: AppTheme().textTheme.bodyMedium,
            )
          : child ?? const SizedBox.shrink(),
    );
  }

  Widget dialogButtons(BuildContext context) {
    if (leftButtonText == null && rightButtonText == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: <Widget>[
          leftButtonText != null
              ? Expanded(
                  child: AppButton(
                    text: leftButtonText!,
                    buttonColor: backgroundColor,
                    textColor: leftButtonTextColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.padding,
                      horizontal: AppSizes.padding / 2,
                    ),
                    onTap: () async {
                      if (onTapLeftButton != null) {
                        onTapLeftButton!();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                )
              : const SizedBox.shrink(),
          leftButtonText != null && rightButtonText != null
              ? Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  height: 18,
                  width: 1,
                  color: AppTheme().colorScheme.surface,
                )
              : const SizedBox.shrink(),
          rightButtonText != null
              ? Expanded(
                  child: AppButton(
                    text: rightButtonText!,
                    buttonColor: backgroundColor,
                    textColor: rightButtonTextColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.padding,
                      horizontal: AppSizes.padding / 2,
                    ),
                    onTap: () async {
                      if (onTapRightButton != null) {
                        onTapRightButton!();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
