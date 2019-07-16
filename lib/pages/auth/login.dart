import 'package:flutter/material.dart';
import 'package:gghub/common/application.dart';
import 'package:gghub/widgets/browser.dart';
import 'package:webview_flutter/webview_flutter.dart';

const _loginUrl = 'https://github.com/login/oauth/authorize';
const _redirectUrl = 'https://iosgg.cn/login/success';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final url =
        '$_loginUrl?client_id=${Application().client.id}&redirect_uri=$_redirectUrl';
    return Browser(
      url: url,
      navigationDelegate: (request) {
        print(request.url);
        if (request.url == _redirectUrl) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }
}
