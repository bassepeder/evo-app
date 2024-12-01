import 'package:evo/common/id.dart';
import 'package:evo/features/home/models/evo_location.dart';
import 'package:evo/features/home/models/location_statistics.dart';
import 'package:evo/features/home/models/location_statistics_timeline.dart';
import 'package:evo/network/http.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_repository.g.dart';

@riverpod
Future<IList<EvoLocation>> getLocations(Ref ref) async =>
    ref.withClientCacheFor(
      (client) => LocationRepository(client).getLocations(),
      const Duration(hours: 6),
    );

@riverpod
Future<EvoLocationStatistics?> currentLocationStatistics(
  Ref ref,
  LocationId locationId,
) async =>
    ref.withClientCacheFor(
      (client) =>
          LocationRepository(client).getCurrentLocationStatistics(locationId),
      const Duration(minutes: 15),
    );

@riverpod
Future<EvoLocationStatisticsTimeline?> locationStatisticsTimeline(
  Ref ref,
  LocationId locationId,
) async =>
    ref.withClientCacheFor(
      (client) =>
          LocationRepository(client).getLocationStatisticsTimeline(locationId),
      const Duration(minutes: 15),
    );

class LocationRepository {
  LocationRepository(this.client);

  final EvoClient client;

  Future<IList<EvoLocation>> getLocations() {
    return client.readJsonList(
      evoUri('api/v1/locations'),
      mapper: EvoLocation.fromJson,
    );
  }

  Future<EvoLocationStatistics?> getCurrentLocationStatistics(LocationId id) {
    return client.readJson(
      evoUri('api/v1/locations/${id.value}/current'),
      mapper: EvoLocationStatistics.fromJson,
    );
  }

  Future<EvoLocationStatisticsTimeline?> getLocationStatisticsTimeline(
    LocationId id,
  ) {
    return client.readJson(
      evoUri('api/v1/locations/${id.value}/timeline'),
      mapper: EvoLocationStatisticsTimeline.fromJson,
    );
  }
}
