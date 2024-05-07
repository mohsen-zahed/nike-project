import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';

class TwoHorzontalWidgets extends StatelessWidget {
  final String text;
  final String value;
  final bool isGreyApplied;
  const TwoHorzontalWidgets({
    super.key,
    required this.text,
    required this.value,
    required this.isGreyApplied,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        getMediaQueryWidth(context, kDefaultPaddingWidth20),
        0,
        getMediaQueryWidth(context, kDefaultPaddingWidth20),
        getMediaQueryHeight(context, kDefaultPaddingHeight15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Text.rich(
            TextSpan(
              text: '$value ',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isGreyApplied ? kCaptionsTextColor : null,
                  ),
              children: [
                TextSpan(
                  text: LocaleKeys.currency_unit_text.tr(),
                  style: isGreyApplied
                      ? Theme.of(context).textTheme.labelSmall
                      : Theme.of(context).textTheme.labelSmall!.copyWith(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                            fontWeight: FontWeight.normal,
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
