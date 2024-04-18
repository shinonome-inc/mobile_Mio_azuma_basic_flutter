import 'package:flutter/material.dart';
import 'package:qiita_app/widgets/rounded_edge_button.dart';

import '../constants/app_colors.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({Key? key, required this.onPressReload}) : super(key: key);
  final Function() onPressReload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 160.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(
                      'assets/Network.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 36),
                  const Text(
                    'ネットワークエラー',
                    style: TextStyle(
                      fontFamily: 'Noto Sans JP',
                      fontSize: 14,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "お手数ですが電波の良い場所で\n再度読み込みをお願いします",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Noto Sans JP',
                      fontSize: 12,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: RoundedEdgeButton(
                  text: "再読み込みする",
                  backgroundColor: AppColors.primary,
                  elevation: 2,
                  onPressed: onPressReload,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
