import 'package:evo/common/widgets/adaptive_bottom_sheet.dart';
import 'package:evo/common/widgets/list.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:evo/features/membership/models/membership_details.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KeysMenu extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keys = ref.read(membershipDetailsProvider).requireValue!.keys;

    return BottomSheetScrollableContainer(
      padding: const EdgeInsets.all(16.0),
      children: [
        ListSection(
          header: Text(context.t.homeScreen.shortcuts[0]),
          children: keys.map((key) {
            return _KeyInfoListTile(keyInfo: key);
          }).toList(),
        ),
        /*
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t.homeScreen.shortcuts[0],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            for (final key in keys) _KeyInfoCard(keyInfo: key),
          ],
        ),
           */
      ],
    );
  }
}

class _KeyInfoListTile extends StatelessWidget {
  final KeyInfo keyInfo;

  const _KeyInfoListTile({required this.keyInfo});

  @override
  Widget build(BuildContext context) {
    return PlatformListTile(
      onTap: () {},
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      leading: Padding(
        padding: Theme.of(context).platform == TargetPlatform.android
            ? const EdgeInsets.all(5.0)
            : EdgeInsets.zero,
        child: _KeyIcon(type: keyInfo.type),
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: _KeyTypeText(type: keyInfo.type),
      ),
      subtitle: Text(keyInfo.code),
    );
  }
}

class _KeyInfoCard extends StatelessWidget {
  final KeyInfo keyInfo;

  const _KeyInfoCard({required this.keyInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _KeyIcon(type: keyInfo.type),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(keyInfo.code),
              _KeyTypeText(type: keyInfo.type),
            ],
          )
        ],
      ),
    );
  }
}

class _KeyTypeText extends StatelessWidget {
  final String type;

  const _KeyTypeText({required this.type});

  @override
  Widget build(BuildContext context) {
    return Text(getTranslatedKeyType(context, type));
  }

  String getTranslatedKeyType(BuildContext context, String type) {
    switch (type) {
      case 'Rfid':
        return context.t.keyTypes.rfid;
      case 'PinCode':
        return context.t.keyTypes.pinCode;
      default:
        return context.t.keyTypes.unknown;
    }
  }
}

class _KeyIcon extends StatelessWidget {
  final String type;

  const _KeyIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(getIconForKeyType(type));
  }

  String getIconForKeyType(String type) {
    switch (type) {
      case 'Rfid':
        return rfidIcon;
      case 'PinCode':
        return pinCodeIcon;
      default:
        return keyIcon;
    }
  }
}

const rfidIcon = '''
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M9.348 14.652a3.75 3.75 0 0 1 0-5.304m5.304 0a3.75 3.75 0 0 1 0 5.304m-7.425 2.121a6.75 6.75 0 0 1 0-9.546m9.546 0a6.75 6.75 0 0 1 0 9.546M5.106 18.894c-3.808-3.807-3.808-9.98 0-13.788m13.788 0c3.808 3.807 3.808 9.98 0 13.788M12 12h.008v.008H12V12Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z" />
</svg>
''';

const pinCodeIcon = '''
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M5.25 8.25h15m-16.5 7.5h15m-1.8-13.5-3.9 19.5m-2.1-19.5-3.9 19.5" />
</svg>
''';

const keyIcon = '''
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 5.25a3 3 0 0 1 3 3m3 0a6 6 0 0 1-7.029 5.912c-.563-.097-1.159.026-1.563.43L10.5 17.25H8.25v2.25H6v2.25H2.25v-2.818c0-.597.237-1.17.659-1.591l6.499-6.499c.404-.404.527-1 .43-1.563A6 6 0 1 1 21.75 8.25Z" />
</svg>
''';
