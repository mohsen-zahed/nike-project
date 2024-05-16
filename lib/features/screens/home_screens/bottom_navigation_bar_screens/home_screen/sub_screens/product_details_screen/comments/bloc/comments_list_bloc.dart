import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/features/data/models/comment_model.dart';
import 'package:nike_project/features/data/repository/icomment_repository.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

part 'comments_list_event.dart';
part 'comments_list_state.dart';

class CommentsListBloc extends Bloc<CommentsListEvent, CommentsListState> {
  final ICommentRepository commentRepository;
  final int productId;
  CommentsListBloc({
    required this.commentRepository,
    required this.productId,
  }) : super(CommentsListLoading()) {
    on<CommentsListEvent>((event, emit) async {
      if (event is CommentsListStarted) {
        emit(CommentsListLoading());
        try {
          final comments =
              await commentRepository.getAllComments(productId: productId);
          emit(CommentsListSuccess(commentsList: comments));
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(
              CommentsListFailed(
                  errorMessage: LocaleKeys.dio_error_bad_response.tr()),
            );
          } else if (e.type == DioExceptionType.connectionError) {
            emit(CommentsListFailed(
              errorMessage: LocaleKeys.dio_error_connection_error.tr(),
            ));
          } else if (e.type == DioExceptionType.connectionTimeout) {
            emit(CommentsListFailed(
              errorMessage: LocaleKeys.dio_error_connection_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.sendTimeout) {
            emit(CommentsListFailed(
              errorMessage: LocaleKeys.dio_error_sent_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.unknown) {
            emit(CommentsListFailed(
              errorMessage: LocaleKeys.something_went_wrong.tr(),
            ));
          } else {
            emit(CommentsListFailed(
              errorMessage: LocaleKeys.try_again.tr(),
            ));
          }
        }
      }
    });
  }
}
