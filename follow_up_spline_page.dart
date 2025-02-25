import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// Replace with your actual OpenAI API key.
const String OPENAI_API_KEY = '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';

class FollowUpSplinePage extends StatefulWidget {
  const FollowUpSplinePage({Key? key}) : super(key: key);

  @override
  State<FollowUpSplinePage> createState() => _FollowUpSplinePageState();
}

class _FollowUpSplinePageState extends State<FollowUpSplinePage> {
  late final WebViewController _webViewController;
  final TextEditingController _inputController = TextEditingController();
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();

    // Create and configure the WebViewController.
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'FluWebViewChannel',
        onMessageReceived: (JavaScriptMessage message) {
          final data = jsonDecode(message.message);
          if (data['action'] == 'text_clicked') {
            _generateFollowUp();
          }
        },
      );

    // Load the local HTML file containing the Spline viewer.
    _loadHtmlFromAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Spline scene as the full background.
          WebViewWidget(controller: _webViewController),
          // Transparent text input overlay at the bottom.
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white54),
              ),
              child: TextField(
                controller: _inputController,
                style: GoogleFonts.shareTechMono(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your statement...',
                  hintStyle: GoogleFonts.shareTechMono(
                    color: Colors.white70,
                    fontWeight: FontWeight.w300,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Loads the updated spline_interactive.html from assets and displays it in the WebView.
  Future<void> _loadHtmlFromAssets() async {
    final fileHtmlContents = await DefaultAssetBundle.of(context)
        .loadString('assets/spline_interactive.html');
    final base64Html =
    base64Encode(const Utf8Encoder().convert(fileHtmlContents));
    _webViewController.loadRequest(
      Uri.parse('data:text/html;base64,$base64Html'),
    );
  }

  /// Generates a follow-up question using OpenAI and updates the Spline overlay.
  Future<void> _generateFollowUp() async {
    final statement = _inputController.text.trim();
    if (statement.isEmpty) return;

    setState(() {
      _isGenerating = true;
    });

    final prompt = 'Generate a follow-up question for: "$statement"';
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $OPENAI_API_KEY',
        },
        body: jsonEncode({
          'model': 'gpt-4',
          'messages': [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt},
          ],
          'max_tokens': 50,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final generatedText = data['choices'][0]['message']['content'].trim();
        setState(() {
          _isGenerating = false;
        });
        // Update the Spline overlay via JavaScript.
        final jsCommand =
            "window.updateSplineText(${jsonEncode(generatedText)});";
        _webViewController.runJavaScript(jsCommand);
      } else {
        setState(() {
          _isGenerating = false;
        });
        print('Error: ${response.statusCode}\n${response.body}');
      }
    } catch (e, stacktrace) {
      setState(() {
        _isGenerating = false;
      });
      print("Exception: $e\nStacktrace: $stacktrace");
    }
  }
}
