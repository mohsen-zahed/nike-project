class CustomThemeDataProps {
  static CustomThemeDataProps? _customThemeDataProps;
  CustomThemeDataProps._();
  static CustomThemeDataProps get instance {
    // 1- if(_customThemeDataProps == null){
    // _customThemeDataProps = CustomThemeDataProps._();
    // }
    // or
    // 2- _customThemeDataProps ??= CustomThemeDataProps._();
    _customThemeDataProps ??= CustomThemeDataProps._();
    return _customThemeDataProps!;
  }
}
