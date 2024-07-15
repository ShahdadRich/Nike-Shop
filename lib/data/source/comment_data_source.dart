import 'package:dio/dio.dart';
import 'package:nike/data/comment.dart';
import 'package:nike/data/common/http_respons_validator.dart';

abstract class ICommentDataSource {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRemoteDataSource
    with HttpResponsValidator
    implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSource(this.httpClient);

  @override
  Future<List<CommentEntity>> getAll({required int productId}) async {
    final response = await httpClient.get('comment/list?product_id=$productId');
    validateRespons(response);
    final List<CommentEntity> comment = [];
    (response.data as List).forEach((element) {
      comment.add(CommentEntity.fromJson(element));
    });
    return comment;
  }
}
