import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/src/@shared/constants/todo_colors.dart';
import 'package:todolist/src/presentation/home/home_module.dart';

class Navbar extends StatelessWidget {
  final String title;
  final bool? showBackButton;

  const Navbar({
    Key? key,
    required this.title,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          alignment: Alignment.topCenter,
          constraints: const BoxConstraints(maxHeight: 72, minHeight: 50),
          decoration: BoxDecoration(
            color: TodoColors.azul,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF979797).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(3, 3),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: showBackButton!,
              child: _buildBackButton(context),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  style: GoogleFonts.pacifico(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: TodoColors.branco,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Material(
          elevation: 0,
          shape: const CircleBorder(),
          color: TodoColors.branco,
          child: InkWell(
            onTap: () => Modular.to.navigate(HomeModule.home),
            customBorder: const CircleBorder(),
            borderRadius: BorderRadius.circular(10),
            child: const Icon(
              Icons.arrow_back,
              color: TodoColors.azul,
            ),
          ),
        ),
      ),
    );
  }
}
