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
    final membershipDetails =
        ref.watch(membershipDetailsProvider).requireValue!;
    final primaryMembershipLocationId = membershipDetails.location.id;
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(title: context.t.primaryLocationScreen.header),
                        const SizedBox(height: 8),
                        Text(
                          membershipDetails.location.name,
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
                        return _LocationPickerList(
                          primaryLocationId: primaryMembershipLocationId,
                          locations: locations.sort(
                            (a, b) => a.name.compareTo(b.name),
                          ),
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

  _StickyHeaderDelegate({required this.child});

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
  double get maxExtent => 150; // Adjust to match your header size
  @override
  double get minExtent => 150; // Keep the height consistent
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
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
  LocationId? previousPrimaryLocationId;

  @override
  void didUpdateWidget(covariant _LocationPickerList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if the primary location has changed
    if (previousPrimaryLocationId != widget.primaryLocationId) {
      previousPrimaryLocationId = widget.primaryLocationId;

      // Scroll to the new location with animation
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (currentLocationKey.currentContext != null) {
          final scrollableState =
              Scrollable.of(currentLocationKey.currentContext!);
          final scrollPosition = scrollableState.position;

          final targetOffset = scrollPosition.pixels +
              (currentLocationKey.currentContext!.findRenderObject()!
                      as RenderBox)
                  .localToGlobal(Offset.zero)
                  .dy -
              (MediaQuery.of(context).size.height / 2);

          scrollPosition.animateTo(
            targetOffset,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (currentLocationKey.currentContext != null) {
        Scrollable.ensureVisible(
          currentLocationKey.currentContext!,
          alignment: 0.5,
        );
      }
    });

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
                      await ref.withClient((client) =>
                          MembershipRepository(client)
                              .updatePrimaryLocation(location.id));
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
