import 'package:crypto_pass/forms/register.dart';

import '../forms/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: <Widget>[
          Expanded(
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment(0.5, -3.06),
                            end: Alignment(0.5, 1),
                            colors: <Color>[
                              Color(0xFF090070),
                              Color(0xFF530070),
                            ]),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 52, 16, 4),
                            child: Text('Welcome To',
                                style: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                    color: Color(0xFFCFDFFF),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 12, 16, 12),
                            child: Text(
                              'Crypto Pass',
                              style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 30,
                                right: 30,
                                bottom: 10,
                              ),
                              child: TabBar(
                                indicatorColor: Colors.white,
                                indicatorWeight: 3,
                                labelColor: Colors.white,
                                labelStyle: GoogleFonts.getFont(
                                  'Roboto',
                                ),
                                tabs: const [
                                  Tab(
                                    text: 'SIGN IN',
                                  ),
                                  Tab(
                                    text: 'SIGN UP',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          Login(),
                          Register(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
