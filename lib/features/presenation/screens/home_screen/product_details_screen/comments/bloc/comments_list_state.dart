part of 'comments_list_bloc.dart';

sealed class CommentsListState extends Equatable {
  const CommentsListState();

  @override
  List<Object> get props => [];
}

final class CommentsListLoading extends CommentsListState {}

final class CommentsListSuccess extends CommentsListState {
  final List<CommentModel> commentsList;

  const CommentsListSuccess({required this.commentsList});
}

final class CommentsListFailed extends CommentsListState {
  final String errorMessage;

  const CommentsListFailed({required this.errorMessage});
}
