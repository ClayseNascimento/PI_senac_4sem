import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:todolist/src/@shared/constants/todo_colors.dart';

class Button {
  static const _debounceTapDuration = 2;

  final String text;
  final Function()? onPressed;
  final double? fixedHeight;
  final ButtonType? type;

  const Button({
    required this.text,
    this.onPressed,
    this.fixedHeight = 47,
    this.type = ButtonType.large,
  });


   TapDebouncer get primario => TapDebouncer(
        onTap: onPressed != null
            ? () async {
                onPressed!();
              }
            : null,
        cooldown: const Duration(seconds: _debounceTapDuration),
        builder: (_, TapDebouncerFunc? onTap) {
          return ElevatedButton(
            onPressed: onTap,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) return TodoColors.cinza;
                return TodoColors.azul;
              }),
              foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) return TodoColors.branco;
                return TodoColors.branco;
              }),
              textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
                if (states.contains(MaterialState.disabled)) {
                  return GoogleFonts.workSans(fontSize: 16, fontWeight: FontWeight.bold);
                }
                return GoogleFonts.workSans(fontSize: 16, fontWeight: FontWeight.bold);
              }),
              elevation: MaterialStateProperty.resolveWith<double>((states) {
                if (states.contains(MaterialState.disabled)) return 0.0;
                return 3;
              }),
              shadowColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) return TodoColors.branco;
                return TodoColors.azulClaro;
              }),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              overlayColor: MaterialStateProperty.all(TodoColors.azul),
            ),
            child: _buildContent(),
          );
        });


  Widget _buildContent() {
    return Container(
      width: _buildWidthButton(),
      height: fixedHeight! > 0 ? fixedHeight : null,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: fixedHeight! > 0 ? 0.0 : _buildPaddingButton()),
      child: Center(
          child: Text(
        text,
        textAlign: TextAlign.center,
      )),
    );
  }

  double _buildWidthButton() {
    switch (type) {
      case ButtonType.small:
        return 95;
      case ButtonType.medium:
        return 196;
      case ButtonType.large:
      default:
        return 270;
    }
  }

  double _buildPaddingButton() {
    switch (type) {
      case ButtonType.small:
        return 9;
      case ButtonType.medium:
      case ButtonType.large:
      default:
        return 12;
    }
  }
}

enum ButtonType {
  large,
  medium,
  small,
}
