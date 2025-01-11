import 'package:flutter/material.dart';
import 'package:tasks/constants/dimension_constants.dart';

class InputFieldWidget extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  const InputFieldWidget({
    super.key,
    required this.label,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DimensionsConstants.maxWidth,
      child: Padding(
        padding: EdgeInsets.all(DimensionsConstants.normalPadding),
        child: TextFormField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  DimensionsConstants.inputFieldRoundness),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
