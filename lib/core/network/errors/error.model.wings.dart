import 'package:flutter/material.dart';
import 'package:gogreen/core/logger.dart';
import '../../constants/app_images.dart';
import 'error.enum.dart';
import 'exeption.dart';

class ErrorModel {
  String message;
  String desc;
  Color borderColor;
  Color backgroundColor;
  String icon ;
  bool hideRetry;

  ErrorModel({
    this.message = '',
    this.desc = '',
    this.borderColor = const Color(0xffFF434F),
    this.backgroundColor = const Color(0xffFEE8E9),
    this.icon = '',
    this.hideRetry = false,
  });

  factory ErrorModel.empty() {
    return ErrorModel();
  }

  static ErrorModel fromCode(
    String code,
    int statusCode, {
    String? message,
    dynamic desc,
  }) {
    wingsLogger.logError(
        "ErrorModel.fromCode: code: $code, statusCode: $statusCode, message: $message, desc: $desc");


    if (ErrorEnum.errorCodes.contains(code)) {
      var tempDesc;
      if (desc != null) {
        tempDesc =
            desc.runtimeType == List ? desc.toString() : desc.values.toString();
        tempDesc = tempDesc.replaceAll('(', "");
        tempDesc = tempDesc.replaceAll(')', "");
        tempDesc = tempDesc.replaceAll('[', "");
        tempDesc = tempDesc.replaceAll(']', "");
      }

      return ErrorModel(
        message: message ?? "Something went wrong",
        desc: tempDesc ?? "Please try again",
        icon: AppImages.errorNetwork,
      );
    }

    return ErrorModel(
      message: MessageOfErorrApi.getExeptionMessage(statusCode).first,
      desc: MessageOfErorrApi.getExeptionMessage(statusCode).last,
      icon: AppImages.errorNetwork,
    );
  }
}
