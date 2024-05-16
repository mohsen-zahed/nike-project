import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefresherIndicatorWidget extends StatelessWidget {
  const RefresherIndicatorWidget({
    super.key,
    required RefreshController refreshController,
    required this.onRefresh,
    required this.child,
  }) : _refreshController = refreshController;

  final Widget child;
  final VoidCallback onRefresh;

  final RefreshController _refreshController;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: onRefresh,
      header: ClassicHeader(
        refreshingIcon: const CupertinoActivityIndicator(radius: 8),
        completeIcon: Icon(
          CupertinoIcons.check_mark_circled,
          size: 20,
          color: Theme.of(context).textTheme.labelSmall!.color,
        ),
        releaseIcon: Icon(
          CupertinoIcons.refresh,
          size: 20,
          color: Theme.of(context).textTheme.labelSmall!.color,
        ),
        completeText: LocaleKeys.refresh_completed_text.tr(),
        refreshingText: LocaleKeys.refreshing_text.tr(),
        idleText: LocaleKeys.pull_down_to_refresh_text.tr(),
        releaseText: LocaleKeys.release_to_refresh_text.tr(),
        spacing: 10,
      ),
      child: child,
    );
  }
}
