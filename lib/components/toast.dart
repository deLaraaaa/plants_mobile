import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Classe responsável por exibir mensagens de Toast.
class Toast {
  /// Exibe uma mensagem de sucesso com um Toast.
  ///
  /// [message] é a mensagem a ser exibida.
  /// [backgroundColor] é a cor de fundo do Toast, por padrão é verde.
  static void showSuccess(String message, {Color backgroundColor = Colors.green}) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
      timeInSecForIosWeb: 3,
    );
  }

  /// Exibe uma mensagem de erro com um Toast.
  ///
  /// [message] é a mensagem a ser exibida.
  static void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
      timeInSecForIosWeb: 3,
    );
  }
}