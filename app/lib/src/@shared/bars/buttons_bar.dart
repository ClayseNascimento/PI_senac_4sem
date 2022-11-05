import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/src/@shared/constants/todo_colors.dart';
import 'package:todolist/src/@shared/icons/todo_list_icons.dart';
import 'package:todolist/src/presentation/tarefas/tarefas_module.dart';

class ButtonsBar extends StatelessWidget {
  const ButtonsBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final widthIsNotLarge = widthScreen <= 992;

    return Material(
      color: Colors.transparent,
      child: widthIsNotLarge ? _buildButtonBarMobile(context) : _buildButtonBarWeb(context),
    );
  }

  _buildButtonBarMobile(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: TodoColors.azul))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildButtonBar(
               onTap: () =>
                Modular.to.navigate('${TarefasModule.novaTarefa}/'),
              label: 'Criar',
              icon: const Icon(
                FontAwesomeIcons.circlePlus,
                color: TodoColors.azul,
                size: 40,
              ),
            ),
            const Spacer(),
            _buildButtonBar(
              onTap: () {},
              label: 'Sair',
              icon: const Icon(
                TodoListIcons.logout,
                size: 32,
                color: TodoColors.azul,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildButtonBarWeb(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 60,
      decoration: const BoxDecoration(border: Border(right: BorderSide(color: TodoColors.azul))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildButtonBar(
              onTap: () =>
                Modular.to.navigate('${TarefasModule.novaTarefa}/'),
              label: 'Criar',
              icon: const Icon(
                FontAwesomeIcons.circlePlus,
                color: TodoColors.azul,
                size: 32,
              ),
            ),
            _buildButtonBar(
              onTap: () {},
              label: 'Sair',
              icon: const Icon(
                TodoListIcons.logout,
                color: TodoColors.azul,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtonBar({
    required Icon icon,
    Function? onTap,
    String? label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              if (onTap != null) onTap();
            },
            child: icon,
          ),
          const SizedBox(height: 4),
          Text(
            label ?? '',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: TodoColors.azul,
            ),
          ),
        ],
      ),
    );
  }
}
