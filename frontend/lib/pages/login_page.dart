import 'package:flutter/material.dart';
import 'package:frontend/extension/context_extensions.dart';
import 'package:frontend/pages/chat_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.whiteColor,
      body: const Stack(
        clipBehavior: Clip.none,
        children: [
          // SizedBox(
          //   width: double.infinity,
          //   height: context.height,
          //   child: ,
          // ),
          LoginWidget(),
        ],
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        const Spacer(),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(
            30,
          ),
          child: Image.asset(
            'assets/images/login_bg.jpg',
            fit: BoxFit.cover,
          ),
        ),

        // Image.asset('assets/images/login.png'),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => ChatScreen());
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.secondary,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 16,
                    color: context.whiteColor,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                FaIcon(
                  FontAwesomeIcons.google,
                  color: context.whiteColor,
                )
              ],
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
