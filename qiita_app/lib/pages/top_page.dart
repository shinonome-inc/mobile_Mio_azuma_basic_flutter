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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_img.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
              onPressed: () {
                final Set<Factory<OneSequenceGestureRecognizer>>
                    gestureRecognizers = {
                  Factory(() => EagerGestureRecognizer())
                };

                UniqueKey key = UniqueKey();

                showAppBottomModalSheet(
                  context,
                  title: "Qiita Auth",
                  content: WebViewWidget(
                    gestureRecognizers: gestureRecognizers,
                    key: key,
                    controller: WebViewController()
                      ..setNavigationDelegate(
                        NavigationDelegate(
                          onNavigationRequest:
                              (NavigationRequest request) async {
                            if (request.url.contains('code=')) {
                              Uri uri = Uri.parse(request.url);
                              String? code = uri.queryParameters['code'];
                              if (code != null) {
                                print('Received code: $code');
                                await QiitaRepository.requestAccessToken(code);
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
      ),
    );
  }
}
