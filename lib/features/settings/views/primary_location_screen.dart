import 'package:evo/common/id.dart';
import 'package:evo/common/widgets/error_screen.dart';
import 'package:evo/common/widgets/list.dart';
import 'package:evo/features/home/location_repository.dart';
import 'package:evo/features/home/models/evo_location.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/network/http.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryLocationScreen extends ConsumerWidget {
  const PrimaryLocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membershipLocationName = ref.watch(
      membershipDetailsProvider
          .select((membership) => membership.requireValue.location.name),
    );
    final primaryMembershipLocationId = ref.watch(
      membershipDetailsProvider
          .select((membership) => membership.requireValue.location.id),
    );
    final locationsAsync = ref.read(getLocationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.primaryLocationScreen.appbar),
        centerTitle: true,
      ),
      body: locationsAsync.when(
        data: (locations) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyHeaderDelegate(
                    dependency: membershipLocationName,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(title: context.t.primaryLocationScreen.header),
                        const SizedBox(height: 8),
                        Text(
                          membershipLocationName,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 32),
                        Header(title: context.t.homeScreen.chooseLocation),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final sortedLocations =
                            locations.sort((a, b) => a.name.compareTo(b.name));

                        return _LocationPickerList(
                          primaryLocationId: primaryMembershipLocationId,
                          locations: sortedLocations,
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(title: context.t.primaryLocationScreen.header),
                  const CircularProgressIndicator(strokeWidth: 3),
                ],
              ),
            ),
          );
        },
        error: (_, stack) {
          return SafeArea(
            child: Expanded(
              child: ErrorScreen(
                subtitle: context.t.errors.failedToLoadLocations,
                onRetryClicked: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final Object? dependency;

  _StickyHeaderDelegate({
    required this.child,
    required this.dependency,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: child,
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) =>
      oldDelegate.dependency != dependency;
}

class _LocationPickerList extends ConsumerStatefulWidget {
  final LocationId primaryLocationId;
  final IList<EvoLocation> locations;

  const _LocationPickerList({
    required this.primaryLocationId,
    required this.locations,
  });

  @override
  ConsumerState<_LocationPickerList> createState() =>
      _LocationPickerListState();
}

class _LocationPickerListState extends ConsumerState<_LocationPickerList> {
  final currentLocationKey = GlobalKey();
  LocationId? loadingLocationId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentLocation();
    });
  }

  @override
  void didUpdateWidget(covariant _LocationPickerList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.primaryLocationId != widget.primaryLocationId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCurrentLocation(const Duration(milliseconds: 500));
      });
    }
  }

  void _scrollToCurrentLocation([Duration duration = Duration.zero]) {
    if (currentLocationKey.currentContext != null) {
      Scrollable.ensureVisible(
        currentLocationKey.currentContext!,
        alignment: 0.5,
        duration: duration,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final location in widget.locations)
          PlatformListTile(
            key: location.id == widget.primaryLocationId
                ? currentLocationKey
                : null,
            title: Text(location.name, maxLines: 2),
            subtitle: widget.primaryLocationId == location.id
                ? Text(context.t.homeScreen.primaryMembershipLocation)
                : null,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            leading: const Icon(Icons.pin_drop),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            trailing: loadingLocationId == location.id
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : null,
            onTap: loadingLocationId == null
                ? () async {
                    setState(() {
                      loadingLocationId = location.id;
                    });

                    try {
                      await ref.withClient(
                        (client) => MembershipRepository(client)
                            .updatePrimaryLocation(location.id),
                      );
                      ref.invalidate(membershipDetailsProvider);

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              context.t.primaryLocationScreen.updateSuccessful(
                                name: location.name,
                              ),
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                    } catch (_) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              context.t.signInScreen.errorMessages.genericError,
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                    } finally {
                      setState(() {
                        loadingLocationId = null;
                      });
                    }
                  }
                : null,
            selected: location.id == widget.primaryLocationId,
          ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  final String title;

  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
