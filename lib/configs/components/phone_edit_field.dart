import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:millyshb/configs/theme/colors.dart';

// ignore: must_be_immutable
class PhoneEditField extends StatefulWidget {
  PhoneEditField(
      {super.key,
      this.focus,
      required this.updatePhone,
      required this.currentNumber,
      required this.enabled});
  final ValueChanged<String> updatePhone;
  String currentNumber;
  bool enabled = true;
  FocusNode? focus = primaryFocus;

  @override
  State<PhoneEditField> createState() => _PhoneEditFieldState();
}

class _PhoneEditFieldState extends State<PhoneEditField> {
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      focusNode: widget.focus,
      initialValue: widget.currentNumber,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14, fontWeight: FontWeight.w500, color: Pallete.textColor),
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Pallete.accentColor),
        ),
        labelText: 'Phone Number',
        labelStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Pallete.textColor.withOpacity(.5)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Pallete.outLineColor,
            width: 1,
          ),
        ),
      ),

      enabled: widget.enabled,
      initialCountryCode:
          'IN', // Change it to your desired initial country code
      onChanged: (phone) {
        widget.updatePhone(phone.completeNumber);
      },
      // onCountryChanged: (country) {
      //   print(country.code);
      // },
    );
  }
}
