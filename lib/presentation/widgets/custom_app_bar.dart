import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/constants/app_text_styles.dart';
import 'package:omedia_payment_app/routes/app_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Icon? endIconPath;
  final VoidCallback? onEndIconPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle = '',
    this.showBackButton = false,
    this.onBackPressed,
    this.endIconPath,
    this.onEndIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      shadowColor: Color.fromRGBO(0, 0, 0, 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 8),
              blurRadius: 12,
              spreadRadius: 0,
              color: Color.fromRGBO(0, 0, 0, 0.08),
            ),
          ],
        ),
      ),
      title: Row(
        children: [
          if (showBackButton) ...[
            InkWell(
              child: Container(
                padding: EdgeInsets.all(8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorConstants.grayLight,
                ),
                child: Center(
                  child: SvgPicture.asset('assets/icons/ic_arrow_back.svg'),
                ),
              ),
              onTap: onBackPressed ?? () => AppRouter.navigateBack(context),
            ),
            SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppTextStyles.fontFamily,
                    fontSize: 16,
                    letterSpacing: 0.1,
                    color: ColorConstants.black,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: 12,
                      letterSpacing: 0.1,
                      color: ColorConstants.black,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (endIconPath != null) ...[
            InkWell(child: endIconPath!, onTap: onEndIconPressed),
          ],
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
