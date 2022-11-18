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
  final String? buttonCenterText;
  final Function()? buttonCenterOnTap;
  final TodoDialogType? type;

  const ToDoDialog._(
    this.context, {
    Key? key,
    required this.title,
    required this.content,
    this.buttonLeftText,
    this.buttonRigthText,
    this.buttonLeftOnTap,
    this.buttonRigthOnTap,
    this.widget,
    this.buttonCenterText,
    this.buttonCenterOnTap,
    this.type = TodoDialogType.doubleButton,
  }) : super(key: key);

  factory ToDoDialog.doubleButton(
    BuildContext context, {
    required String title,
    required String content,
    String? buttonLeftText,
    String? buttonRigthText,
    Function()? buttonLeftOnTap,
    Function()? buttonRigthOnTap,
    Widget? widget,
  }) =>
      ToDoDialog._(
        context,
        title: title,
        content: content,
        buttonLeftText: buttonLeftText,
        buttonRigthText: buttonRigthText,
        buttonLeftOnTap: buttonLeftOnTap,
        buttonRigthOnTap: buttonRigthOnTap,
        widget: widget,
        type: TodoDialogType.doubleButton,
      );

  factory ToDoDialog.singleButton(
    BuildContext context, {
    required String title,
    required String content,
    String? buttonCenterText,
    Function()? buttonCenterOnTap,
    Widget? widget,
  }) =>
      ToDoDialog._(
        context,
        title: title,
        content: content,
        widget: widget,
        buttonCenterText: buttonCenterText,
        buttonCenterOnTap: buttonCenterOnTap,
        type: TodoDialogType.singleButton,
      );

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
                side: const BorderSide(color: TodoColors.azul, width: 2), borderRadius: BorderRadius.circular(10.0)),
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
                  type == TodoDialogType.doubleButton
                      ? IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                  child: InkWell(
                                    hoverColor: TodoColors.transparent,
                                    onTap: () {
                                      if (buttonLeftOnTap != null) buttonLeftOnTap!();
                                    },
                                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10)),
                                    overlayColor: MaterialStateProperty.all(TodoColors.azulClaro),
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
                              ),
                              const VerticalDivider(color: TodoColors.azul, width: 2),
                              Expanded(
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () {
                                      if (buttonRigthOnTap != null) buttonRigthOnTap!();
                                    },
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                    ),
                                    overlayColor: MaterialStateProperty.all(TodoColors.vermelhoSuave),
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
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            overlayColor: MaterialStateProperty.all(TodoColors.azulClaro),
                            onTap: () {
                              if (buttonCenterOnTap != null) buttonCenterOnTap!();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                buttonCenterText ?? 'Entendi',
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
            ),
          );
        });
  }
}

enum TodoDialogType { singleButton, doubleButton }
