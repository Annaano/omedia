import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/constants/app_text_styles.dart';

enum ButtonType { primary, secondary, success, error }

enum ButtonSize { small, medium, large }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final String? iconPath;
  final String? trailingIconPath;
  final bool showTrailingIcon;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  final TextStyle? textStyle;
  final Color? customTextColor;
  final double? customFontSize;
  final FontWeight? customFontWeight;
  final String? customFontFamily;
  final double? customLetterSpacing;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;

  final double? customIconSize;
  final Color? customIconColor;
  final double? customTrailingIconSize;
  final Color? customTrailingIconColor;
  final EdgeInsetsGeometry? iconPadding;
  final EdgeInsetsGeometry? trailingIconPadding;

  final Color? customBackgroundColor;
  final Color? customBorderColor;
  final double? customBorderWidth;

  final Widget? customIcon;
  final Widget? customTrailingIcon;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double? customIconSpacing;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.iconPath,
    this.trailingIconPath,
    this.showTrailingIcon = false,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,

    this.textStyle,
    this.customTextColor,
    this.customFontSize,
    this.customFontWeight,
    this.customFontFamily,
    this.customLetterSpacing,
    this.textAlign,
    this.textOverflow,
    this.maxLines,

    this.customIconSize,
    this.customIconColor,
    this.customTrailingIconSize,
    this.customTrailingIconColor,
    this.iconPadding,
    this.trailingIconPadding,

    this.customBackgroundColor,
    this.customBorderColor,
    this.customBorderWidth,

    this.customIcon,
    this.customTrailingIcon,

    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.customIconSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final isButtonDisabled = isDisabled || isLoading;

    return Opacity(
      opacity: isButtonDisabled ? 0.6 : 1.0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isButtonDisabled ? null : onPressed,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          child: Container(
            width: width ?? double.infinity,
            height: height ?? _getButtonHeight(),
            padding: padding ?? _getButtonPadding(),
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              color: _getBackgroundColor(),
              border: _getBorder(),
            ),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                if (isLoading) ...[
                  SizedBox(
                    width: _getIconSize(),
                    height: _getIconSize(),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getTextColor(),
                      ),
                    ),
                  ),
                  if (text.isNotEmpty) SizedBox(width: _getIconSpacing()),
                ] else ...[
                  if (customIcon != null) ...[
                    if (iconPadding != null)
                      Padding(padding: iconPadding!, child: customIcon!)
                    else
                      customIcon!,
                    if (text.isNotEmpty) SizedBox(width: _getIconSpacing()),
                  ] else if (iconPath != null) ...[
                    if (iconPadding != null)
                      Padding(
                        padding: iconPadding!,
                        child: SvgPicture.asset(
                          iconPath!,
                          width: customIconSize ?? _getIconSize(),
                          height: customIconSize ?? _getIconSize(),
                          colorFilter: ColorFilter.mode(
                            customIconColor ?? _getTextColor(),
                            BlendMode.srcIn,
                          ),
                        ),
                      )
                    else
                      SvgPicture.asset(
                        iconPath!,
                        width: customIconSize ?? _getIconSize(),
                        height: customIconSize ?? _getIconSize(),
                        colorFilter: ColorFilter.mode(
                          customIconColor ?? _getTextColor(),
                          BlendMode.srcIn,
                        ),
                      ),
                    if (text.isNotEmpty) SizedBox(width: _getIconSpacing()),
                  ],
                ],
                if (text.isNotEmpty)
                  Flexible(
                    child: Text(
                      text,
                      style: textStyle ?? _getTextStyle(),
                      textAlign: textAlign ?? TextAlign.center,
                      overflow: textOverflow ?? TextOverflow.ellipsis,
                      maxLines: maxLines,
                    ),
                  ),
                if (showTrailingIcon && !isLoading) ...[
                  if (text.isNotEmpty) SizedBox(width: _getIconSpacing()),
                  if (customTrailingIcon != null)
                    if (trailingIconPadding != null)
                      Padding(
                        padding: trailingIconPadding!,
                        child: customTrailingIcon!,
                      )
                    else
                      customTrailingIcon!
                  else if (trailingIconPath != null)
                    if (trailingIconPadding != null)
                      Padding(
                        padding: trailingIconPadding!,
                        child: SvgPicture.asset(
                          trailingIconPath!,
                          width: customTrailingIconSize ?? _getIconSize(),
                          height: customTrailingIconSize ?? _getIconSize(),
                          colorFilter: ColorFilter.mode(
                            customTrailingIconColor ?? _getTextColor(),
                            BlendMode.srcIn,
                          ),
                        ),
                      )
                    else
                      SvgPicture.asset(
                        trailingIconPath!,
                        width: customTrailingIconSize ?? _getIconSize(),
                        height: customTrailingIconSize ?? _getIconSize(),
                        colorFilter: ColorFilter.mode(
                          customTrailingIconColor ?? _getTextColor(),
                          BlendMode.srcIn,
                        ),
                      ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (customBackgroundColor != null) return customBackgroundColor!;

    if (isDisabled) {
      return ColorConstants.primary48;
    }

    switch (type) {
      case ButtonType.primary:
        return ColorConstants.primary;
      case ButtonType.secondary:
        return ColorConstants.primaryLight;
      case ButtonType.success:
        return ColorConstants.success;

      case ButtonType.error:
        return ColorConstants.error;
    }
  }

  Color _getTextColor() {
    if (customTextColor != null) return customTextColor!;

    if (isDisabled) {
      return ColorConstants.white;
    }

    switch (type) {
      case ButtonType.primary:
        return ColorConstants.white;
      case ButtonType.secondary:
        return ColorConstants.black;
      case ButtonType.success:
        return ColorConstants.white;

      case ButtonType.error:
        return ColorConstants.white;
    }
  }

  Border? _getBorder() {
    if (customBorderColor != null) {
      return Border.all(
        color: customBorderColor!,
        width: customBorderWidth ?? 1,
      );
    }
    return null;
  }

  TextStyle _getTextStyle() {
    final baseStyle = TextStyle(
      fontFamily: customFontFamily ?? AppTextStyles.fontFamily,
      fontSize: customFontSize ?? _getFontSize(),
      fontWeight: customFontWeight ?? FontWeight.w500,
      letterSpacing: customLetterSpacing ?? 0.1,
      color: _getTextColor(),
    );

    return baseStyle;
  }

  double _getButtonHeight() {
    switch (size) {
      case ButtonSize.small:
        return 36;
      case ButtonSize.medium:
        return 48;
      case ButtonSize.large:
        return 56;
    }
  }

  EdgeInsetsGeometry _getButtonPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
    }
  }

  double _getFontSize() {
    switch (size) {
      case ButtonSize.small:
        return 12;
      case ButtonSize.medium:
        return 14;
      case ButtonSize.large:
        return 16;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  double _getIconSpacing() {
    if (customIconSpacing != null) {
      return customIconSpacing!;
    }

    switch (size) {
      case ButtonSize.small:
        return 4;
      case ButtonSize.medium:
        return 6;
      case ButtonSize.large:
        return 8;
    }
  }
}

class CustomButtonExamples {
  static CustomButton primaryButton({
    required String text,
    required VoidCallback onPressed,
    String? iconPath,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.primary,
      iconPath: iconPath,
      isLoading: isLoading,
      isDisabled: isDisabled,
    );
  }

  static CustomButton secondaryButton({
    required String text,
    required VoidCallback onPressed,
    String? iconPath,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.secondary,
      iconPath: iconPath,
      isLoading: isLoading,
      isDisabled: isDisabled,
    );
  }

  static CustomButton outlineButton({
    required String text,
    required VoidCallback onPressed,
    String? iconPath,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,

      iconPath: iconPath,
      isLoading: isLoading,
      isDisabled: isDisabled,
    );
  }

  static CustomButton successButton({
    required String text,
    required VoidCallback onPressed,
    String? iconPath,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.success,
      iconPath: iconPath,
      isLoading: isLoading,
      isDisabled: isDisabled,
    );
  }

  static CustomButton errorButton({
    required String text,
    required VoidCallback onPressed,
    String? iconPath,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.error,
      iconPath: iconPath,
      isLoading: isLoading,
      isDisabled: isDisabled,
    );
  }

  static CustomButton navigationButton({
    required String text,
    required VoidCallback onPressed,
    String? iconPath,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.secondary,
      iconPath: iconPath,
      showTrailingIcon: true,
      trailingIconPath: 'assets/icons/ic_forward_arrow.svg',
      isLoading: isLoading,
      isDisabled: isDisabled,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
