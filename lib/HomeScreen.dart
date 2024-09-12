import 'package:flutter/material.dart';
import 'package:metatube/Services/file_service.dart';
import 'package:metatube/Utiles/App_themes.dart';
import 'package:metatube/widgets/custom_textfield.dart';

class HomeSCreen extends StatefulWidget {
  const HomeSCreen({super.key});

  @override
  State<HomeSCreen> createState() => _HomeSCreenState();
}

class _HomeSCreenState extends State<HomeSCreen> {
  FileService fileservice = FileService();

  @override
  void initState() {
    addListners();
    super.initState();
  }

  @override
  void dispose() {
    removeListners();
    super.dispose();
  }

  void addListners() {
    List<TextEditingController> controllers = [
      fileservice.titlecontroller,
      fileservice.descriptioncontroller,
      fileservice.tagscontroller,
    ];
    for (TextEditingController controller in controllers) {
      controller.addListener(_onFieldChanged);
    }
  }

  void removeListners() {
    List<TextEditingController> controllers = [
      fileservice.titlecontroller,
      fileservice.descriptioncontroller,
      fileservice.tagscontroller,
    ];
    for (TextEditingController controller in controllers) {
      controller.removeListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    setState(() {
      fileservice.fieldsNotEmpty =
          fileservice.titlecontroller.text.isNotEmpty &&
              fileservice.descriptioncontroller.text.isNotEmpty &&
              fileservice.tagscontroller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dart,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _mainButton(() => null, 'New file'),
                Row(
                  children: [
                    _actionButton(() => null, Icons.file_upload),
                    const SizedBox(
                      width: 5,
                    ),
                    _actionButton(() => null, Icons.folder),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              maxLength: 100,
              maxLines: 3,
              hintText: 'Enter Video Title',
              controller: fileservice.titlecontroller,
            ),
            const SizedBox(
              height: 25,
            ),
            CustomTextField(
              maxLength: 5000,
              maxLines: 3,
              hintText: 'Enter Video Description',
              controller: fileservice.descriptioncontroller,
            ),
            const SizedBox(
              height: 8,
            ),
            CustomTextField(
              maxLength: 100,
              maxLines: 3,
              hintText: 'Enter Video Tags     ',
              controller: fileservice.tagscontroller,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                _mainButton(
                    fileservice.fieldsNotEmpty
                        ? () => fileservice.saveContent(context)
                        : null,
                    'Save File')
              ],
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton _mainButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(text),
    );
  }

  IconButton _actionButton(Function()? onPressed, IconData icon) {
    return IconButton(
        onPressed: onPressed,
        splashRadius: 20,
        splashColor: AppTheme.accent,
        icon: Icon(
          icon,
          color: AppTheme.medium,
        ));
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.accent,
      foregroundColor: AppTheme.dart,
      disabledBackgroundColor: AppTheme.disabledBackgroundColor,
      disabledForegroundColor: AppTheme.disabledforegroundColor,
    );
  }
}
