import 'package:app_settings/app_settings.dart';
import 'package:evo/common/widgets/adaptive_choice_picker.dart';
import 'package:evo/common/widgets/themed_icon.dart';
import 'package:evo/features/auth/providers/auth_session.dart';
import 'package:evo/features/settings/app_background_mode_screen.dart';
import 'package:evo/features/settings/brightness.dart';
import 'package:evo/features/settings/general_preferences.dart';
import 'package:evo/features/settings/views/current_referral_screen.dart';
import 'package:evo/features/settings/views/membership_details_screen.dart';
import 'package:evo/features/settings/views/payment_information_screen.dart';
import 'package:evo/features/settings/views/primary_location_screen.dart';
import 'package:evo/features/settings/views/profile_information_screen.dart';
import 'package:evo/features/welcome_screen.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generalPrefs = ref.watch(generalPreferencesProvider);
    final brightness = ref.watch(currentBrightnessProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.settingsScreen.appBar),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(title: context.t.settingsScreen.accountMenuItems.header),
                const SizedBox(height: 8),
                SettingsListItem(
                  svgSrc: profileIconSvg,
                  title: context.t.settingsScreen.accountMenuItems
                      .profileInformation.title,
                  subTitle: context.t.settingsScreen.accountMenuItems
                      .profileInformation.subtitle,
                  currentBrightness: brightness,
                  onClick: () => pushPlatformRoute(
                    context,
                    builder: (_) => const ProfileInformationScreen(),
                  ),
                ),
                SettingsListItem(
                  svgSrc: membershipIconSvg,
                  title: context.t.settingsScreen.accountMenuItems
                      .membershipDetails.title,
                  subTitle: context.t.settingsScreen.accountMenuItems
                      .membershipDetails.subtitle,
                  currentBrightness: brightness,
                  onClick: () => pushPlatformRoute(
                    context,
                    builder: (_) => const MembershipDetailsScreen(),
                  ),
                ),
                SettingsListItem(
                  svgSrc: cardIconSvg,
                  title:
                      context.t.settingsScreen.accountMenuItems.payment.title,
                  subTitle: context
                      .t.settingsScreen.accountMenuItems.payment.subtitle,
                  currentBrightness: brightness,
                  onClick: () => pushPlatformRoute(
                    context,
                    builder: (_) => const PaymentInformationScreen(),
                  ),
                ),
                SettingsListItem(
                  svgSrc: markerIconSvg,
                  title:
                      context.t.settingsScreen.accountMenuItems.locations.title,
                  subTitle: context
                      .t.settingsScreen.accountMenuItems.locations.subtitle,
                  currentBrightness: brightness,
                  onClick: () => pushPlatformRoute(
                    context,
                    builder: (_) => const PrimaryLocationScreen(),
                  ),
                ),
                SettingsListItem(
                  svgSrc: referralIconSvg,
                  title:
                      context.t.settingsScreen.accountMenuItems.referral.title,
                  subTitle: context
                      .t.settingsScreen.accountMenuItems.referral.subtitle,
                  currentBrightness: brightness,
                  onClick: () => pushPlatformRoute(
                    context,
                    builder: (_) => const CurrentReferralScreen(),
                  ),
                ),
                SettingsListItem(
                  svgSrc: signOutSvg,
                  title:
                      context.t.settingsScreen.accountMenuItems.signOut.title,
                  subTitle: context
                      .t.settingsScreen.accountMenuItems.signOut.subtitle,
                  showNavigationIcon: false,
                  currentBrightness: brightness,
                  onClick: () {
                    ref.read(authSessionProvider.notifier).delete();
                    pushAndRemoveUntilPlatformRoute(
                      context,
                      builder: (_) => const WelcomeScreen(),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Header(title: context.t.settingsScreen.appMenuItems.header),
                const SizedBox(height: 8),
                SettingsListItem(
                  svgSrc: brightnessSvg,
                  title: context.t.settingsScreen.appMenuItems.appTheme.title,
                  subTitle:
                      context.t.settingsScreen.appMenuItems.appTheme.subtitle,
                  showNavigationIcon: false,
                  currentBrightness: brightness,
                  onClick: () {
                    if (Theme.of(context).platform == TargetPlatform.android) {
                      showChoicePicker(
                        context,
                        choices: BackgroundThemeMode.values,
                        selectedItem: generalPrefs.themeMode,
                        labelBuilder: (t) => Text(
                          AppBackgroundModeScreen.themeTitle(context, t),
                        ),
                        onSelectedItemChanged: (BackgroundThemeMode? value) =>
                            ref
                                .read(generalPreferencesProvider.notifier)
                                .setThemeMode(
                                  value ?? BackgroundThemeMode.system,
                                ),
                      );
                    } else {
                      pushPlatformRoute(
                        context,
                        title: context
                            .t.settingsScreen.appMenuItems.appTheme.title,
                        builder: (context) => const AppBackgroundModeScreen(),
                      );
                    }
                  },
                ),
                /*
                if (Theme.of(context).platform == TargetPlatform.android)
                  androidVersionAsync.maybeWhen(
                    data: (version) => version != null && version.sdkInt >= 31
                        ? SwitchSettingTile(
                            leading: const Icon(Icons.colorize_outlined),
                            title: Text(context.t.settingsScreen.appMenuItems
                                .systemColors.title,),
                            subtitle: Text(context.t.settingsScreen.appMenuItems
                                .systemColors.subtitle,),
                            value: generalPrefs.systemColors,
                            onChanged: (value) {
                              ref
                                  .read(generalPreferencesProvider.notifier)
                                  .toggleSystemColors();
                            },
                          )
                        : const SizedBox.shrink(),
                    orElse: () => const SizedBox.shrink(),
                  ),
                 */
                SettingsListItem(
                  svgSrc: languageSvg,
                  title: context.t.settingsScreen.appMenuItems.locale.title,
                  subTitle:
                      context.t.settingsScreen.appMenuItems.locale.subtitle,
                  showNavigationIcon: false,
                  currentBrightness: brightness,
                  onClick: () {
                    if (Theme.of(context).platform == TargetPlatform.android) {
                      showChoicePicker<Locale>(
                        context,
                        choices: AppLocaleUtils.supportedLocales,
                        selectedItem: generalPrefs.locale ??
                            Localizations.localeOf(context),
                        labelBuilder: (t) => Text(
                          context.t.settingsScreen.appMenuItems.locale
                              .optionsMap[t.languageCode]!,
                        ),
                        onSelectedItemChanged: (Locale? locale) => ref
                            .read(generalPreferencesProvider.notifier)
                            .setLocale(locale),
                      );
                    } else {
                      AppSettings.openAppSettings();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
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
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class SettingsListItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String svgSrc;
  final bool showNavigationIcon;
  final VoidCallback onClick;
  final Brightness currentBrightness;

  const SettingsListItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.svgSrc,
    required this.onClick,
    required this.currentBrightness,
    this.showNavigationIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              if (currentBrightness == Brightness.dark)
                ThemedIcon(svgData: svgSrc)
              else
                SvgPicture.string(
                  svgSrc,
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    const Color(0xFF010F07).withValues(alpha: 0.64),
                    BlendMode.srcIn,
                  ),
                ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subTitle,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.54),
                      ),
                    ),
                  ],
                ),
              ),
              if (showNavigationIcon) ...[
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

const profileIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M8.66667 7.83333C8.66667 9.67428 10.1591 11.1667 12 11.1667C13.8409 11.1667 15.3333 9.67428 15.3333 7.83333C15.3333 5.99238 13.8409 4.5 12 4.5C10.1591 4.5 8.66667 5.99238 8.66667 7.83333ZM11.9861 12.8333C8.05159 12.8333 4.82355 14.8554 4.50054 18.8327C4.48295 19.0493 4.89726 19.5 5.10625 19.5H18.8722C19.4983 19.5 19.508 18.9962 19.4983 18.8333C19.2541 14.7443 15.976 12.8333 11.9861 12.8333Z" fill="#010F07"/>
</svg>
''';

const membershipIconSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M11.48 3.499a.562.562 0 0 1 1.04 0l2.125 5.111a.563.563 0 0 0 .475.345l5.518.442c.499.04.701.663.321.988l-4.204 3.602a.563.563 0 0 0-.182.557l1.285 5.385a.562.562 0 0 1-.84.61l-4.725-2.885a.562.562 0 0 0-.586 0L6.982 20.54a.562.562 0 0 1-.84-.61l1.285-5.386a.562.562 0 0 0-.182-.557l-4.204-3.602a.562.562 0 0 1 .321-.988l5.518-.442a.563.563 0 0 0 .475-.345L11.48 3.5Z" />
</svg>
''';

const lockIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M17 10C18.1046 10 19 10.8954 19 12V18C19 19.1046 18.1046 20 17 20H7C5.89543 20 5 19.1046 5 18V12C5 10.8954 5.89543 10 7 10V9C7 6.23858 9.23858 4 12 4C14.7614 4 17 6.23858 17 9V10ZM12 6C10.3431 6 9 7.34315 9 9V10H15V9C15 7.34315 13.6569 6 12 6Z" fill="#010F07"/>
</svg>
''';

const cardIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M3.66669 7.83334C3.66669 6.91287 4.41288 6.16667 5.33335 6.16667H18.6667C19.5872 6.16667 20.3334 6.91286 20.3334 7.83334V8.66667H3.66669V7.83334ZM3.66669 11.1667H20.3334V16.1667C20.3334 17.0871 19.5872 17.8333 18.6667 17.8333H5.33335C4.41288 17.8333 3.66669 17.0871 3.66669 16.1667V11.1667ZM16.1667 13.6667C15.7065 13.6667 15.3334 14.0398 15.3334 14.5C15.3334 14.9602 15.7064 15.3333 16.1667 15.3333H17.8334C18.2936 15.3333 18.6667 14.9602 18.6667 14.5C18.6667 14.0398 18.2936 13.6667 17.8334 13.6667H16.1667Z" fill="#010F07"/>
</svg>
''';

const markerIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M6.16666 10.75C6.16666 7 8.66666 4.5 12.4167 4.5C16.1667 4.5 18.6667 7.625 18.6667 10.75C18.6667 12.6938 16.853 15.3631 13.2258 18.7577C12.7628 19.191 12.0487 19.209 11.5645 18.7996C7.96595 15.7565 6.16666 13.0733 6.16666 10.75ZM12.4167 12C13.5672 12 14.5 11.0673 14.5 9.91667C14.5 8.76607 13.5672 7.83333 12.4167 7.83333C11.2661 7.83333 10.3333 8.76607 10.3333 9.91667C10.3333 11.0673 11.2661 12 12.4167 12Z" fill="#010F07"/>
</svg>
''';

const referralIconSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="#010F07" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M18 18.72a9.094 9.094 0 0 0 3.741-.479 3 3 0 0 0-4.682-2.72m.94 3.198.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0 1 12 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 0 1 6 18.719m12 0a5.971 5.971 0 0 0-.941-3.197m0 0A5.995 5.995 0 0 0 12 12.75a5.995 5.995 0 0 0-5.058 2.772m0 0a3 3 0 0 0-4.681 2.72 8.986 8.986 0 0 0 3.74.477m.94-3.197a5.971 5.971 0 0 0-.94 3.197M15 6.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm6 3a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Zm-13.5 0a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Z" />
</svg>
''';

const signOutSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 9V5.25A2.25 2.25 0 0 1 10.5 3h6a2.25 2.25 0 0 1 2.25 2.25v13.5A2.25 2.25 0 0 1 16.5 21h-6a2.25 2.25 0 0 1-2.25-2.25V15m-3 0-3-3m0 0 3-3m-3 3H15" />
</svg>
''';

const brightnessSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v2.25m6.364.386-1.591 1.591M21 12h-2.25m-.386 6.364-1.591-1.591M12 18.75V21m-4.773-4.227-1.591 1.591M5.25 12H3m4.227-4.773L5.636 5.636M15.75 12a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0Z" />
</svg>
''';

const languageSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="m10.5 21 5.25-11.25L21 21m-9-3h7.5M3 5.621a48.474 48.474 0 0 1 6-.371m0 0c1.12 0 2.233.038 3.334.114M9 5.25V3m3.334 2.364C11.176 10.658 7.69 15.08 3 17.502m9.334-12.138c.896.061 1.785.147 2.666.257m-4.589 8.495a18.023 18.023 0 0 1-3.827-5.802" />
</svg>
''';
