import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/config/constants/constant_variables.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';

class CardTitleAndSeeAllTexts extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CardTitleAndSeeAllTexts({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        getMediaQueryWidth(context, constantVariables.kDefaultPaddingWidth20),
        getMediaQueryWidth(context, constantVariables.kDefaultPaddingWidth20),
        getMediaQueryWidth(context, constantVariables.kDefaultPaddingWidth20),
        getMediaQueryHeight(context, constantVariables.kDefaultPaddingHeight15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: constantVariables.kDefaultTitleFontWeight700,
                ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              LocaleKeys.see_all_text.tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: getMediaQueryHeight(context, 0.015)),
            ),
          ),
        ],
      ),
    );
  }
}
