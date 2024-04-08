import 'package:base_source_flutter/core/base/base_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({super.key});
}

abstract class BaseState<B extends BaseStatefulWidget> extends State<B> {
  bool _isShowDialog = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => startState());
  }

  /// Run after the UI has been rendered
  void startState() {}

  @override
  void dispose() {
    super.dispose();
  }

  void handleState({required BuildContext context, BaseProvider? provider}) {
    var dialogMessage = provider?.dialogMessage;
    switch (provider?.state) {
      case ScreenState.error:
        showAlertDialog(
          context: context,
          message: dialogMessage?.message ?? 'Có lỗi xảy ra, bạn có muốn thử lại không?',
          title: dialogMessage?.title,
          onNegativeButtonTap: dialogMessage?.onNegativeButtonTap,
          onPositiveButtonTap: dialogMessage?.onPositiveButtonTap,
          negativeText: dialogMessage?.negativeButtonText,
          positiveText: dialogMessage?.positiveButtonText,
          onResetState: () => provider?.resetScreenState(),
        );
        break;
      case ScreenState.success:
        showSnackBar(
          context,
          dialogMessage?.message ?? "No message provided",
          () => provider?.resetScreenState(),
          backgroundColor: Colors.green,
        );
        break;
      case ScreenState.loading:
        _showLoading();
        break;
      case ScreenState.idle:
        _hideLoading();
      default:
        break;
    }
  }

  void showSnackBar(BuildContext context, String? message, VoidCallback? handleAfterDisplaySnackBar,
      {Color? backgroundColor}) {
    if (message == null) return;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: backgroundColor,
          ),
        );
        handleAfterDisplaySnackBar?.call();
      },
    );
  }

  void showDialog({
    required BuildContext context,
    required String message,
    String? title,
    VoidCallback? onResetData,
  }) {
    if (_isShowDialog) return;
    _isShowDialog = true;
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title ?? ''),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text('OK', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            onPressed: () => context.pop(),
          ),
        ],
      ),
    ).then((value) {
      onResetData?.call();
      return _isShowDialog = false;
    });
  }

  void showAlertDialog({
    required BuildContext context,
    required String message,
    String? title,
    String? negativeText,
    String? positiveText,
    VoidCallback? onPositiveButtonTap,
    VoidCallback? onNegativeButtonTap,
    VoidCallback? onResetState,
  }) {
    if (_isShowDialog) return;
    _isShowDialog = true;
    List<Widget> actions = [];
    if (onNegativeButtonTap != null) {
      actions.add(CupertinoDialogAction(
        child: Text(negativeText ?? 'Bỏ qua'),
        onPressed: () {
          context.pop();
          onNegativeButtonTap();
        },
      ));
    }
    actions.add(CupertinoDialogAction(
      child: Text(positiveText ?? 'OK', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
      onPressed: () {
        context.pop();
        onPositiveButtonTap?.call();
      },
    ));

    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title ?? ''),
        content: Text(message),
        actions: actions,
      ),
    ).then((value) {
      onResetState?.call();
      return _isShowDialog = false;
    });
  }

  void _showLoading() {
    // TODO: show loading
  }

  void _hideLoading() {
    // TODO: hide loading
  }
}
