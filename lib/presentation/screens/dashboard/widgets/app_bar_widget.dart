import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorConstants.grayLight,
          ),
          child: Center(child: SvgPicture.asset('assets/icons/ic_burger.svg')),
        ),
        SizedBox(width: 52),
        Expanded(
          child: Center(child: SvgPicture.asset('assets/icons/skapi.svg')),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorConstants.grayLight,
              ),
              child: Center(
                child: SvgPicture.asset('assets/icons/ic_bell.svg'),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorConstants.grayLight,
              ),
              child: Center(
                child: SvgPicture.asset('assets/icons/ic_question_mark.svg'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
