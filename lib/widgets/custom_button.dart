import 'package:flutter/material.dart';
import 'package:sm_assignment_1/utils/theme/app_colors.dart';
import 'package:sm_assignment_1/utils/theme/app_sizes.dart';

class CustomButton extends StatefulWidget {
  final Widget child;
  final Function()? onPressed;
  final bool isLoading;
  const CustomButton(
      {super.key, required this.child, this.onPressed, this.isLoading = false});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(9999),
        onTap: widget.onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(
              color: AppColors.greyColor,
            ),
          ),
          height: AppSizes.sizeButtonHeight,
          padding: const EdgeInsets.symmetric(
            // vertical: AppSizes.smallPadding,
            horizontal: AppSizes.mediumPadding,
          ),
          child:
              widget.isLoading ? const CircularProgressIndicator() : widget.child,
        ),
      ),
    );
  }
}
