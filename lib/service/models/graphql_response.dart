import 'package:json_annotation/json_annotation.dart';

part 'graphql_response.g.dart';

@JsonSerializable()
class GraphQLResponse {
  final Map<String, dynamic>? data;
  final List<Map<String, dynamic>>? errors;

  GraphQLResponse({this.data, this.errors});

  factory GraphQLResponse.fromJson(Map<String, dynamic> json) =>
      _$GraphQLResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLResponseToJson(this);
}
