// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteResponse _$RouteResponseFromJson(Map<String, dynamic> json) =>
    RouteResponse(
      type: json['type'] as String,
      bbox: (json['bbox'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      features: (json['features'] as List<dynamic>)
          .map((e) => Feature.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RouteResponseToJson(RouteResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'bbox': instance.bbox,
      'features': instance.features,
      'metadata': instance.metadata,
    };

Feature _$FeatureFromJson(Map<String, dynamic> json) => Feature(
  bbox: (json['bbox'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  type: json['type'] as String,
  properties: Properties.fromJson(json['properties'] as Map<String, dynamic>),
  geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FeatureToJson(Feature instance) => <String, dynamic>{
  'bbox': instance.bbox,
  'type': instance.type,
  'properties': instance.properties,
  'geometry': instance.geometry,
};

Properties _$PropertiesFromJson(Map<String, dynamic> json) => Properties(
  segments: (json['segments'] as List<dynamic>)
      .map((e) => Segment.fromJson(e as Map<String, dynamic>))
      .toList(),
  wayPoints: (json['way_points'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  summary: Summary.fromJson(json['summary'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PropertiesToJson(Properties instance) =>
    <String, dynamic>{
      'segments': instance.segments,
      'way_points': instance.wayPoints,
      'summary': instance.summary,
    };

Segment _$SegmentFromJson(Map<String, dynamic> json) => Segment(
  distance: (json['distance'] as num).toDouble(),
  duration: (json['duration'] as num).toDouble(),
  steps: (json['steps'] as List<dynamic>)
      .map((e) => Step.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SegmentToJson(Segment instance) => <String, dynamic>{
  'distance': instance.distance,
  'duration': instance.duration,
  'steps': instance.steps,
};

Step _$StepFromJson(Map<String, dynamic> json) => Step(
  distance: (json['distance'] as num).toDouble(),
  duration: (json['duration'] as num).toDouble(),
  type: (json['type'] as num).toInt(),
  instruction: json['instruction'] as String,
  name: json['name'] as String,
  wayPoints: (json['way_points'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
  'distance': instance.distance,
  'duration': instance.duration,
  'type': instance.type,
  'instruction': instance.instruction,
  'name': instance.name,
  'way_points': instance.wayPoints,
};

Summary _$SummaryFromJson(Map<String, dynamic> json) => Summary(
  distance: (json['distance'] as num).toDouble(),
  duration: (json['duration'] as num).toDouble(),
);

Map<String, dynamic> _$SummaryToJson(Summary instance) => <String, dynamic>{
  'distance': instance.distance,
  'duration': instance.duration,
};

Geometry _$GeometryFromJson(Map<String, dynamic> json) => Geometry(
  coordinates: (json['coordinates'] as List<dynamic>)
      .map(
        (e) => (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
      )
      .toList(),
  type: json['type'] as String,
);

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
  'coordinates': instance.coordinates,
  'type': instance.type,
};

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
  attribution: json['attribution'] as String,
  service: json['service'] as String,
  timestamp: (json['timestamp'] as num).toInt(),
  query: Query.fromJson(json['query'] as Map<String, dynamic>),
  engine: Engine.fromJson(json['engine'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
  'attribution': instance.attribution,
  'service': instance.service,
  'timestamp': instance.timestamp,
  'query': instance.query,
  'engine': instance.engine,
};

Query _$QueryFromJson(Map<String, dynamic> json) => Query(
  coordinates: (json['coordinates'] as List<dynamic>)
      .map(
        (e) => (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
      )
      .toList(),
  profile: json['profile'] as String,
  profileName: json['profileName'] as String,
  format: json['format'] as String,
);

Map<String, dynamic> _$QueryToJson(Query instance) => <String, dynamic>{
  'coordinates': instance.coordinates,
  'profile': instance.profile,
  'profileName': instance.profileName,
  'format': instance.format,
};

Engine _$EngineFromJson(Map<String, dynamic> json) => Engine(
  version: json['version'] as String,
  buildDate: json['build_date'] as String,
  graphDate: json['graph_date'] as String,
  osmDate: json['osm_date'] as String,
);

Map<String, dynamic> _$EngineToJson(Engine instance) => <String, dynamic>{
  'version': instance.version,
  'build_date': instance.buildDate,
  'graph_date': instance.graphDate,
  'osm_date': instance.osmDate,
};
