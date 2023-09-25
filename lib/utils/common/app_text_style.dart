import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';

import 'app_font.dart';

ButtonStyle getButtonStyle(context) => ElevatedButton.styleFrom(
      primary: Color(0xff4889FD),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    );
ButtonStyle AppointmentbuttonStyle(context) => ElevatedButton.styleFrom(
      primary: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    );
ButtonStyle CancelbuttonStyle(context) => ElevatedButton.styleFrom(
      primary: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
      ),
    );

TextStyle TextHeadingStyle(context) => (TextStyle(
    fontWeight: AppFont.fontWeightMedium,
    color: Color(0xff4889fd),
    fontSize: 25));
TextStyle TextParaStyle(context) => (TextStyle(
      fontWeight: AppFont.fontWeightRegular,
      fontSize: 15,
      color: Colors.black54,
    ));
TextStyle TextButtonStyle(context) =>
    (TextStyle(fontSize: 20, color: Colors.white));
TextStyle TextCancelButtonStyle(context) =>
    (TextStyle(fontSize: 20, color: Color(0xffFF6464)));
TextStyle TextFieldStyle(context) => (TextStyle(
    fontSize: 20, color: Colors.grey, fontWeight: AppFont.fontWeightMedium));
TextStyle TextResendStyle(context) => (TextStyle(
    fontSize: 16,
    fontWeight: AppFont.fontWeightMedium,
    color: Color(0xff4889FD)));
TextStyle TextMainHeading(context) => (TextStyle(
    fontWeight: AppFont.fontWeightMedium, fontSize: 25, color: Colors.white));
TextStyle TextMainsubtitle(context) => (TextStyle(
    color: Color(0xff5B5B5B),
    fontSize: 25,
    fontWeight: AppFont.fontWeightBold));
TextStyle TextForgetStyle(context) =>
    (const TextStyle(color: Colors.grey, fontSize: 15));
TextStyle RichtextStyle(context) =>
    (TextStyle(color: Theme.of(context).backgroundColor, fontSize: 15));
TextStyle NameStyle(context) => (TextStyle(
    fontWeight: AppFont.fontWeightRegular,
    fontSize: 22,
    color: Color(0xffF6F6F6)));
TextStyle SpecialistStyle(context) => (TextStyle(
    fontWeight: AppFont.fontWeightRegular,
    fontSize: 13,
    color: Color(0xffF6F6F6)));
TextStyle ExpStyle(context) => (TextStyle(
    fontWeight: AppFont.fontWeightExtraBold,
    fontSize: 13,
    color: Color(0xffF6F6F6)));
TextStyle BiographyStyle(context) => (TextStyle(
    fontWeight: AppFont.fontWeightBold,
    fontSize: 15,
    color: Color(0xff4889FD)));
TextStyle BioParaStyle(context) =>
    (TextStyle(fontWeight: AppFont.fontWeightMedium, fontSize: 13));
TextStyle DateTitleStyle(context) => (TextStyle(
      fontWeight: AppFont.fontWeightRegular,
      fontSize: 22,
    ));
TextStyle monthStyle(context) =>
    (TextStyle(fontWeight: AppFont.fontWeightRegular, fontSize: 14));
TextStyle PrescriptionSpecialist(context) => (TextStyle(
    fontWeight: AppFont.fontWeightRegular,
    fontSize: 14,
    color: Color(0xff6B779A)));
TextStyle TimeStyle(context) =>
    (TextStyle(fontWeight: AppFont.fontWeightRegular, fontSize: 13));
TextStyle DateContainerStyle(context) => (TextStyle(
    fontWeight: AppFont.fontWeightSemiBold,
    fontSize: 14,
    color: Colors.black.withOpacity(0.5)));
TextStyle DateContainer1Style(context) => (TextStyle(
    fontWeight: AppFont.fontWeightMedium,
    fontSize: 14,
    color: Theme.of(context).primaryColorLight));
TextStyle AddressStyle(context) => (TextStyle(
    fontWeight: AppFont.fontWeightRegular,
    fontSize: 15,
    color: Colors.black.withOpacity(0.7)));
TextStyle AttentionStyle(context) => (TextStyle(
    fontWeight: AppFont.fontWeightRegular,
    fontSize: 17,
    color: Theme.of(context).primaryColor));
TextStyle GetdirectionStyle(context) => (TextStyle(
    fontWeight: AppFont.fontWeightRegular,
    fontSize: 14,
    color: Color(0xff4889FD)));
TextStyle ViewMoreStyle(context) => (TextStyle(
    fontWeight: AppFont.fontWeightSemiBold, fontSize: 15, color: Colors.white));
TextStyle Dr_nameinMy_doctor(context) => (TextStyle(
    fontWeight: AppFont.fontWeightSemiBold, fontSize: 25, color: Colors.black));
TextStyle SpecialistStylenew(context) => (TextStyle(
    fontWeight: AppFont.fontWeightRegular, fontSize: 17, color: Colors.grey));
TextStyle ProfileStyle(context) =>
    (TextStyle(fontWeight: FontWeight.w700, fontSize: 29, color: Colors.white));
TextStyle PrescriptionStyle(context) =>
    (TextStyle(fontWeight: FontWeight.w300, fontSize: 28));
TextStyle DoctorByName(context) =>
    (TextStyle(fontWeight: FontWeight.w300, fontSize: 20));
TextStyle GoodmornTitle(context) =>
    (TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white));
TextStyle Tempstyle(context) =>
    (TextStyle(fontWeight: FontWeight.w900, fontSize: 30));
TextStyle Fahrenheitestyle(context) =>
    (TextStyle(fontWeight: FontWeight.w900, fontSize: 20));
TextStyle Heartbeatstyle(context) => (TextStyle(
    fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff102A43)));
TextStyle Bpmstyle(context) =>
    (TextStyle(fontWeight: FontWeight.w400, fontSize: 17));
TextStyle YoudailyMedicationstyle(context) => (TextStyle(
    fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xff486581)));
TextStyle bloodpressureTimestyle(context) => (TextStyle(
    fontWeight: FontWeight.w400, fontSize: 17, color: Color(0xff486581)));
TextStyle bloodpressureTitlestyle(context) => (TextStyle(
    fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xff102A43)));
TextStyle healthRecordstyle(context) => (TextStyle(
    fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xff102A43)));
