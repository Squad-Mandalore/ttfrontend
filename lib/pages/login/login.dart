import 'package:flutter/material.dart';
import 'package:ttfrontend/pages/login/widgets/divider.dart';
import 'package:ttfrontend/pages/login/widgets/emailInput.dart';
import 'package:ttfrontend/pages/login/widgets/loginButton.dart';
import 'package:ttfrontend/pages/login/widgets/passwordInput.dart';
import 'package:ttfrontend/pages/login/widgets/registerButton.dart';
import 'widgets/header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showHeader = true;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: height,
          width: width,

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/loginPage_logo.png'),
              fit: BoxFit.contain,
              alignment: Alignment.bottomRight,
            ),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            transform: Matrix4.translationValues(0, _showHeader ? 0 : -200, 0),
            child: Column(
              children: <Widget>[
                AnimatedOpacity(
                  opacity: _showHeader ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 300),
                  child: const Header(),
                ),
                const SizedBox(height: 30),
                EmailInput(
                  focusNode: _emailFocusNode,
                ),
                const SizedBox(height: 30),
                PasswordInput(
                  focusNode: _passwordFocusNode,
                ),
                const SizedBox(height: 50),
                LoginButton(
                  onPressed: () {
                    // login logic
                  },
                ),
                const SizedBox(height: 20),
                CustomDivider(),
                const SizedBox(height: 20),
                RegisterButton(
                  onPressed: () {
                    // registration logic
                  },
                ),
                SizedBox(height: height * 0.10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
