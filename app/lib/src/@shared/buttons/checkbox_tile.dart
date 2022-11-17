import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/src/@shared/constants/todo_colors.dart';

class CheckboxTile extends StatefulWidget {
  final String label;
  final Function(bool)? onChanged;
  final bool value;

  const CheckboxTile({
    Key? key,
    required this.label,
    this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  State<CheckboxTile> createState() => _CheckboxTileState();
}

class _CheckboxTileState extends State<CheckboxTile> {
  late bool _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Material(
        color: TodoColors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            GFCheckbox(
              activeBgColor: TodoColors.verde,
              size: 20,
              type: GFCheckboxType.circle,
              onChanged: (value) {
                _value = value;
                if (widget.onChanged != null) widget.onChanged!(_value);
                setState(() {});
              },
              activeIcon: const Icon(Icons.check, size: 16, color: GFColors.WHITE),
              value: widget.value,
              inactiveIcon: null,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.label,
                maxLines: 2,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: TodoColors.preto,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
