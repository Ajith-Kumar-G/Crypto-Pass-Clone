import 'package:crypto_pass/utils/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({
    Key? key,
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool visibility = false;
  Widget icon = Icon(Icons.visibility);

  void _passwordVisibility() => setState(() {
        visibility = !visibility;
        if (visibility) {
          icon = Icon(Icons.visibility_off);
        } else {
          icon = Icon(Icons.visibility);
        }
      });
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        top: 40,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "Fill your Details ",
              textAlign: TextAlign.left,
              style: GoogleFonts.rubik(
                  fontSize: 20, fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 35,
            ),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
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
            const SizedBox(
              height: 10,
            ),

            // TextFormField(
            //   keyboardType: TextInputType.emailAddress,
            //   controller: phoneController,
            //   decoration: const InputDecoration(
            //     labelText: 'Phone Number',
            //     labelStyle: TextStyle(
            //       color: Color(0xFFBFBFBF),
            //     ),
            //     enabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(
            //         color: Color(0xFFBFBFBF),
            //         width: 2,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: !visibility,
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
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
              onPressed: () {
                AuthProvider()
                    .addUser(emailController.text, passwordController.text);
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.7,
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  "Register",
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
                      "Google Sign Up",
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
    );
  }
}

// Container(
//   height: 40,
//   decoration: BoxDecoration(
//     border: Border.all(
//       width: 2,
//       color: const Color(0xFF330070),
//     ),
//     borderRadius: BorderRadius.circular(30),
//   ),
//   width: MediaQuery.of(context).size.width * 0.45,
//   alignment: Alignment.center,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       const FaIcon(
//         FontAwesomeIcons.google,
//         color: Color(0xFF330070),
//       ),
//       Text(
//         "Google Sign Up",
//         style: GoogleFonts.rubik(
//           color: const Color(0xFF330070),
//           fontSize: 20,
//           fontWeight: FontWeight.normal,
//         ),
//       ),
//     ],
//   ),
// ),
