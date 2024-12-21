import 'dart:async';

import 'package:evo/common/widgets/evo_elevated_button.dart';
import 'package:evo/features/auth/views/sign_in_screen.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.6,
            child: const WebViewWidget(),
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
}

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({super.key});

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  InAppWebViewController? webViewController;
  bool showImage = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();

    Timer(const Duration(seconds: 1), () {
      setState(() {
        showImage = false;
      });
    });
  }

  void _initializeWebView() {
    const String videoId = 'yvBQVE_FoaY';
    const String videoUrl =
        'https://www.youtube.com/embed/$videoId?controls=0&rel=0&playsinline=1&autoplay=1&disablekb=0&fs=0&iv_load_policy=0&loop=1&playlist=$videoId&enablejsapi=1';

    webViewController?.loadUrl(
      urlRequest: URLRequest(url: WebUri(videoUrl)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final double scale = size.height / size.width < 1.5 ? 1.8 : 2.35;
    final String htmlData = '''
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
      transform: translate(-50%, -50%) scale($scale); /* Dynamic scale */
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
</body>
</html>
''';

    return Stack(
      children: [
        // WebView is always in the widget tree, but its opacity is managed
        AnimatedOpacity(
          opacity: showImage ? 0 : 1,
          duration: const Duration(seconds: 1),
          child: InAppWebView(
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
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
          ),
        ),
        // Placeholder image is always in the widget tree but fades out
        AnimatedOpacity(
          opacity: showImage ? 1 : 0,
          duration: const Duration(seconds: 1),
          child: Image.asset(
            'assets/images/showcase.jpg', // Replace with your placeholder image
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ],
    );
  }
}
