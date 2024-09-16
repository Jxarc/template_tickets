import 'package:flutter/material.dart';

class CLGTheme {
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Flutter Theme Properties
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  final Brightness brightness;
  final MaterialColor background;
  final MaterialColor shadowColor;
  final Color errorColor;
  final Color dividerColor;
  final Color disabledColor;

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Custom UIKit Properties
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  //General colors for package and Design System
  final Color white;
  final Color black;

  final MaterialColor primary;
  final MaterialColor secondary;
  final MaterialColor tertiary;
  final MaterialColor magenta;
  final MaterialColor gray;
  final MaterialColor lila;
  final MaterialColor blue;
  final MaterialColor green;
  final MaterialColor cream;

  final Color colegiumBlue;
  final Color danger;
  final Color success;
  final Color warning;
  final Color redBallon;

  final Color textColor;
  final Color buttonTextColor;
  final Color cardColor;
  final Color attachmentTextColor;
  final Color listHeaderTextColor;
  final Color borderColor;
  final Color skeletonColor;
  final Color refreshIconColor;

  //Attributes for CLGActionTextField
  final Color actionTextFieldPrimaryColor;
  final Color actionTextFieldOnPrimaryColor;
  final Color actionTextFieldBackgroundColor;
  final Color actionTextFieldTextColor;
  final Color actionTextFieldHintColor;
  final Color actionTextFieldErrorColor;
  final Color actionTextFieldShadowColor;
  final Color actionTextFieldDisabledColor;

  //Attributes for CLGAppBar
  final Color appBarBackgroundColor;
  final Color appBarTextColor;

  //Attributes for CLGCalendar
  final Color calendarTextColor;
  final Color calendarActiveTextColor;
  final Color calendarActiveColor;
  final Color calendarOnActiveColor;
  final Color calendarDisabledColor;

  //Attributes for CLGCircleAvatar
  final Color avatarPrimaryColor;
  final Color avatarOnPrimaryColor;

  //Attributes for CLGCharts
  final Color chartPrimaryColor;
  final Color chartBackgroundColor;
  final Color chartTitleColor;
  final Color chartSubtitleColor;
  final Color chartLabelColor;

  //Attributes for CLGCheckBox
  final Color checkBoxActiveColor;
  final Color checkBoxOnActiveColor;
  final Color checkBoxInactiveColor;
  final Color checkBoxDisabledColor;

  //Attributes for CLGCheckBox
  final Color radioActiveColor;
  final Color radioActiveBorderColor;
  final Color radioOnActiveColor;
  final Color radioInactiveColor;
  final Color radioInactiveBorderColor;
  final Color radioDisabledColor;

  //Attributes for CLGDataTable
  final Color dataTableTitleColor;
  final Color dataTableHeadColor;
  final Color dataTableHeadActiveColor;
  final Color dataTableBorderColor;

  //Attributes for CLGDialog
  final Color dialogBackgroundColor;
  final Color dialogDescriptionColor;

  //Attributes for CLGDropdown
  final Color dropDownBackgroundColor;
  final Color dropDownTextColor;

  //Attributes for CLGEditorTextField
  final Color editorPrimaryColor;
  final Color editorOnPrimaryColor;
  final Color editorBackgroundColor;
  final Color editorOnBackgroundColor;
  final Color editorToolbarColor;
  final Color editorActionColor;
  final Color editorIconColor;

  //Attributes for CLGFloatingActionButton
  final Color floatingActionButtonOnPrimary;

  //Attributes for CLGImage
  final Color imagePickerActionColor;
  final Color imageErrorTextColor;

  //Attributes for CLGLogin
  final Color loginPrimaryColor;
  final Color loginOnPrimaryColor;
  final Color loginBackgroundColor;
  final Color loginFilterColor;
  final Color loginTextColor;
  final Color loginTitleColor;
  final Color loginSubtitleColor;
  final Color loginforgotPasswordColor;
  final Color loginSomethingWrongColor;

  //Attributes for CLGPickerList
  final Color pickerListPrimaryColor;
  final Color pickerListOnPrimaryColor;
  final Color pickerListBackgroundColor;
  final Color pickerListTitleColor;
  final Color pickerListSubtitleColor;
  final Color pickerListDescriptionColor;

