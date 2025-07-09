import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:icons_plus/icons_plus.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("assets/icons/academia.png"),
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(12),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 320),
            child: Column(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Your school life. Fun.",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Login to your Academia account.",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),

                SizedBox(height: 16),
                OutlinedButton.icon(
                  iconAlignment: IconAlignment.start,
                  onPressed: () async {
                    final result = await FlutterWebAuth2.authenticate(
                      url: "http://127.0.0.1:8080/auth/google",
                      callbackUrlScheme: "academia",
                      options: FlutterWebAuth2Options(
                        windowName: "Academia | Authentication",
                      ),
                    );

                    // Extract token from resulting url
                    final token = Uri.parse(result).queryParameters['token'];
                    print(token);
                  },
                  label: Text("Continue with Google"),
                  icon: Icon(FontAwesome.google_brand),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  label: Text("Continue with Apple"),
                  icon: Icon(FontAwesome.apple_brand),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  label: Text("Continue with Microsoft"),
                  icon: Icon(FontAwesome.microsoft_brand),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  label: Text("Continue with Github"),
                  icon: Icon(FontAwesome.github_brand),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  label: Text("Continue with Spotify"),
                  icon: Icon(FontAwesome.spotify_brand),
                ),

                SizedBox(height: 22),
                Text.rich(
                  TextSpan(
                    text:
                        "By continuing, you acknowledge that you understand and agree to the",
                    children: [
                      TextSpan(
                        text: "Terms & conditions",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
