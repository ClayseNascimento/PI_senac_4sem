import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/src/@shared/constants/todo_colors.dart';

class ToDoDialog extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String content;
  final String? buttonLeftText;
  final String? buttonRigthText;
  final Function()? buttonLeftOnTap;
  final Function()? buttonRigthOnTap;
  final Widget? widget;

  const ToDoDialog({
    Key? key,
    required this.context,
    required this.title,
    required this.content,
    this.buttonLeftText,
    this.buttonRigthText,
    this.buttonLeftOnTap,
    this.buttonRigthOnTap,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  show() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: TodoColors.azul, width: 2),
                borderRadius: BorderRadius.circular(10.0)), //this right here
            child: SizedBox(
              width: double.minPositive,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: TodoColors.vermelho,
                          decoration: TextDecoration.none,
                          shadows: [
                            const Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 1.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    color: TodoColors.azul,
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      content,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: TodoColors.preto,
                        decoration: TextDecoration.none,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(widget != null ? 16.0 : 0),
                    child: widget ?? const SizedBox.shrink(),
                  ),
                  const Divider(color: TodoColors.azul, height: 2),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (buttonLeftOnTap != null) buttonLeftOnTap!();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                buttonLeftText ?? 'Sim',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: TodoColors.preto,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                          child: VerticalDivider(color: TodoColors.azul, width: 2),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (buttonRigthOnTap != null) buttonRigthOnTap!();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                buttonRigthText ?? 'Não',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: TodoColors.preto,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
