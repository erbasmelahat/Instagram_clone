// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/input_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
  }

  void selectImage() async {
    // await PermissionHandler().requestPermissions([PermissionGroup.photos]);
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signup() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signup(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        bio: bioController.text,
        file: _image!);
    // print(res);

    if (res != "success") {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
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
            SizedBox(height: MediaQuery.of(context).size.height / 20),

            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://i.pinimg.com/originals/36/92/8d/36928d2b20fbf3d3a47440e68166bf82.png'),
                      ),
                Positioned(
                    bottom: -10,
                    right: 0,
                    // left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ))
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            // text field input for username
            InputTextField(
              hintText: "Enter Your Username",
              textInputType: TextInputType.text,
              textEditingController: usernameController,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
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
            //text field input for bio
            InputTextField(
              hintText: "Enter Your Bio",
              textInputType: TextInputType.text,
              textEditingController: bioController,
              // isPass: true,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            //button login
            InkWell(
              onTap: signup,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Sign Up'),
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
