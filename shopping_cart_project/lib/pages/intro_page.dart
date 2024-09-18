import 'package:flutter/material.dart';
import 'package:shopping_cart_project/pages/sign_in_page.dart';
import 'package:shopping_cart_project/pages/sign_up_page.dart';
import 'package:shopping_cart_project/widget/custom_button.dart';
import 'package:shopping_cart_project/widget/custom_scaffold.dart';
import 'package:shopping_cart_project/widget/theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0,
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: 'Welcome Back!\n',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins'
                            )),
                        TextSpan(
                            text:
                            '\nEnter your details below to save time and place your order.',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'SpaceGrotesk',
                            ))
                      ],
                    ),
                  ),
                ),
              )),
          Flexible(
            flex: 0,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  const Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign in',
                      onTap: SignInScreen(),
                      color: Colors.transparent,
                      textColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign up',
                      onTap: const SignUpScreen(),
                      color: Colors.white,
                      textColor: lightColorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
