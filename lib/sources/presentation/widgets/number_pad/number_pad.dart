import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

enum NumericPadType { otp, login }

class NumericPad extends StatelessWidget {
  final Function(int) onNumberSelected;
  final NumericPadType numPadType;

  const NumericPad({
    super.key,
    required this.onNumberSelected,
    required this.numPadType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildNumber(context, 1),
              buildNumber(context, 2),
              buildNumber(context, 3),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildNumber(context, 4),
              buildNumber(context, 5),
              buildNumber(context, 6),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildNumber(context, 7),
              buildNumber(context, 8),
              buildNumber(context, 9),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (numPadType == NumericPadType.login) ...[
                ClearKeyPadView(onTouchInside: () {
                  onNumberSelected(-1);
                }),
                buildNumber(context, 0),
                DoneKeyPadView(
                  onTouchInside: () {
                    onNumberSelected(-2);
                  },
                ),
              ] else ...[
                buildEmptySpace(),
                buildNumber(context, 0),
                ClearKeyPadView(onTouchInside: () {
                  onNumberSelected(-1);
                }),
              ]
            ],
          ),
        ),
      ],
    );
  }

  Widget buildNumber(BuildContext context, int number) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onNumberSelected(number);
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSize.cornerRadiusSmall),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmptySpace() {
    return Expanded(
      child: Container(),
    );
  }
}

class DoneKeyPadView extends StatelessWidget {
  const DoneKeyPadView({super.key, required this.onTouchInside});

  final VoidCallback onTouchInside;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTouchInside();
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSize.cornerRadiusSmall),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).shadowColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_right_alt_outlined,
                size: AppSize.iconHeight * 2,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ClearKeyPadView extends StatelessWidget {
  const ClearKeyPadView({super.key, required this.onTouchInside});

  final VoidCallback onTouchInside;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTouchInside();
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSize.cornerRadiusSmall),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).shadowColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.backspace_outlined,
                size: AppSize.iconHeight * 1.75,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NumberKey extends StatefulWidget {
  const NumberKey({super.key, required this.keyboardNumber});
  final String keyboardNumber;

  @override
  State<NumberKey> createState() => _NumberKeyState();
}

class _NumberKeyState extends State<NumberKey> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: SizedBox(
        width: AppSize.buttonHeight,
        height: AppSize.buttonHeight,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).bottomSheetTheme.backgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSize.cornerRadius * 0.5),
            ),
            border: Border.all(
              color: Theme.of(context).indicatorColor,
              width: 1.0,
            ),
          ),
          child: Center(
            child:
                Text(widget.keyboardNumber, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black)),
          ),
        ),
      ),
    );
  }
}

class NumberKey2 extends StatefulWidget {
  NumberKey2({
    super.key,
    this.focusNode,
    this.obscureText = false,
    this.cornerRadius = 4,
    editingController,
    this.onChanged,
    this.enabled,
  }) : editingController = editingController ?? TextEditingController();

  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool obscureText;
  final double cornerRadius;
  final TextEditingController editingController;
  final bool? enabled;
  @override
  State<NumberKey2> createState() => _NumberKey2State();
}

class _NumberKey2State extends State<NumberKey2> {
  @override
  void dispose() {
    widget.editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        autofocus: true,
        enabled: widget.enabled,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center, // Align vertically
        cursorColor: theme.dividerColor,
        controller: widget.editingController,
        keyboardType: TextInputType.number,
        obscureText: widget.obscureText,
        maxLength: 1,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          filled: false,
          fillColor: const Color(0xFF623F98),
          hintStyle: theme.textTheme.bodyLarge,
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.primaryColor),
            borderRadius: BorderRadius.circular(widget.cornerRadius),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.disabledColor),
            borderRadius: BorderRadius.circular(widget.cornerRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.primaryColor),
            borderRadius: BorderRadius.circular(widget.cornerRadius),
          ),
          contentPadding: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}
