import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second_project/Helper/ShowSnackBar.dart';
import 'package:second_project/Pages/Home.dart';
import 'package:second_project/Pages/Sign_Up_Page.dart';
import 'package:second_project/widgets/CustomMaterialButton.dart';
import 'package:second_project/widgets/CustomTextField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
bool isPasswordHidden = true;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/photo/Background_Login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const SizedBox(
                  height: 125,
                ),
                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Welcome Back..',
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 18,
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
                    fontSize: 18,
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
                  'Forget Password ?',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: CustomButton(
                    text: 'Sign Up',
                    onPressed: () async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        LoginNav(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found' ||
                            e.code == 'wrong-password') {
                          ShowSnackBar(context, 'invalid email or password');
                        } else {
                          ShowSnackBar(
                              context, 'An error occurred : ${e.code}');
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'OR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/photo/google.jpg',
                          height: 22,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Sign in With Google',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account ?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        ' Register now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[300]),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpPage();
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
        ),
      ),
    );
  }

  void LoginNav(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  }
}
