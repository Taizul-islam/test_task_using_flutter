import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextInputAction? textInputAction;
  final String? hintText;
  final Icon? prefixIcon;
  final IconButton? iconData;
  final TextEditingController? controller;
  final bool isObscure;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final TextInputType? type;
  final Function(String?) onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const CustomTextField(
      {Key? key,
      this.textInputAction,
      this.hintText,
      this.prefixIcon,
      this.controller,
      required this.isObscure,
      this.focusNode,
      this.type,
      required this.onChanged,
      this.autoFocus,
      this.onSaved,
      this.iconData,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onSaved,
      textInputAction: textInputAction,
      focusNode: focusNode,
      controller: controller,
      obscureText: isObscure,
      validator: validator,
      onChanged: onChanged,
      keyboardType: type,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff3DD6FF), width: 1)),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff3DD6FF), width: 1)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff3DD6FF), width: 1)),
          focusColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 12),
          isDense: true,
          prefixIcon: prefixIcon,
          suffixIcon: iconData,
          suffixIconColor: const Color(0xff3DD6FF),
          suffixIconConstraints: const BoxConstraints(
            minHeight: 20,
          )),
    );
  }
}
