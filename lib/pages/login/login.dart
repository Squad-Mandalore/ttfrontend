import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/pages/home_page.dart';
// import 'package:ttfrontend/pages/login/widgets/divider.dart';
import 'package:ttfrontend/pages/login/widgets/email_input.dart';
import 'package:ttfrontend/pages/login/widgets/login_button.dart';
import 'package:ttfrontend/pages/login/widgets/password_input.dart';
// import 'package:ttfrontend/pages/login/widgets/register_button.dart';
import '../../service/api_service.dart';
import '../../service/log_service.dart';
import 'widgets/header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _showHeader = true;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_focusListener);
    _passwordFocusNode.addListener(_focusListener);
  }

  void _focusListener() {
    bool isAnyFieldFocused =
        _emailFocusNode.hasFocus || _passwordFocusNode.hasFocus;
    setState(() {
      _showHeader = !isAnyFieldFocused;
    });
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_focusListener);
    _passwordFocusNode.removeListener(_focusListener);
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    bool shouldShowHeader = _showHeader && height >= 800;

    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();

    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: customColors?.backgroundColor,
            image: DecorationImage(
              image: const AssetImage(
                  'lib/assets/images/loginPage_logo_grey.png'),
              fit: BoxFit.contain,
              alignment: Alignment.bottomRight,
              opacity: 0.2,
              colorFilter: ColorFilter.mode(
                  theme.colorScheme.surface, BlendMode.softLight),
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: shouldShowHeader ? 0 : 100),
              AnimatedOpacity(
                opacity: shouldShowHeader ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child:
                    shouldShowHeader ? const Header() : const SizedBox.shrink(),
              ),
              SizedBox(height: shouldShowHeader ? 30 : 0),
              EmailInput(
                controller: _emailController,
                focusNode: _emailFocusNode,
              ),
              const SizedBox(height: 30),
              PasswordInput(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 50),
              LoginButton(
                onPressed: () async {
                  apiService.login(_emailController.text, _passwordController.text)
                  .then((response) => {
                    // Token will be saved internally in api_service.dart
                    log("Login has been successful"),
                    // Login on Success
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute
                    (builder: (context) => const HomePage()),
                    )
                  }).catchError((error) =>
                  {
                    if(context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('E-Mail-Adresse oder Passwort ungültig')),
                    ),
                    print("Login invalid: $error")
                    }
                  });
              
                },
              ),
              // const SizedBox(height: 25),
              // const CustomDivider(),
              // const SizedBox(height: 25),
              // RegisterButton(
              //   onPressed: () {
              //     // registration logic
              //   },
              // ),
              SizedBox(height: height * 0.10),
            ],
          ),
        ),
      ),
    );
  }
}
