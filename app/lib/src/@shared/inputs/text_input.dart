import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todolist/src/@shared/constants/todo_colors.dart';

class TextInput extends StatelessWidget {
  final String? formControlName;
  final FormControl? formControl;
  final Map<String, String>? validationMessages;
  final int? length;
  final Function()? onSubmitted;
  final Function()? onTap;
  final int? maxLines;
  final String? hintText;

  const TextInput({
    Key? key,
    this.formControlName,
    this.formControl,
    this.length,
    this.onSubmitted,
    this.validationMessages,
    this.onTap,
    this.maxLines, this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControl: formControl,
      formControlName: formControlName,
      validationMessages: validationMessages?.map((key, value) => MapEntry(key, (error) => value)) ?? {},
      keyboardType: TextInputType.text,
      maxLength: length,
      style: GoogleFonts.workSans(fontSize: 16, color: TodoColors.cinza),
      onSubmitted: onSubmitted != null ? (_) => onSubmitted!() : null,
      onTap: onTap != null ? (_) => onTap!() : null,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
          fontSize: 16,
          color: TodoColors.cinza,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: TodoColors.cinza, width: 0.77),
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: TodoColors.cinza, width: 0.77),
          borderRadius: BorderRadius.circular(6.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: TodoColors.vermelho, width: 0.77),
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: TodoColors.vermelho, width: 0.77),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }
}
