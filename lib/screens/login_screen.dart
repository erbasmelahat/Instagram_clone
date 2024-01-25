// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/input_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: emailController.text, password: passwordController.text);

    if (res == "success") {
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            //svg image
            SvgPicture.asset(
              'assets/instagram.svg',
              color: primaryColor,
              height: 64,
            ),
            // const SizedBox(height: 64),
            SizedBox(height: MediaQuery.of(context).size.height / 10),

            // text field input for email
            InputTextField(
              hintText: "Enter Your Email",
              textInputType: TextInputType.emailAddress,
              textEditingController: emailController,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            //text field input for password
            InputTextField(
              hintText: "Enter Your Password",
              textInputType: TextInputType.text,
              textEditingController: passwordController,
              isPass: true,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            //button login
            InkWell(
              onTap: loginUser,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      )
                    : const Text('Log In'),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Don't Have an Account?"),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Sign Up.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
            //transitioning to signing up
          ],
        ),
      )),
    );
  }
}
