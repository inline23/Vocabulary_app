import 'package:flutter/material.dart';
import 'package:vocabulary_app/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/views/styles/color_manager.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key, required this.label, required this.formKey});
  final String label;
  final GlobalKey<FormState> formKey;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        autofocus: true,
        controller: textEditingController,
        onChanged: (value) => WriteDataCubit.get(context).updateText(value),
        validator: (value) {
          return _validator(value, WriteDataCubit.get(context).isArabic);
        },
        minLines: 1,
        maxLines: 2,
        cursorColor: ColorManager.white,
        style: TextStyle(color: ColorManager.white),
        decoration: _getInputDecoraton(),
      ),
    );
  }

  String? _validator(String? value, bool isArabic) {
    if (value == null || value.trim().length == 0) {
      return "This field has not to be impty";
    }
    for (int i = 0; i < value.length; i++) {
      CharType charType = _getCharType(value.codeUnitAt(i));
      if (charType == CharType.notValid) {
        return "Char Number ${i + 1} Not Valid";
      } else if (charType == CharType.arabic && isArabic == false) {
        return "Char Number ${i + 1} is not english";
      } else if (charType == CharType.english && isArabic == true) {
        return "Char Number ${i + 1} is not arabic";
      }
    }
  }

  // this function retrun the type of the index from copare the input with ascii code
  CharType _getCharType(int asciiCode) {
    if ((asciiCode >= 65 && asciiCode <= 95) ||
        (asciiCode >= 97 && asciiCode <= 122)) {
      return CharType.english;
    } else if (asciiCode >= 1569 && asciiCode <= 1610) {
      return CharType.arabic;
    } else if (asciiCode == 32) {
      return CharType.space;
    }
    return CharType.notValid;
  }

  InputDecoration _getInputDecoraton() {
    return InputDecoration(
      label: Text(widget.label, style: TextStyle(color: ColorManager.white)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: ColorManager.white, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: ColorManager.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}

// this enum to return the type of the index for input
enum CharType { arabic, english, space, notValid }
