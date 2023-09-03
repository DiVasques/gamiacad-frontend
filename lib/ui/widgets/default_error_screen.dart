import 'package:flutter/material.dart';
import 'package:gami_acad/ui/utils/app_colors.dart';

class DefaultErrorScreen extends StatelessWidget {
  final String? message;
  final void Function()? onPressed;

  const DefaultErrorScreen({
    this.message,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Erro:',
            style: TextStyle(
              color: AppColors.defaultGrey,
              fontSize: 20,
            ),
          ),
          Text(
            message ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.defaultGrey,
              fontSize: 20,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.replay_outlined,
              size: 30,
            ),
            onPressed: onPressed,
            color: AppColors.defaultGrey,
          ),
        ],
      ),
    );
  }
}
