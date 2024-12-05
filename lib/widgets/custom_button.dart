import 'package:flutter/material.dart';
import 'package:sm_assignment_1/widgets/glassmorphism.dart';

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
    return InkWell(
      borderRadius: BorderRadius.circular(9999),
      onTap: widget.onPressed,
      child: Glassmorphism(
        width: MediaQuery.of(context).size.width,
        // height: AppSizes.sizeButtonHeight,
        // padding: const EdgeInsets.symmetric(
        //   // vertical: AppSizes.smallPadding,
        //   horizontal: AppSizes.mediumPadding,
        // ),
        child:
            widget.isLoading ? const CircularProgressIndicator() : widget.child,
      ),
    );
  }
}
