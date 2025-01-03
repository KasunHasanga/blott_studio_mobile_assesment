import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/colors.dart';
import '../config/constants.dart';
import '../config/fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      this.labelColor = AppColors.kBlack,
      this.textColor,
      this.isObscureText = false,
      this.textCapitalization = TextCapitalization.words,
      required this.textController,
      this.inputFormatter,
      this.keyBoardType = TextInputType.text,
      this.maxLength = 40,
      this.isEnabled = true,
      this.labelText = '',
      this.onChanged,
      this.errorText,
      this.suffixIcon = const SizedBox(
        height: 0,
        width: 0,
      ),
      this.onValidate,
      this.focusNode,
      this.readOnly = false});

  final Color labelColor;
  final Color? textColor;
  final bool isObscureText;
  final TextCapitalization textCapitalization;
  final TextEditingController textController;
  final TextInputFormatter? inputFormatter;
  final TextInputType keyBoardType;
  final int maxLength;
  final bool isEnabled;
  final Widget suffixIcon;
  final String labelText;
  final ValueChanged? onChanged;
  final String? errorText;
  final String? Function(String?)? onValidate;
  final FocusNode? focusNode;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      autofocus: true,
      focusNode: focusNode,
      keyboardType: keyBoardType,
      obscureText: isObscureText,
      textCapitalization: textCapitalization,
      controller: textController,
      onChanged: onChanged,
      maxLength: maxLength,
      validator: onValidate,
      enabled: isEnabled,
      inputFormatters: inputFormatter != null ? [inputFormatter!] : [],
      onTapOutside: (event) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      style: AppFonts.styleWithRobotoRegularText(
          fSize: FontSizeValue.fontSize20,
          color: textColor ?? Theme.of(context).colorScheme.onSurface),
      decoration: InputDecoration(
        // filled: true,
        // fillColor: Theme.of(context).colorScheme.onSurface,
        counterText: '',
        suffixIcon: suffixIcon,
        errorText: errorText,
        errorStyle: AppFonts.styleWithRobotoMediumText(
            color: AppColors.kRed, fSize: FontSizeValue.fontSize14),
        hintText: labelText,
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4)),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.4))),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.4))),
      ),
    );
  }
}
