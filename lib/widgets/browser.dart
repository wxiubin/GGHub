import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatefulWidget {
  Browser({
    @required this.url,
    this.navigationDelegate,
  });

  final String url;
  final NavigationDelegate navigationDelegate;

  @override
  State<StatefulWidget> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
      navigationDelegate: widget.navigationDelegate,
    );
  }
}
