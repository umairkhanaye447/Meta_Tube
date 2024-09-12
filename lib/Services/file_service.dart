import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metatube/Utiles/snackbar_Utils.dart';

class FileService {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController tagscontroller = TextEditingController();
  bool fieldsNotEmpty = false;

  File? _selectedFile;
  String _selectedDirectory = '';

  void saveContent(context) async {
    final title = titlecontroller.text;
    final description = descriptioncontroller.text;
    final tags = tagscontroller.text;

    final textcontent =
        "Title:\n\n$title\n\nDescription:\n\n$description\n\nTages:\n\n$tags\n\n";
    try {
      if (_selectedFile != null) {
        await _selectedFile!.writeAsString(textcontent);
      } else {
        final todayDate = getTodayDate();
        String metadataDirPath = _selectedDirectory;
        if (metadataDirPath.isEmpty) {
          final directory = await FilePicker.platform.getDirectoryPath();
          _selectedDirectory = metadataDirPath = directory!;
        }
        final filePath = "$metadataDirPath/$todayDate-$title-MetaData.text";
        final newFile = File(filePath);
        await newFile.writeAsString(textcontent);
      }
      SnackBarUtils.showSnackbar(
          context, Icons.check_circle, 'File saved successfully');
    } catch (e) {
      SnackBarUtils.showSnackbar(context, Icons.error, 'File not saved');
    }
  }

  static String getTodayDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyy-MM-dd');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }
}
