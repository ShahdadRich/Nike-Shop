part of 'commentlistblock_bloc.dart';

sealed class CommentListState extends Equatable {
  const CommentListState();

  @override
  List<Object> get props => [];
}

final class CommentListLoading extends CommentListState {}

class CommentListSuccess extends CommentListState {
  final List<CommentEntity> comment;

  const CommentListSuccess(this.comment);

  @override
  List<Object> get props => [comment];
}

class CommentListError extends CommentListState {
  final AppException exception;

  const CommentListError(this.exception);
  @override
  List<Object> get props => [exception];
}
