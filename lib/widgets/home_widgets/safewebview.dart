import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SafeWebview extends StatefulWidget {
  final String? url;
  const SafeWebview({Key? key, this.url}) : super(key: key);

  @override
  State<SafeWebview> createState() => _SafeWebviewState();
}

class _SafeWebviewState extends State<SafeWebview> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)

      // ✅ Force mobile user agent
      ..setUserAgent(
        'Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 '
        '(KHTML, like Gecko) Chrome/120.0 Mobile Safari/537.36',
      )

      // ✅ Inject viewport meta tag
      ..runJavaScript(
        '''
        var meta = document.createElement('meta');
        meta.name = 'viewport';
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
        document.getElementsByTagName('head')[0].appendChild(meta);
        ''',
      )

      // ✅ Load URL
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (_) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.url ?? 'https://flutter.dev'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Web View')),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),

          // ✅ Loading indicator
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
