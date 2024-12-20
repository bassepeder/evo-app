import 'package:evo/common/widgets/evo_elevated_button.dart';
import 'package:evo/features/auth/views/sign_in_screen.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late WebViewController webController;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    late PlatformWebViewControllerCreationParams params;
    const String videoUrl =
        'https://www.youtube.com/embed/yvBQVE_FoaY?controls=0&rel=0&playsinline=1&enablejsapi=1';

    // Check if the platform is Android or iOS and apply specific settings
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      // iOS/macOS-specific parameters
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true, // Autoplay and inline video
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{}, // Disable user interaction for media playback
      );
    } else {
      // Android-specific parameters
      params = const PlatformWebViewControllerCreationParams();
    }

    // Create WebView controller
    webController = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(videoUrl),
      );

    if (webController.platform is AndroidWebViewController) {
      (webController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.7,
            child: WebViewWidget(
              gestureRecognizers: const {},
              controller: webController,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${context.t.welcomeScreen.welcomeHeader} ',
                textAlign: TextAlign.center,
                style: textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Image.asset(
                'assets/images/logo.png',
                width: 70,
                height: 70,
              ),
            ],
          ),
          Text(
            context.t.welcomeScreen.subtitle,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge!.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.64),
            ),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: EvoElevatedButton(
              onPressed: () => pushPlatformRoute(
                context,
                builder: (_) => const SignInScreen(),
              ),
              text: context.t.welcomeScreen.signInButton.toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    webController.clearCache(); // Clear WebView cache on dispose
  }
}
