import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/circular_bounce_loader.dart';
import 'package:happy_habit/core/theme/typography.dart';

class SomethingWentWrongV2 extends StatelessWidget {
  final bool isLoading;
  final bool showRetryButton;
  final VoidCallback? onRetry;
  final String message, retryLabel;

  const SomethingWentWrongV2({
    super.key,
    this.onRetry,
    this.isLoading = false,
    this.showRetryButton = true,
    this.retryLabel = 'Try again',
    this.message = "Something went wrong",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 52.h,
            child: Stack(
              children: [
                const Icon(
                  Icons.cloud_outlined,
                  size: 50,
                  color: Colors.black54,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
          10.height,
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.titleLarge?.copyWith(
              color: Colors.black54,
            ),
          ),
          if (showRetryButton)
            isLoading
                ? Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: CircleBounceLoader(size: 24.r),
                  )
                : TextButton(
                    onPressed: onRetry,
                    child: Text(retryLabel),
                  ),
        ],
      ),
    );
  }
}
