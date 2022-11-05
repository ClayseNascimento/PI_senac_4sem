import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todolist/src/@shared/constants/todo_colors.dart';

class ButtonAdd extends StatelessWidget {
  final Function()? onTap;
  final double? size;

  const ButtonAdd({Key? key, this.onTap, this.size = 75}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: TodoColors.transparent,
        ),
        child: Material(
          elevation: 0,
          shape: const CircleBorder(),
          color: TodoColors.branco,
          child: InkWell(
              onTap: () {
                if (onTap != null) onTap!();
              },
              customBorder: const CircleBorder(),
              borderRadius: BorderRadius.circular(10),
            child: Icon(
              FontAwesomeIcons.circlePlus,
              size: size,
              color: onTap != null ? TodoColors.azul : TodoColors.cinza,
            )),
        ),
      );
  }
}
