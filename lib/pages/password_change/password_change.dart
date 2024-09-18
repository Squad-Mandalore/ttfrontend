import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/pages/home_page.dart';
import 'package:ttfrontend/pages/password_change/widgets/change_password.dart';
import 'package:ttfrontend/pages/password_change/widgets/new_password_input.dart';
import 'package:ttfrontend/pages/password_change/widgets/new_password_repeat_input.dart';
import '../../service/api_service.dart';
import '../../service/models/graphql_query.dart';
import 'widgets/header.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<PasswordChangePage> {
  bool _showHeader = true;
  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _newPasswordRepeatFocusNode = FocusNode();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordRepeatController =
      TextEditingController();
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _newPasswordFocusNode.addListener(_focusListener);
    _newPasswordRepeatFocusNode.addListener(_focusListener);
  }

  void _focusListener() {
    bool isAnyFieldFocused =
        _newPasswordFocusNode.hasFocus || _newPasswordRepeatFocusNode.hasFocus;
    setState(() {
      _showHeader = !isAnyFieldFocused;
    });
  }

  @override
  void dispose() {
    _newPasswordFocusNode.removeListener(_focusListener);
    _newPasswordRepeatFocusNode.removeListener(_focusListener);
    _newPasswordFocusNode.dispose();
    _newPasswordRepeatFocusNode.dispose();
    _newPasswordController.dispose();
    _newPasswordRepeatController.dispose();
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
              NewPasswortInput(
                controller: _newPasswordController,
                focusNode: _newPasswordFocusNode,
              ),
              const SizedBox(height: 30),
              NewPasswordRepeatInput(
                controller: _newPasswordRepeatController,
                focusNode: _newPasswordRepeatFocusNode,
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 50),
              ChangePasswordButton(
                onPressed: () async {
                  if (_newPasswordController.text ==
                      _newPasswordRepeatController.text) {
                    apiService
                        .graphQLRequest(GraphQLQuery(
                            query:
                                r"mutation updatePassword($newPasswortLol: String!) {updatePassword(newPassword: $newPasswortLol) {initialPassword}}",
                            variables: {
                              "newPasswortLol":
                                  _newPasswordRepeatController.text
                            }))
                        .then((response) => {
                              if (response.data?["updatePassword"]
                                  ["initialPassword"])
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Backend did do smth wrong. Blame Ben.')),
                                  ),
                                }
                              else
                                {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                  )
                                }
                            })
                        .catchError((error) => {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'E-Mail-Adresse oder Passwort ungültig')),
                              ),
                              print("Login invalid: $error")
                            });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Passwörter stimmen nicht überein')),
                    );
                  }
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
