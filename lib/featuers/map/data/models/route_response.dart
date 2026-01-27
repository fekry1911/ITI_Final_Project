import 'package:json_annotation/json_annotation.dart';

part 'route_response.g.dart';

@JsonSerializable()
class RouteResponse {
  final String type;
  final List<double> bbox;
  final List<Feature> features;
  final Metadata metadata;

  RouteResponse({
    required this.type,
    required this.bbox,
    required this.features,
    required this.metadata,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) =>
      _$RouteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RouteResponseToJson(this);
}

@JsonSerializable()
class Feature {
  final List<double> bbox;
  final String type;
  final Properties properties;
  final Geometry geometry;

  Feature({
    required this.bbox,
    required this.type,
    required this.properties,
    required this.geometry,
  });

  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);
  Map<String, dynamic> toJson() => _$FeatureToJson(this);
}

@JsonSerializable()
class Properties {
  final List<Segment> segments;
  @JsonKey(name: 'way_points')
  final List<int> wayPoints;
  final Summary summary;

  Properties({
    required this.segments,
    required this.wayPoints,
    required this.summary,
  });

  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);
  Map<String, dynamic> toJson() => _$PropertiesToJson(this);
}

@JsonSerializable()
class Segment {
  final double distance;
  final double duration;
  final List<Step> steps;

  Segment({
    required this.distance,
    required this.duration,
    required this.steps,
  });

  factory Segment.fromJson(Map<String, dynamic> json) =>
      _$SegmentFromJson(json);
  Map<String, dynamic> toJson() => _$SegmentToJson(this);
}

@JsonSerializable()
class Step {
  final double distance;
  final double duration;
  final int type;
  final String instruction;
  final String name;
  @JsonKey(name: 'way_points')
  final List<int> wayPoints;

  Step({
    required this.distance,
    required this.duration,
    required this.type,
    required this.instruction,
    required this.name,
    required this.wayPoints,
  });

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);
  Map<String, dynamic> toJson() => _$StepToJson(this);
}

@JsonSerializable()
class Summary {
  final double distance;
  final double duration;

  Summary({
    required this.distance,
    required this.duration,
  });

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);
  Map<String, dynamic> toJson() => _$SummaryToJson(this);
}

@JsonSerializable()
class Geometry {
  final List<List<double>> coordinates;
  final String type;

  Geometry({
    required this.coordinates,
    required this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable()
class Metadata {
  final String attribution;
  final String service;
  final int timestamp;
  final Query query;
  final Engine engine;

  Metadata({
    required this.attribution,
    required this.service,
    required this.timestamp,
    required this.query,
    required this.engine,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable()
class Query {
  final List<List<double>> coordinates;
  final String profile;
  final String profileName;
  final String format;

  Query({
    required this.coordinates,
    required this.profile,
    required this.profileName,
    required this.format,
  });

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);
  Map<String, dynamic> toJson() => _$QueryToJson(this);
}

@JsonSerializable()
class Engine {
  final String version;
  @JsonKey(name: 'build_date')
  final String buildDate;
  @JsonKey(name: 'graph_date')
  final String graphDate;
  @JsonKey(name: 'osm_date')
  final String osmDate;

  Engine({
    required this.version,
    required this.buildDate,
    required this.graphDate,
    required this.osmDate,
  });

  factory Engine.fromJson(Map<String, dynamic> json) => _$EngineFromJson(json);
  Map<String, dynamic> toJson() => _$EngineToJson(this);
}