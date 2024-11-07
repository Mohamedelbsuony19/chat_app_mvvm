import 'package:flutter/material.dart';

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {
  N? navigator;
}

abstract class BaseNavigator {
  void showMessage(String message, {String? actionName, VoidCallback? action});
  void showLoading({String message});
  void hideDialog();
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;
  VM initViewModel();
  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
  }

  @override
  void showLoading({String message = 'loading'}) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Row(
                children: [const CircularProgressIndicator(), Text(message)],
              ),
            ));
  }

  @override
  void showMessage(String message, {String? actionName, VoidCallback? action}) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Row(
                children: [
                  const CircularProgressIndicator(),
                  Expanded(child: Text(message)),
                  TextButton(onPressed: action, child: Text(actionName ?? 'ok'))
                ],
              ),
            ));
  }

  @override
  void hideDialog() {
    Navigator.pop(context);
  }
}
