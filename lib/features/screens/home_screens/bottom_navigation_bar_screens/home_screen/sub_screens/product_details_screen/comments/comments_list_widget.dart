import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/config/constants/colors.dart';
import 'package:nike_project/config/constants/constant_variables.dart';
import 'package:nike_project/features/data/repository/icomment_repository.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/home_screen/sub_screens/product_details_screen/comments/bloc/comments_list_bloc.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets_common_in_all_screens/app_exception_widget.dart';

class CommentsListWidget extends StatelessWidget {
  final int productId;
  const CommentsListWidget({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommentsListBloc bloc = CommentsListBloc(
            commentRepository: commentRepository, productId: productId);
        bloc.add(CommentsListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentsListBloc, CommentsListState>(
          builder: (context, state) {
        if (state is CommentsListSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: state.commentsList.length,
              (context, index) {
                return Container(
                  width: getMediaQueryWidth(context),
                  padding: EdgeInsets.all(
                    getMediaQueryWidth(context, constantVariables.kDefaultPaddingWidth20),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal:
                        getMediaQueryWidth(context, constantVariables.kDefaultPaddingWidth20),
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: kTransparentColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: kGreyColorShade200,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: getMediaQueryWidth(context, 0.5),
                                ),
                                child: Text(
                                  state.commentsList[index].title,
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: getMediaQueryWidth(context, 0.5),
                                ),
                                child: Text(
                                  state.commentsList[index].email,
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: kCaptionsTextColor,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: getMediaQueryWidth(context, 0.4)),
                            child: Text(
                              state.commentsList[index].date,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: kCaptionsTextColor),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: getMediaQueryWidth(context),
                        child: Text(
                          state.commentsList[index].content,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(height: 1.8),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is CommentsListLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CommentsListFailed) {
          return SliverToBoxAdapter(
            child: AppExceptionWidget(
              errorMessage: state.errorMessage,
              buttonText: LocaleKeys.try_again.tr(),
              onPressed: () {
                BlocProvider.of<CommentsListBloc>(context).add(
                  CommentsListStarted(),
                );
              },
            ),
          );
        } else {
          throw 'state is not supported';
        }
      }),
    );
  }
}
