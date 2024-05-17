import 'package:flutter/material.dart';

import 'app_colors.dart';

// App Colors
class AppShadows {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  AppShadows._();

  static final cardShadow1 = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(0, 4),
    blurRadius: 60,
  );

  static final cardShadow2 = BoxShadow(
    color: AppColors.black.withOpacity(0.05),
    offset: const Offset(0, 4),
    blurRadius: 60,
  );

  static final cardShadow3 = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(0, 20),
    blurRadius: 100,
  );

  static final cardShadow4 = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(0, -6),
    blurRadius: 32,
  );

  static final cardShadow5 = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(0, 1),
    blurRadius: 4,
  );

  static final darkShadow1 = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(0, 4),
    blurRadius: 60,
  );

  static final darkShadow2 = BoxShadow(
    color: AppColors.black.withOpacity(0.05),
    offset: const Offset(0, 4),
    blurRadius: 60,
  );

  static final darkShadow3 = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(0, 20),
    blurRadius: 100,
  );

  static final darkShadow4 = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(0, 6),
    blurRadius: 32,
  );

  static final darkShadow4Reversed = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(0, -6),
    blurRadius: 32,
  );

  static final darkShadow5 = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(0, 1),
    blurRadius: 4,
  );

  static final darkShadow5Reversed = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(0, -1),
    blurRadius: 4,
  );

  static final darkShadow6 = BoxShadow(
    color: AppColors.black.withOpacity(0.32),
    offset: const Offset(0, 1),
    blurRadius: 4,
  );

  static final primaryShadow1 = BoxShadow(
    color: AppColors.primary.withOpacity(0.25),
    offset: const Offset(4, 8),
    blurRadius: 24,
  );

  static final primaryShadow2 = BoxShadow(
    color: AppColors.primary.withOpacity(0.20),
    offset: const Offset(4, 12),
    blurRadius: 32,
  );

  static final primaryShadow3 = BoxShadow(
    color: AppColors.primary.withOpacity(0.20),
    offset: const Offset(4, 16),
    blurRadius: 32,
  );

  static final primaryShadow4 = BoxShadow(
    color: AppColors.primary.withOpacity(0.12),
    offset: const Offset(4, 8),
    blurRadius: 24,
  );

  static final primaryShadow5 = BoxShadow(
    color: AppColors.primary.withOpacity(0.45),
    offset: const Offset(0, 2),
    blurRadius: 8,
  );

  static final primaryShadow6 = BoxShadow(
    color: AppColors.primary.withOpacity(0.24),
    offset: const Offset(0, 2),
    blurRadius: 4,
  );
}
