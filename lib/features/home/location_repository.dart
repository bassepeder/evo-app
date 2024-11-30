import 'package:evo/common/id.dart';
import 'package:evo/features/home/models/evo_location.dart';
import 'package:evo/features/home/models/location_statistics.dart';
import 'package:evo/network/http.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_repository.g.dart';

@riverpod
Future<IList<EvoLocation>> getLocations(Ref ref) async =>
    ref.withClientCacheFor(
      (client) => LocationRepository(client).getLocations(),
      const Duration(hours: 6),
    );

@riverpod
Future<EvoLocationStatistics?> locationStatistics(
  Ref ref,
  LocationId locationId,
) async =>
    ref.withClientCacheFor(
      (client) => LocationRepository(client).getLocationStatistics(locationId),
      const Duration(minutes: 15),
    );

class LocationRepository {
  LocationRepository(this.client);

  final EvoClient client;
  final Logger _log = Logger('LocationRepository');

  Future<IList<EvoLocation>> getLocations() {
    return client.readJsonList(
      evoUri('api/v1/locations'),
      mapper: EvoLocation.fromJson,
    );
  }

  Future<EvoLocationStatistics?> getLocationStatistics(LocationId id) {
    return client.readJson(
      evoUri('api/v1/locations/${id.value}'),
      mapper: EvoLocationStatistics.fromJson,
    );
  }
}