  //Attributes for CLGRecordAudio
  final Color recordAudioPrimary;
  final Color recordAudioOnPrimary;
  final Color recordAudioBackgroundColor;
  final Color recordAudioActionsBackgroundColor;
  final Color recordAudioIconDelete;
  final Color recordAudioIconLock;

  //Attributes for CLGSearchTextField
  final Color searchTextFieldPrimaryColor;
  final Color searchTextFieldBackgroundColor;
  final Color searchTextFieldTextColor;
  final Color searchTextFieldHintColor;
  final Color searchTextFieldDisabledColor;

  //Attributes for CLGSegmentControl
  final Color segmentControlPrimaryColor;
  final Color segmentControlOnPrimaryColor;
  final Color segmentControlBackgroundColor;
  final Color segmentControlTextColor;

  //Attribues for CLGSlider
  final Color sliderPrimaryColor;
  final Color sliderOnPrimaryColor;
  final Color sliderThumbColor;

  //Attributes for CLGSocialButton
  final Color socialButtonBorderColor;
  final Color socialButtonTextColor;

  //Attributes for CLGSwitch
  final Color switchActiveColor;
  final Color switchInactiveColor;
  final Color switchDisabledColor;

  //Attributes for CLGTab and CLGTabs
  final Color tabPrimaryColor;
  final Color tabOnPrimaryColor;
  final Color tabBackgroundColor;
  final Color tabTextColor;

  //Attribues for CLGTapTarget
  final Color tapTargetPrimaryColor;
  final Color tapTargetOnPrimaryColor;

  //Attributes for CLGTextField
  final Color textFieldPrimaryColor;
  final Color textFieldOnPrimaryColor;
  final Color textFieldBackgroundColor;
  final Color textFieldTextColor;
  final Color textFieldHintColor;
  final Color textFieldErrorColor;
  final Color textFieldShadowColor;
  final Color textFieldDisabledColor;

  //Attributes for CLGEditorMultimedia
  final Color editorMultimediaActionCancelBackgroundColor;
  final Color editorMultimediaActionCancelColor;
  final Color editorMultimediaActionConfirmBackgroundColor;
  final Color editorMultimediaActionConfirmColor;
  final Color editorMultimediaActionsBarColor;
  final Color editorMultimediaBackgroundColor;
  final Color editorMultimediaTimeColor;

