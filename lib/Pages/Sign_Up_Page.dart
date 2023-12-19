import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second_project/Helper/ShowSnackBar.dart';
import 'package:second_project/Pages/Login_Page.dart';
import 'package:second_project/widgets/CustomMaterialButton.dart';
import 'package:second_project/widgets/CustomTextField.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextForm(
                  hinttext: 'Enter username',
                  mycontroller: userName,
                  icon: Icons.person_2_outlined,
                  obsecureTe: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextForm(
                  hinttext: 'Enter email',
                  mycontroller: email,
                  icon: Icons.email,
                  obsecureTe: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextForm(
                  hinttext: 'Enter password',
                  mycontroller: password,
                  icon: Icons.lock,
                  obsecureTe: isPasswordHidden,
                  iconButton: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    icon: const Icon(Icons.remove_red_eye_rounded),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextForm(
                  hinttext: 'Enter password again',
                  mycontroller: confirmPassword,
                  icon: Icons.lock,
                  obsecureTe: isConfirmPasswordHidden,
                  iconButton: IconButton(
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordHidden = !isConfirmPasswordHidden;
                      });
                    },
                    icon: const Icon(Icons.remove_red_eye_rounded),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: CustomButton(
                  text: 'Sign Up',
                  onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      navMehod(context);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        ShowSnackBar(
                            context, "The password provided is too weak.");
                      } else if (e.code == 'email-already-in-use') {
                        ShowSnackBar(context, "Email already exsists");
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      ' Already have an account ?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        '   LogIn',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[300],
                            fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navMehod(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }
}
