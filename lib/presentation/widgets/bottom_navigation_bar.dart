import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/constants/app_text_styles.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavigationBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.white,
        border: Border(
          top: BorderSide(color: ColorConstants.grayLight, width: 1),
          bottom: BorderSide(color: ColorConstants.grayLight, width: 1),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                index: 0,
                icon: 'assets/icons/ic_new_obl.svg',
                label: 'ახალი სესხი',
                isSelected: selectedIndex == 0,
              ),
              _buildNavItem(
                index: 1,
                icon: 'assets/icons/ic_obl.svg',
                label: 'სესხები',
                isSelected: selectedIndex == 1,
              ),
              _buildNavItem(
                index: 2,
                icon: 'assets/icons/ic_home.svg',
                label: '',
                isSelected: selectedIndex == 2,
                isHome: true,
              ),
              _buildNavItem(
                index: 3,
                icon: 'assets/icons/ic_transfers.svg',
                label: 'გზავნილები',
                isSelected: selectedIndex == 3,
              ),
              _buildNavItem(
                index: 4,
                icon: 'assets/icons/ic_currency.svg',
                label: 'ვალუტა',
                isSelected: selectedIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String icon,
    required String label,
    required bool isSelected,
    bool isHome = false,
  }) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 44,
            child:
                isHome
                    ? Container(
                      width: 44,
                      height: 44,
                      decoration:
                          isSelected
                              ? BoxDecoration(
                                color: ColorConstants.primary,
                                shape: BoxShape.circle,
                              )
                              : null,
                      child: Center(
                        child: SvgPicture.asset(
                          icon,
                          width: isHome ? 18 : 22,
                          height: isHome ? 18 : 22,
                          colorFilter: ColorFilter.mode(
                            isSelected
                                ? ColorConstants.white
                                : ColorConstants.grayMedium,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    )
                    : Center(
                      child: SvgPicture.asset(
                        icon,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          ColorConstants.grayMedium,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
          ),
          if (label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                label,
                style: TextStyle(
                  color: ColorConstants.grayDark,
                  fontSize: 12,
                  fontFamily: AppTextStyles.fontFamily,
                  fontWeight: FontWeight.w400,
                  height: 0.1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
