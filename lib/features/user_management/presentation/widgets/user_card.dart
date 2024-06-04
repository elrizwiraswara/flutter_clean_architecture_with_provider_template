import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_with_provider_template/features/user_management/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_with_provider_template/themes/app_sizes.dart';
import 'package:flutter_clean_architecture_with_provider_template/themes/app_theme.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;
  final Function() onTapCard;
  final Function() onTapEdit;
  final Function() onTapDelete;

  const UserCard({
    super.key,
    required this.user,
    required this.onTapCard,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapCard,
      borderRadius: BorderRadius.circular(AppSizes.radius),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.padding / 2),
        decoration: BoxDecoration(
          color: AppTheme().colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppSizes.radius),
        ),
        child: Row(
          children: [
            _leading(),
            _content(),
            _actionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _leading() {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme().colorScheme.onPrimaryContainer,
      ),
      child: Icon(
        Icons.person,
        color: AppTheme().colorScheme.onPrimary,
      ),
    );
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.name,
          style: AppTheme().textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSizes.padding / 2),
        Text(
          user.email,
          style: AppTheme().textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        )
      ],
    );
  }

  Widget _actionButtons() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          color: AppTheme().colorScheme.onPrimaryContainer,
          icon: Icon(
            Icons.edit_note,
            color: AppTheme().colorScheme.onPrimary,
          ),
        ),
        IconButton(
          onPressed: () {},
          color: AppTheme().colorScheme.error,
          icon: Icon(
            Icons.delete,
            color: AppTheme().colorScheme.onError,
          ),
        ),
      ],
    );
  }
}
