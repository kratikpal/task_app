import 'package:tasks/constants/dimension_constants.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final bool isLoading;
  const ButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DimensionsConstants.maxWidth,
      child: Padding(
        padding: EdgeInsets.all(DimensionsConstants.normalPadding),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.primary,
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  DimensionsConstants.buttonRoundness,
                ),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(DimensionsConstants.smallPadding),
            child: isLoading
                ? CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
                : Text(
                    label,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
