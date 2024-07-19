import 'package:flutter/material.dart';

enum DialogClick { positive, negative }

typedef OnDialogButtonClickListener = void Function(DialogClick click);

class DialogUtils {
  static void showCustomDialog(context,
      {title, message, positiveText = "Ok", negativeText = "", required OnDialogButtonClickListener listener}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        title,
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
                      )),
                  message.toString().isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Text(
                            message,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
                          )),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      negativeText.toString().isEmpty
                          ? Container()
                          : TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                listener(DialogClick.negative);
                              },
                              child: Text(
                                negativeText,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
                              ),
                            ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          listener(DialogClick.positive);
                        },
                        child: Text(
                          positiveText,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