  CLGTheme({
    this.brightness = Brightness.light,
    this.shadowColor = const MaterialColor(0xFFD6D6D6, {
      100: Color(0xFFEFEFF5),
      200: Color(0xFFD2D2DF),
      300: Color(0xFFD6D6D6),
      400: Color(0xFF9393A6),
    }),
    this.errorColor = const Color(0xFFB3261E),
    this.dividerColor = const Color(0xfff6f6f6),
    this.disabledColor = const Color.fromARGB(255, 225, 226, 233),
    this.white = Colors.white,
    this.black = const Color(0xFF212121),
    this.background = const MaterialColor(0xFFFBFAFF, {
      50: Color(0xFFe8e8e8),
      100: Color(0xFFebebeb),
      200: Color(0xFFededed),
      300: Color(0xFFf0f0f0),
      400: Color(0xFFf2f2f2),
      500: Color(0xFFf5f5f5),
      600: Color(0xFFFBFAFF),
      700: Color(0xffffffff),
      800: Color(0xffffffff),
      900: Color(0xffffffff),
    }),
    this.primary = const MaterialColor(0xff237CE1, {
      50: Color(0xFFF9FBFD),
      100: Color(0xFFEDF4FD),
      200: Color(0xFFB6D3F5),
      300: Color(0xFF6CA8EB),
      400: Color(0xFF4892E6),
      500: Color(0xff237CE1),
      600: Color(0xFF15549C),
      700: Color(0xFF124989),
      800: Color(0xFF124989),
      900: Color(0xFF124989),
    }),
    this.secondary = const MaterialColor(0xFFFF7F09, {
      100: Color(0xFFFFEFE0),
      200: Color(0xFFFFCFA3),
      300: Color(0xFFFFBF84),
      400: Color(0xFFFFAF65),
      500: Color(0xffFF9F47),
      600: Color(0xFFFF7F09),
      700: Color(0xFFE76F00),
      800: Color(0xFFE76F00),
      900: Color(0xFFE76F00),
    }),
    this.tertiary = const MaterialColor(0xFF9CDD50, {
      100: Color(0xFFF3FBE9),
      200: Color(0xFFE6F6D3),
      300: Color(0xFFCEEEA8),
      400: Color(0xFFC1EA92),
      500: Color(0xffB5E67C),
      600: Color(0xFF9CDD50),
      700: Color(0xFF77BD25),
      800: Color(0xFF77BD25),
      900: Color(0xFF77BD25),
    }),
    this.magenta = const MaterialColor(0xFFFF2D6D, {
      100: Color(0xFFFFE7EE),
      200: Color(0xFFFFCFDE),
      300: Color(0xFFFFB6CC),
      400: Color(0xFFFF8EB0),
      500: Color(0xffFF5D8E),
      600: Color(0xFFFF2D6D),
      700: Color(0xFFD9134F),
    }),
    this.blue = const MaterialColor(0xFF3365F6, {
      100: Color(0xFFE2E9FE),
      200: Color(0xFFA8BDFB),
      300: Color(0xFF8AA7FA),
      400: Color(0xFF6D91F9),
      500: Color(0xff507BF8),
      600: Color(0xFF3365F6),
      700: Color(0xFF0833B2),
    }),
    this.lila = const MaterialColor(0xFFA596CF, {
      100: Color(0xFFF3EFFF),
      200: Color(0xFFDFD9F2),
      300: Color(0xFFC7BEE1),
      400: Color(0xFFBCB1DB),
      500: Color(0xffB0A4D5),
      600: Color(0xFFA596CF),
      700: Color(0xFF9989C9),
    }),
    this.green = const MaterialColor(0xFF439238, {
      100: Color(0xFFEAF3EC),
      200: Color(0xFFE1F1E0),
      300: Color(0xFFC1E2C2),
      400: Color(0xFF82C486),
      500: Color(0xff67B761),
      600: Color(0xFF439238),
      700: Color(0xFF3C6D3E),
    }),
    this.cream = const MaterialColor(0xFFFDDB8A, {
      100: Color(0xFFFFF9EA),
      200: Color(0xFFFEF3D7),
      300: Color(0xFFFEEDC3),
      400: Color(0xFFFDE7B0),
      500: Color(0xffFDE19D),
      600: Color(0xFFFDDB8A),
      700: Color(0xFFFCD577),
    }),
    this.gray = const MaterialColor(0xFF9393A6, {
      100: Color(0xFFEFEFF5),
      200: Color(0xFFD2D2DF),
      300: Color(0xFF9393A6),
      400: Color(0xFF505068),
    }),
    this.redBallon = const Color(0xffFF3B30),
    this.success = const Color(0xff71D875),
    this.danger = const Color(0xffFF5454),
    this.warning = const Color(0xffFFCF54),
    this.colegiumBlue = const Color(0xff1E2A50),
    Color? appBarBackgroundColor,
    Color? appBarTextColor,
  })  : textColor = black,
        buttonTextColor = white,
        cardColor = background.shade700,
        attachmentTextColor = gray.shade400,
        listHeaderTextColor = black,
        borderColor = shadowColor.shade200,
        skeletonColor = gray.shade200,
        refreshIconColor = white,
        //
        actionTextFieldPrimaryColor = primary.shade200,
        actionTextFieldOnPrimaryColor = white,
        actionTextFieldBackgroundColor = background.shade700,
        actionTextFieldTextColor = black,
        actionTextFieldHintColor = gray.shade200,
        actionTextFieldErrorColor = danger,
        actionTextFieldShadowColor = gray.shade100,
        actionTextFieldDisabledColor = disabledColor,
        //
        appBarBackgroundColor = appBarBackgroundColor ?? background.shade700,
        appBarTextColor = appBarTextColor ?? black,
        //
        calendarTextColor = black,
        calendarActiveTextColor = primary,
        calendarActiveColor = primary,
        calendarOnActiveColor = white,
        calendarDisabledColor = gray.shade200,
        //
        avatarPrimaryColor = primary,
        avatarOnPrimaryColor = white,
        //
        chartPrimaryColor = primary.shade600,
        chartBackgroundColor = background.shade700,
        chartTitleColor = gray.shade400,
        chartSubtitleColor = gray.shade300,
        chartLabelColor = gray.shade400,
        //
        checkBoxActiveColor = primary.shade600,
        checkBoxOnActiveColor = white,
        checkBoxInactiveColor = white,
        checkBoxDisabledColor = black,
        //
        radioActiveColor = primary.shade600,
        radioActiveBorderColor = primary.shade100,
        radioInactiveColor = background.shade700,
        radioInactiveBorderColor = shadowColor.shade100,
        radioOnActiveColor = white,
        radioDisabledColor = gray.shade200,
        //
        dataTableTitleColor = black,
        dataTableHeadColor = Colors.transparent,
        dataTableHeadActiveColor = Colors.transparent,
        dataTableBorderColor = shadowColor.shade100,
        //
        dialogBackgroundColor = background.shade700,
        dialogDescriptionColor = gray.shade400,
        //
        dropDownBackgroundColor = background.shade700,
        dropDownTextColor = gray.shade400,
        //
        editorPrimaryColor = primary.shade600,
        editorOnPrimaryColor = white,
        editorBackgroundColor = background.shade700,
        editorOnBackgroundColor = black,
        editorToolbarColor = primary.shade100,
        editorActionColor = white,
        editorIconColor = gray.shade200,
        //
        floatingActionButtonOnPrimary = white,
        //
        imagePickerActionColor = white,
        imageErrorTextColor = danger,
        //
        loginPrimaryColor = primary,
        loginOnPrimaryColor = white,
        loginBackgroundColor = background.shade700,
        loginFilterColor = Colors.transparent,
        loginTextColor = black,
        loginTitleColor = black,
        loginSubtitleColor = black,
        loginforgotPasswordColor = primary,
        loginSomethingWrongColor = primary,
        //
        pickerListPrimaryColor = primary,
        pickerListOnPrimaryColor = black,
        pickerListBackgroundColor = background.shade700,
        pickerListTitleColor = black,
        pickerListSubtitleColor = gray.shade400,
        pickerListDescriptionColor = black,
        //
        recordAudioPrimary = primary,
        recordAudioOnPrimary = white,
        recordAudioBackgroundColor = background.shade700,
        recordAudioActionsBackgroundColor = gray.shade100,
        recordAudioIconDelete = const Color(0xffFEC3D5),
        recordAudioIconLock = gray.shade100,
        //
        searchTextFieldPrimaryColor = primary,
        searchTextFieldBackgroundColor = gray.shade100,
        searchTextFieldTextColor = black,
        searchTextFieldHintColor = gray.shade400,
        searchTextFieldDisabledColor = gray.shade300,
        //
        segmentControlPrimaryColor = primary,
        segmentControlOnPrimaryColor = white,
        segmentControlBackgroundColor = shadowColor.shade100,
        segmentControlTextColor = gray.shade300,
        //
        sliderPrimaryColor = primary,
        sliderOnPrimaryColor = white,
        sliderThumbColor = white,

