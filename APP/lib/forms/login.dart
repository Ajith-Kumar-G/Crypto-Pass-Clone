import 'package:crypto_pass/forms/google_sign_in.dart';
import 'package:crypto_pass/utils/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // void _goToHome(BuildContext context) {
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return HomeScreen();
  //       },
  //     ),
  //   );
  // }
  bool visibility = false;
  Widget icon = Icon(Icons.visibility);

  void _passwordVisibility() {
    setState(() {
      visibility = !visibility;
      if (visibility) {
        icon = Icon(Icons.visibility_off);
      } else {
        icon = Icon(Icons.visibility);
      }
    });
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        top: 40,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Enter  your Details ",
                textAlign: TextAlign.left,
                style: GoogleFonts.rubik(
                    fontSize: 20, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                // padding: EdgeInsets.only(
                //     bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'email',
                    labelStyle: TextStyle(
                      color: Color(0xFFBFBFBF),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFBFBFBF),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: !visibility,
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    child: icon,
                    onTap: () {
                      _passwordVisibility();
                    },
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color(0xFFBFBFBF),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFBFBFBF),
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF330070),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
                onPressed: () async {
                  // if (emailController.text.isEmpty ||
                  //     passwordController.text.isEmpty) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Field Empty')),
                  //   );
                  //   return;
                  // }
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                  bool res = await AuthProvider().signInWithEmail(
                      emailController.text, passwordController.text);
                  if (!res) {
                    print('Fail');
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    "Login",
                    style: GoogleFonts.rubik(
                        fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  // final provider =
                  //     Provider.of<GoogleSignInProvider>(context, listen: false);
                  // provider.googleLogin();
                  bool res = await AuthProvider().loginWithGoogle();
                  if (!res) print("error logging");
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  side: const BorderSide(
                    width: 2,
                    color: Color(0xFF330070),
                  ),
                ),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.google,
                        color: Color(0xFF330070),
                      ),
                      Text(
                        "Google Sign In",
                        style: GoogleFonts.rubik(
                          color: const Color(0xFF330070),
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// InkWell(
//                 onTap: () async {
//                   // final provider =
//                   //     Provider.of<GoogleSignInProvider>(context, listen: false);
//                   // provider.googleLogin();
//                   bool res = await AuthProvider().loginWithGoogle();
//                   if (!res) print("error logging");
//                 },
//                 child: Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       width: 2,
//                       color: const Color(0xFF330070),
//                     ),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   width: MediaQuery.of(context).size.width * 0.7,
//                   alignment: Alignment.center,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const FaIcon(
//                         FontAwesomeIcons.google,
//                         color: Color(0xFF330070),
//                       ),
//                       Text(
//                         "Google Sign In",
//                         style: GoogleFonts.rubik(
//                           color: const Color(0xFF330070),
//                           fontSize: 20,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),