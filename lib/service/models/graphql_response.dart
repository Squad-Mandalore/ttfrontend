import 'package:json_annotation/json_annotation.dart';

part 'graphql_response.g.dart';

@JsonSerializable()
class GraphQLResponse {
  final Map<String, dynamic>? data;

  GraphQLResponse({this.data});

  factory GraphQLResponse.fromJson(Map<String, dynamic> json) =>
      _$GraphQLResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLResponseToJson(this);
}
