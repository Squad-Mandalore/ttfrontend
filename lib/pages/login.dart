import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/colours.dart';
import 'package:ttfrontend/modules/widgets/custom_button.dart';
import 'package:ttfrontend/modules/widgets/custom_input.dart';
import '../modules/utilities/custom_painter_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showHeader = true; // State to control the visibility of the header
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  double _topPadding = 0;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_focusListener);
    _passwordFocusNode.addListener(_focusListener);
  }

  void _focusListener() {
    if (_emailFocusNode.hasFocus || _passwordFocusNode.hasFocus) {
      if (_showHeader) {
        setState(() {
          _topPadding = 50.0;
          _showHeader = false;
        });
      }
    } else {
      if (!_showHeader) {
        setState(() {
          _topPadding = 0;
          _showHeader = true;
        });
      }
    }
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
    return Scaffold(
      body: Container(
        color: AppColours.bgDark,
        child: Center(
            child: Padding(
          padding: EdgeInsets.only(top: _topPadding),
          child: Column(
            children: [
              if (_showHeader)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 230,
                      child: CustomPaint(
                        painter: HeaderPainter(
                            backgroundColor: AppColours.greenPrimary),
                      ),
                    ),
                    Text(
                      'Schmidt\'s \nHandwerksbetrieb',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'ntn',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 30),
              Container(
                width: 280,
                alignment: Alignment.centerLeft,
                child: Text(
                  'E-Mail',
                  style: TextStyle(
                    fontFamily: 'ntn',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomInput(
                hintText: 'Arbeits E-Mail Adresse',
                width: 280,
                height: 50,
                focusNode: _emailFocusNode,
              ),
              const SizedBox(height: 30),
              Container(
                width: 280,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Passwort',
                  style: TextStyle(
                    fontFamily: 'ntn',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomInput(
                hintText: 'Passwort',
                width: 280,
                height: 50,
                focusNode: _passwordFocusNode,
              ),
              const SizedBox(height: 50),
              CustomButton(
                iconData: Icons.login,
                buttonText: 'Anmelden',
                buttonColour: AppColours.greenPrimary,
                buttonHeight: 50,
                buttonWidth: 280,
                textSize: 25,
              ),
              const SizedBox(height: 20),
              Divider(
                color: AppColours.inputBoxDark,
                thickness: 2,
                indent: 50,
                endIndent: 50,
              ),
              const SizedBox(height: 20),
              CustomButton(
                borderColor: Colors.white,
                buttonText: 'Registrieren',
                buttonColour: AppColours.magenta,
                buttonHeight: 50,
                buttonWidth: 280,
                textSize: 25,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
