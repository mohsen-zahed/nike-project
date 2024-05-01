import 'package:nike_project/features/data/models/comment_model.dart';
import 'package:nike_project/features/data/source/icomment_data_remote_source.dart';
import 'package:nike_project/packages/dio/dio_package.dart';

final commentRepository = CommentRepositoryImp(
  iCommentRepositoryRemoteSource:
      CommentDataRemoteSourceImp(httpClient: httpClient),
);

abstract class ICommentRepository {
  Future<List<CommentModel>> getAllComments({required int productId});
}

class CommentRepositoryImp extends ICommentRepository {
  final ICommentDataRemoteSource iCommentRepositoryRemoteSource;

  CommentRepositoryImp({required this.iCommentRepositoryRemoteSource});
  @override
  Future<List<CommentModel>> getAllComments({required int productId}) =>
      iCommentRepositoryRemoteSource.getAllComments(productId: productId);
}
