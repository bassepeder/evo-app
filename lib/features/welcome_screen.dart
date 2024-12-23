import 'dart:async';

import 'package:evo/app.dart';
import 'package:evo/common/widgets/evo_elevated_button.dart';
import 'package:evo/features/auth/views/sign_in_screen.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/network/connectivity.dart';
import 'package:evo/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> with RouteAware {
  InAppWebViewController? webViewController;
  bool showWebView = false;

  static const String htmlData = '''
<!DOCTYPE html>
<html>
<head>
  <style>
    html, body {
      margin: 0;
      padding: 0;
      height: 100%;
      width: 100%;
      background-color: #000;
      overflow: hidden;
    }
    .video-container {
      position: relative;
      width: 100%;
      height: 100%;
      overflow: hidden;
    }
    iframe {
      position: absolute;
      top: 50%;
      left: 50%;
      width: 100%;
      height: 100%;
      transform: translate(-50%, -50%) scale(2.35); /* Adjust scale if needed */
      border: none;
    }
    .overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: transparent;
      z-index: 10;
    }
  </style>
</head>
<body>
 <div class="video-container">
    <iframe 
      src="https://www.youtube.com/embed/yvBQVE_FoaY?controls=0&rel=0&playsinline=1&autoplay=1&disablekb=0&fs=0&iv_load_policy=0&loop=1&playlist=yvBQVE_FoaY&enablejsapi=1"
      allow="autoplay; fullscreen"
      frameborder="0"
    ></iframe>
    <div class="overlay"></div> <!-- This blocks interaction -->
  </div>
</body>
</html>
''';

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      setState(() {
        showWebView = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null && route is PageRoute) {
      rootNavPageRouteObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    rootNavPageRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() => webViewController?.loadData(data: htmlData);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);

    final connectivityStatus = ref.watch(connectivityChangesProvider);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.6,
            child: Stack(
              children: [
                AnimatedOpacity(
                  opacity: showWebView ? 0 : 1,
                  duration: const Duration(seconds: 1),
                  child: Image.asset(
                    'assets/images/showcase.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                AnimatedOpacity(
                  opacity: showWebView ? 1 : 0,
                  duration: const Duration(seconds: 1),
                  child: WebViewWidget(
                    htmlData: htmlData,
                    onWebViewCreated: (controller) =>
                        webViewController = controller,
                  ),
                ),
              ],
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
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.64),
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
}

class WebViewWidget extends StatelessWidget {
  final String htmlData;
  final void Function(InAppWebViewController) onWebViewCreated;

  const WebViewWidget({
    super.key,
    required this.htmlData,
    required this.onWebViewCreated,
  });

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialData: InAppWebViewInitialData(
        data: htmlData,
      ),
      initialSettings: InAppWebViewSettings(
        mediaPlaybackRequiresUserGesture: false,
        preferredContentMode: UserPreferredContentMode.MOBILE,
        ignoresViewportScaleLimits: true,
        disableContextMenu: true,
        disableHorizontalScroll: true,
        disableVerticalScroll: true,
        disableLongPressContextMenuOnLinks: true,
        allowsInlineMediaPlayback: true,
        iframeAllow: 'autoplay;',
        iframeAllowFullscreen: true,
      ),
      onWebViewCreated: onWebViewCreated,
    );
  }
}
