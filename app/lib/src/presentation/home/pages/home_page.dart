import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/src/@shared/bars/buttons_bar.dart';
import 'package:todolist/src/@shared/bars/navbar.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:todolist/src/@shared/constants/todo_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final widthIsNotLarge = widthScreen <= 992;

    return Flex(
      direction: Axis.vertical,
      children: [
        const Navbar(title: 'To do List'),
        Expanded(
          child: widthIsNotLarge ? _buildBodyMobile(context) : _buildBodyWeb(context),
        ),
      ],
    );
  }

  _buildCenter() {
    return BootstrapCol(
      sizes: 'col-12' '.col-xs-3' '.col-sm-6',
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Olá, Marina.',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: TodoColors.azul,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 60),
            BootstrapCol(
              sizes: 'col-12 col-sm-6 col-xs-1',
              child: SvgPicture.asset(
                'assets/images/empty.svg',
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Você não possui tarefas.',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: TodoColors.azul,
                decoration: TextDecoration.none,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBodyWeb(BuildContext context) {
    return Row(
      children: [
        const ButtonsBar(),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height - 72,
            child: _buildCenter(),
          ),
        ),
      ],
    );
  }

  _buildBodyMobile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildCenter(),
        const ButtonsBar(),
      ],
    );
  }
}