        //
        socialButtonTextColor = gray.shade300,
        socialButtonBorderColor = shadowColor.shade100,
        //
        switchActiveColor = primary,
        switchInactiveColor = black,
        switchDisabledColor = black,
        //
        tabPrimaryColor = primary,
        tabOnPrimaryColor = white,
        tabBackgroundColor = background.shade700,
        tabTextColor = black,
        //
        tapTargetPrimaryColor = primary,
        tapTargetOnPrimaryColor = white,
        //
        textFieldPrimaryColor = primary,
        textFieldOnPrimaryColor = white,
        textFieldBackgroundColor = background.shade700,
        textFieldTextColor = black,
        textFieldHintColor = gray.shade400,
        textFieldErrorColor = magenta,
        textFieldShadowColor = shadowColor,
        textFieldDisabledColor = disabledColor,
        //
        editorMultimediaBackgroundColor = primary.shade600,
        editorMultimediaTimeColor = white,
        editorMultimediaActionsBarColor = white,
        editorMultimediaActionConfirmColor = primary.shade600,
        editorMultimediaActionConfirmBackgroundColor = const Color(0xffE3EFFB),
        editorMultimediaActionCancelColor = magenta,
        editorMultimediaActionCancelBackgroundColor = const Color(0xffFAE0EB);
}
