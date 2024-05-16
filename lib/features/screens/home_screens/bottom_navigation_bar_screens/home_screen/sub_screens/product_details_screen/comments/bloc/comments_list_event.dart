part of 'comments_list_bloc.dart';

sealed class CommentsListEvent extends Equatable {
  const CommentsListEvent();

  @override
  List<Object> get props => [];
}

class CommentsListStarted extends CommentsListEvent {}
