import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoWebView extends StatefulWidget {
  @override
  _VideoWebViewState createState() => _VideoWebViewState();
}

class _VideoWebViewState extends State<VideoWebView> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Vous pouvez utiliser cette partie pour afficher la progression du chargement, par exemple.
        },
        onPageStarted: (String url) {
          // Actions lorsque le chargement de la page commence.
        },
        onPageFinished: (String url) {
          // Actions lorsque le chargement de la page est terminé.
        },
        onHttpError: (HttpResponseError error) {
          // Gérer les erreurs HTTP ici.
        },
        onWebResourceError: (WebResourceError error) {
          // Gérer les erreurs de ressources ici, comme une absence de connexion.
        },
        onNavigationRequest: (NavigationRequest request) {
          // Empêcher uniquement certaines URLs non désirées d'être chargées
          if (!request.url.startsWith('https://ispapolytech.fr')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://ispapolytech.fr/television-ispa'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111745),
        actions: [
          GestureDetector(
              onTap: () {
                controller.reload();
              },
              child: const Icon(
                Icons.refresh_outlined,
                size: 30,
                color: Colors.white,
              )),
          const SizedBox(
            width: 15,
          ),
          GestureDetector(
              onTap: () {
                controller.goBack();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.white,
              )),
          const SizedBox(
            width: 15,
          ),
          GestureDetector(
              onTap: () {
                controller.goForward();
              },
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 30,
                color: Colors.white,
              )),
        ],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
