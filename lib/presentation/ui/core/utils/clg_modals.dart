import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CLGModals {
  Future<dynamic> showBottomSheet(BuildContext context, String title, Widget body) {
    return showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.4,
            margin: EdgeInsets.only(
              top: ui.window.viewPadding.top / ui.window.devicePixelRatio,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(0.0),
                topLeft: Radius.circular(0.0),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: body,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> showBottomSheetClose(BuildContext context, String title, Widget body) {
    return showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return ClipRect(
          child: Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.4,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              height: 50.0,
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: CLGText(
                          title,
                          style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),
                        )),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const CLGIcon(
                              path: CLGIcons.close,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: body,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
