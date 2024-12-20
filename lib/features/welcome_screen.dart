import 'package:evo/common/widgets/evo_elevated_button.dart';
import 'package:evo/features/auth/views/sign_in_screen.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    mediaPlaybackRequiresUserGesture: false,
    preferredContentMode: UserPreferredContentMode.MOBILE,
    ignoresViewportScaleLimits: true,
    initialScale: 2,
    disableContextMenu: true,
    disableHorizontalScroll: true,
    disableVerticalScroll: true,
    disableLongPressContextMenuOnLinks: true,
    allowsInlineMediaPlayback: true,
    iframeAllow: 'autoplay;',
    iframeAllowFullscreen: true,
  );

  @override
  void initState() {
    super.initState();
    _initializeWebView();
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
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.7,
            child: InAppWebView(
              initialData: InAppWebViewInitialData(
                data: """
          <!DOCTYPE html>
          <html>
          <head>
            <style>
              body {
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #000;
                position: relative;
              }
              iframe {
                width: 1422.22px;
                height: 800px;
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
                class="elementor-background-video-embed"
                frameborder="0"
                allowfullscreen
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                referrerpolicy="strict-origin-when-cross-origin"
                title="EVO - WEB bannervideo"
                id="widget2"
                src="https://www.youtube.com/embed/yvBQVE_FoaY?controls=0&rel=0&playsinline=1&autoplay=1&disablekb=0&fs=0&iv_load_policy=0&loop=1&playlist=yvBQVE_FoaY&enablejsapi=1"
              ></iframe>
              <div class="overlay"></div>
            </div>
          </body>
          </html>
          """,
              ),
              initialSettings: settings,
              gestureRecognizers: const {},
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onPermissionRequest: (controller, request) async {
                return PermissionResponse(
                  resources: request.resources,
                  action: PermissionResponseAction.GRANT,
                );
              },
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
    InAppWebViewController.clearAllCache();
  }
}
