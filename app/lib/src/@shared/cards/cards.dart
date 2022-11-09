import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/src/@shared/constants/todo_colors.dart';

class Cards extends StatefulWidget {
  final String title;
  final String subtitle;
  final String percentageProgress;
  final double? height;

  const Cards({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.percentageProgress,
    this.height = 300,
  }) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      alignment: Alignment.bottomCenter,
      decoration:
          BoxDecoration(border: Border.all(width: 2, color: TodoColors.azul), borderRadius: BorderRadius.circular(15)),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: TodoColors.azul,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: TodoColors.azul,
                  decoration: TextDecoration.none,
                ),
              ),
              Column(
                children: [
                  Text(
                    '${(double.parse(widget.percentageProgress) * 100).toString()}%',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: TodoColors.azul,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 4),
                  GFProgressBar(
                    lineHeight: 12.0,
                    percentage: double.parse(widget.percentageProgress),
                    backgroundColor: TodoColors.cinza,
                    progressBarColor: TodoColors.verde,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
