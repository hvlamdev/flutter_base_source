import 'dart:io';

import 'package:base_source_flutter/core/base/base_exception.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

/// loading - show loading dialog
/// error - show error message with Dialog
/// idle - do nothing
/// success - show successfully message with SnackBar
enum ScreenState { idle, loading, error, success }

/// A class to handle dialog message
/// It can be used to show dialog with [message], [title], positive ([positiveButtonText], [onNegativeButtonTap])
/// and negative button ([negativeButtonText], [onPositiveButtonTap])
class DialogMessage extends Equatable {
  final String? message;
  final String? title;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final VoidCallback? onNegativeButtonTap;
  final VoidCallback? onPositiveButtonTap;

  const DialogMessage({
    this.message,
    this.title,
    this.positiveButtonText,
    this.negativeButtonText,
    this.onNegativeButtonTap,
    this.onPositiveButtonTap,
  });

  @override
  List<Object?> get props =>
      [message, title, positiveButtonText, negativeButtonText, onNegativeButtonTap, onPositiveButtonTap];
}

abstract class BaseProvider extends ChangeNotifier {
  /// The current state of the screen
  ScreenState state = ScreenState.idle;

  /// The dialog message to show when the state is [ScreenState.error] or [ScreenState.success]
  DialogMessage? dialogMessage;

  void setScreenState(
    ScreenState state, {
    String message = '',
    String title = '',
    VoidCallback? onNegativeTap,
    VoidCallback? onPositiveTap,
    String? positiveText,
    String? negativeText,
  }) {
    this.state = state;
    dialogMessage = DialogMessage(
      message: message,
      title: title,
      onNegativeButtonTap: onNegativeTap,
      onPositiveButtonTap: onPositiveTap,
      positiveButtonText: positiveText,
      negativeButtonText: negativeText,
    );
    notifyListeners();
  }

  void resetScreenState() {
    state = ScreenState.idle;
    dialogMessage = null;
    notifyListeners();
  }

  void handleException(
    dynamic e,
    ScreenState state, {
    String? message,
    String? title,
    VoidCallback? onNegativeTap,
    VoidCallback? onPositiveTap,
    String? positiveText,
    String? negativeText,
  }) {
    String dialogTitle = title ?? "Lỗi";
    String dialogMessage = message ?? 'Có lỗi xảy ra. Xin vui lòng thử lại sau.';

    if (e is Error) {
      developer.log("Error", error: e, stackTrace: e.stackTrace, time: DateTime.now());
    }

    if (e is Exception) {
      developer.log("Exception", error: e, time: DateTime.now());

      if (e is BaseException) {
        dialogMessage = e.message ?? dialogMessage;
      }

      if (e is DioException) {
        switch (e.type) {
          case DioExceptionType.connectionTimeout || DioExceptionType.receiveTimeout || DioExceptionType.sendTimeout:
            dialogTitle = 'Thời gian kết nối hết hạn';
            dialogMessage = 'Vui lòng thử lại sau.';
            break;
          case DioExceptionType.connectionError:
            if (e.error is SocketException) {
              dialogTitle = 'Không có kết nối internet';
              dialogMessage = 'Vui lòng kiểm tra kết nối internet của bạn và thử lại.';
            }
            break;
          case DioExceptionType.unknown:
          case DioExceptionType.badCertificate:
          case DioExceptionType.badResponse:
          case DioExceptionType.cancel:
        }
      }
    }
    setScreenState(
      state,
      message: dialogMessage,
      title: dialogTitle,
      onNegativeTap: onNegativeTap,
      onPositiveTap: onPositiveTap,
      positiveText: positiveText,
      negativeText: negativeText,
    );
  }
}
