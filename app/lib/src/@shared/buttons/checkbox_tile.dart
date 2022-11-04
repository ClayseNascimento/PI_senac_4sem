import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/src/@shared/constants/todo_colors.dart';

class CheckboxTile extends StatefulWidget {
  final String label;

  const CheckboxTile({
    Key? key, required this.label,
  }) : super(key: key);

  @override
  State<CheckboxTile> createState() => _CheckboxTileState();
}

class _CheckboxTileState extends State<CheckboxTile> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Material(
        child: Row(
          children: [
            GFCheckbox(
              activeBgColor: TodoColors.verde,
              size: 22,
              type: GFCheckboxType.circle,
              onChanged: (value) {
                setState(() {
                  isChecked = value;
                });
              },
              value: isChecked,
              inactiveIcon: null,
            ),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: TodoColors.preto,
              ),
            )
          ],
        ),
      );
    });

  }
}
