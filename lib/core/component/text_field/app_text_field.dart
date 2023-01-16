import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.prefix,
    this.suffix,
    this.textInputAction,
    this.label,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? prefix;
  final Widget? suffix;
  final String? hint;
  final String? label;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label ?? "",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (prefix != null) ...[
              prefix!,
              const SizedBox(width: 10),
            ],
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                obscureText: obscureText,
                decoration: InputDecoration(
                  suffixIcon: suffix,
                  hintText: hint,
                ),
                style: Theme.of(context).textTheme.bodyMedium,
                inputFormatters: inputFormatters,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
