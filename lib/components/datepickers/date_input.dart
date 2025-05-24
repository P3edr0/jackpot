import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jackpot/theme/colors.dart';

class JackDateInput extends StatefulWidget {
  const JackDateInput(
      {super.key,
      required this.dayController,
      required this.monthController,
      required this.yearController});
  final TextEditingController dayController;
  final TextEditingController monthController;
  final TextEditingController yearController;

  @override
  JackDateInputState createState() => JackDateInputState();
}

class JackDateInputState extends State<JackDateInput> {
  final _focusDay = FocusNode();
  final _focusMonth = FocusNode();
  final _focusYear = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.dayController.addListener(() {
      if (widget.dayController.text.length == 2) _focusMonth.requestFocus();
    });
    widget.monthController.addListener(() {
      if (widget.monthController.text.length == 2) _focusYear.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: primaryFocusColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildField(widget.dayController, _focusDay, 'Dia', 2),
          const SizedBox(width: 8),
          _buildField(widget.monthController, _focusMonth, 'Mês', 2),
          const SizedBox(width: 8),
          _buildField(widget.yearController, _focusYear, 'Ano', 4),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate:
                    DateTime.now().subtract(const Duration(days: 365 * 18)),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              ).then((dt) {
                if (dt != null) {
                  widget.dayController.text = dt.day.toString().padLeft(2, '0');
                  widget.monthController.text =
                      dt.month.toString().padLeft(2, '0');
                  widget.yearController.text = dt.year.toString();
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildField(
      TextEditingController ctrl, FocusNode focus, String hint, int maxLen) {
    return SizedBox(
      width: maxLen == 4 ? 64 : 40,
      child: TextFormField(
        controller: ctrl,
        focusNode: focus,
        decoration: InputDecoration(hintText: hint),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(maxLen),
        ],
      ),
    );
  }
}
