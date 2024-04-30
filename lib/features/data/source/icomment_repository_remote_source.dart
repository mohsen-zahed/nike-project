import 'package:dio/dio.dart';
import 'package:nike_project/features/data/models/comment_model.dart';

abstract class ICommentRepositoryRemoteSource {
  Future<List<CommentModel>> getAllComments({required int productId});
}

class ICommentRepositoryRemoteSourceImp extends ICommentRepositoryRemoteSource {
  final Dio httpClient;

  ICommentRepositoryRemoteSourceImp({required this.httpClient});
  @override
  Future<List<CommentModel>> getAllComments({required int productId}) async {
    final response = await httpClient.get('comment/list?product_id=$productId');
    if (response.statusCode != 200) {
      throw 'Host ERROR';
    }
    final List<CommentModel> commentsList = [];
    (response.data as List).forEach((element) {
      commentsList.add(CommentModel.fromJson(element));
    });
    return commentsList;
  }
}
