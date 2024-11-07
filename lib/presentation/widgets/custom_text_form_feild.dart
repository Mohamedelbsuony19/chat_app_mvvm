import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final int? maxLine;
  final int? minLine;
  final Widget? suuf;
  final Widget? prifix;
  final String? hint;
  final String? lable;
  final Function(String)? onChange;
  final bool? obscure;
  final TextStyle? textStyle;
  final String? Function(String?)? validate;
  final VoidCallback? ontabSuffixIcon;
  final VoidCallback? ontabPrifixIcon;
  final TextEditingController? textEditingController;
  const CustomTextFormField(
      {super.key,
      this.textStyle,
      this.suuf,
      this.ontabSuffixIcon,
      this.prifix,
      this.ontabPrifixIcon,
      this.hint,
      this.lable,
      this.onChange,
      this.obscure = false,
      this.maxLine,
      this.minLine,
      this.textEditingController,
      this.validate});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        maxLines: maxLine,
        minLines: minLine,
        style: textStyle,
        obscureText: obscure!,
        onChanged: onChange,
        controller: textEditingController,
        validator: validate,
        decoration: InputDecoration(
          suffixIcon: InkWell(onTap: ontabSuffixIcon, child: suuf),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          hintText: hint,
          labelText: lable,
          labelStyle: const TextStyle(color: Colors.red),
          hintStyle: const TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}
