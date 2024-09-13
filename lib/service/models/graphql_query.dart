import 'package:json_annotation/json_annotation.dart';

part 'graphql_query.g.dart';

@JsonSerializable()
class GraphQLQuery {
  final String query;
  final Map<String, dynamic>? variables;

  GraphQLQuery({required this.query, this.variables});

  factory GraphQLQuery.fromJson(Map<String, dynamic> json) =>
      _$GraphQLQueryFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLQueryToJson(this);
}
