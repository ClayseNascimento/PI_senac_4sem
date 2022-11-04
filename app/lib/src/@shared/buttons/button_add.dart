import 'package:flutter/material.dart';
import 'package:todolist/src/@shared/constants/todo_colors.dart';
import 'package:todolist/src/@shared/icons/todo_list_icons.dart';

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
              child: Icon(TodoListIcons.add_circle, size: size, color: onTap != null ? TodoColors.azul : TodoColors.cinza,)),
        ),
      );
  }
}
