import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metatube/Utiles/App_themes.dart';
import 'package:metatube/Utiles/snackbar_Utils.dart';

class CustomTextField extends StatefulWidget {
  final int maxLength;
  final int? maxLines;
  final String hintText;
  final TextEditingController controller;
  const CustomTextField(
      {super.key,
      required this.maxLength,
      this.maxLines,
      required this.hintText,
      required this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void copyToClipBoard(context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    SnackBarUtils.showSnackbar(context, Icons.content_copy, 'copied text');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      controller: widget.controller,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      keyboardType: TextInputType.multiline,
      cursorColor: AppTheme.accent,
      style: AppTheme.inputstyle,
      decoration: InputDecoration(
          hintStyle: AppTheme.hintStyle,
          hintText: widget.hintText,
          suffixIcon: _copyButton(context),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.accent)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.medium)),
          counterStyle: AppTheme.counterstyle),
    );
  }

  IconButton _copyButton(BuildContext context) {
    return IconButton(
      onPressed: widget.controller.text.isNotEmpty
          ? () => copyToClipBoard(context, widget.controller.text)
          : null,
      color: AppTheme.accent,
      splashRadius: 20,
      splashColor: AppTheme.accent,
      disabledColor: AppTheme.medium,
      icon: Icon(Icons.copy_rounded),
    );
  }
}
