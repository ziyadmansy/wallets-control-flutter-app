import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallets_control/controllers/auth_controller.dart';
import 'package:wallets_control/shared/constants.dart';

class SharedCore {
  static final dateFormat = DateFormat('d MMM, yyyy');
  static final monthlyDateFormat = DateFormat('MMM, yyyy');
  static final timeFormat = DateFormat.jm();
  static final dateTimeFormat = DateFormat('dd-MM-yyyy').add_jm();

  static Rx<String> getAccessToken() {
    final accessToken = Get.find<AuthController>().accessToken;
    print('Access Token: ${accessToken.value}');
    return accessToken;
  }

  static Widget buildLoaderIndicator() {
    return const CircularProgressIndicator.adaptive();
  }

  static Widget networkImageError(context, e, st) {
    return Center(
      child: Icon(Icons.error),
    );
  }

  static AppBar buildAppBar({
    required String title,
  }) {
    return AppBar(
      title: Text(title),
    );
  }

  static Widget buildRoundedOutlinedButton({
    required String btnText,
    required VoidCallback onPress,
    bool isEnabled = true,
    Color? btnColor,
  }) =>
      SizedBox(
        height: 48,
        child: OutlinedButton(
          child: Text(btnText),
          style: ElevatedButton.styleFrom(
            backgroundColor: btnColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
          ),
          onPressed: isEnabled ? onPress : null,
        ),
      );

  static Widget buildTextButton({
    required String btnText,
    required VoidCallback onPress,
    bool isEnabled = true,
    Color? btnColor,
  }) =>
      SizedBox(
        height: 40,
        child: TextButton(
          child: Text(btnText),
          style: ElevatedButton.styleFrom(
            backgroundColor: btnColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
          ),
          onPressed: isEnabled ? onPress : null,
        ),
      );

  static Widget buildRoundedElevatedButton({
    required Widget btnChild,
    required VoidCallback? onPress,
    Color? btnColor,
    bool isEnabled = true,
  }) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        child: btnChild,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
        ),
        onPressed: isEnabled ? onPress : null,
      ),
    );
  }

  static Widget buildRoundedIconElevatedButton({
    required String btnText,
    required Color btnColor,
    required IconData icon,
    required VoidCallback onPress,
    bool isEnabled = true,
  }) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        label: Text(btnText),
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
        ),
        onPressed: isEnabled ? onPress : null,
        icon: Icon(icon),
      ),
    );
  }

  static Widget buildClickableTextForm({
    TextEditingController? controller,
    VoidCallback? onClick,
    String? Function(String? val)? onValidate,
    Function(String? val)? onSaved,
    Function(String? val)? onSubmitted,
    void Function(String? val)? onChanged,
    String? hint,
    String? label,
    bool isIgnoringTextInput = false,
    bool isEnabled = true,
    bool isObscure = false,
    String? initialText,
    TextInputType? inputType,
    TextInputAction? textInputAction,
    Widget? prefix,
    Widget? prefixIcon,
    Widget? suffix,
    Widget? suffixIcon,
    FocusNode? focusNode,
    AutovalidateMode validateMode = AutovalidateMode.disabled,
    int maxLines = 1,
    int? minLines,
  }) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(4),
      child: IgnorePointer(
        ignoring: isIgnoringTextInput,
        child: TextFormField(
          controller: controller,
          initialValue: initialText,
          validator: onValidate,
          enabled: isEnabled,
          onChanged: onChanged,
          decoration: InputDecoration(
            enabledBorder: kEnabledBorder,
            focusedBorder: kFocusedBorder,
            disabledBorder: kDisabledBorder,
            errorBorder: kErrorBorder,
            hintText: hint,
            labelText: label ?? hint,
            prefix: prefix,
            suffix: suffix,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
          obscureText: isObscure,
          focusNode: focusNode,
          autovalidateMode: validateMode,
          keyboardType: inputType,
          textInputAction: textInputAction,
          onSaved: onSaved,
          onFieldSubmitted: onSubmitted,
          maxLines: maxLines,
          minLines: minLines,
        ),
      ),
    );
  }

  static Widget buildDropDownSearch<T>({
    required BuildContext context,
    required T selectedItem,
    required List<T> items,
    required bool Function(T, T) compareFn,
    required String Function(T item) itemAsString,
    String Function(T? val)? onValidate,
    void Function(T? val)? onSaved,
    void Function(T? val)? onSubmitted,
    void Function(T?)? onChanged,
    String? title,
    String? hint,
    String? label,
  }) {
    return DropdownSearch<T>(
      selectedItem: selectedItem,
      items: items,
      onChanged: onChanged,
      enabled: true,
      compareFn: compareFn,
      itemAsString: itemAsString,
      validator: onValidate,
      popupProps: PopupProps.dialog(
        showSearchBox: true,
        showSelectedItems: true,
        dialogProps: DialogProps(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          actions: [
            SharedCore.buildTextButton(
              btnText: 'Cancel',
              onPress: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        title: title == null
            ? null
            : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8,
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: hint,
          labelText: label,
          enabledBorder: kEnabledBorder,
          focusedBorder: kFocusedBorder,
          errorBorder: kErrorBorder,
          disabledBorder: kDisabledBorder,
        ),
      ),
    );
  }

  static Widget buildCheckBoxListTile({
    required String title,
    required bool isChecked,
    required Function(bool? isChecked) onCheck,
    TextStyle? titleStyle,
  }) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      title: Text(
        title,
        style: titleStyle,
      ),
      value: isChecked,
      onChanged: onCheck,
    );
  }
}
