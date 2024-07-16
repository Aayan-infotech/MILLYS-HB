import 'package:flutter/material.dart';
import 'package:millyshb/utills/colors.dart';

class BrandedPrimaryButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isUnfocus;

  const BrandedPrimaryButton({
    super.key,
    this.isUnfocus = false,
    required this.name,
    required this.onPressed,
    this.isEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isEnabled
          ? SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isUnfocus ? Pallete.whiteColor : Pallete.accentColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Pallete.accentColor,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: getButtonText(context),
              ),
            )
          : SizedBox(
              height: 46,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: null, // Disabled button, onPressed is null
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).disabledColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: getButtonText(context),
              ),
            ),
    );
  }

  Widget getButtonText(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: isUnfocus ? Pallete.accentColor : Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: (MediaQuery.of(context).size.width < 380) ? 20 : 20),
    );
  }
}
