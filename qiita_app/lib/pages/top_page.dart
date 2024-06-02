import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qiita_app/constants/app_colors.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/widgets/app_bottom_modal_sheet.dart';
import 'package:qiita_app/widgets/bottom_navigation.dart';
import 'package:qiita_app/widgets/rounded_edge_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  bool isLoading = false; // ローディング状態を管理
  Widget loginLoading() {
    return BackdropFilter(
      filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background_img.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              const Spacer(),
              const Text(
                'Qiita Feed App',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 36,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Play Ground',
                style: TextStyle(
                  fontFamily: 'Noto Sans JP',
                  fontSize: 14,
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              RoundedEdgeButton(
                text: "ログイン",
                backgroundColor: AppColors.primary,
                elevation: 2,
                onPressed: () async {
                  final Set<Factory<OneSequenceGestureRecognizer>>
                      gestureRecognizers = {
                    Factory(() => EagerGestureRecognizer())
                  };

                  showAppBottomModalSheet(
                    context,
                    title: "Qiita Auth",
                    content: WebViewWidget(
                      gestureRecognizers: gestureRecognizers,
                      controller: WebViewController()
                        ..setNavigationDelegate(
                          NavigationDelegate(
                            onNavigationRequest:
                                (NavigationRequest request) async {
                              if (request.url.contains('github.com/login') ||
                                  request.url
                                      .contains('api.twitter.com/oauth') ||
                                  request.url.contains('accounts.google.com')) {
                                return NavigationDecision.prevent;
                              }

                              if (request.url.contains('code=')) {
                                Uri uri = Uri.parse(request.url);
                                String? code = uri.queryParameters['code'];
                                if (code != null) {
                                  if (kDebugMode) {
                                    print('Received code: $code');
                                  }
                                  await QiitaRepository.requestAccessToken(
                                      code);
                                  setState(() {
                                    isLoading = true; // ローディング開始
                                  });
                                  if (!context.mounted) {
                                    return NavigationDecision.prevent;
                                  }
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavigation(),
                                    ),
                                  );
                                }
                                return NavigationDecision.prevent;
                              }
                              return NavigationDecision.navigate;
                            },
                          ),
                        )
                        ..loadRequest(
                          Uri.parse(
                              'https://qiita.com/api/v2/oauth/authorize?client_id=${dotenv.env['CLIENT_ID']}&scope=read_qiita'),
                        ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              RoundedEdgeButton(
                text: "ログインせずに利用する",
                backgroundColor: Colors.transparent,
                textColor: AppColors.white,
                elevation: 0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigation(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 64),
            ],
          ),
          // isLoadingがtrueの場合、ローディング画面を表示します
          if (isLoading) loginLoading(),
        ],
      ),
    );
  }
}
