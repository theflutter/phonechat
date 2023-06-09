import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './login-page.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});
  @override
  Widget build(context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var code = "";
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/logo.jpg',
              width: 200,
              height: 200,
            ),
            Container(
              width: 350,
              height: 350,
              child: Card(
                  elevation: 8,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    padding: EdgeInsets.all(35),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 0, 147, 233),
                      Color.fromARGB(255, 128, 208, 199)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'OTP Verificaion',
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'Enter the OTP you received to',
                          style: TextStyle(fontSize: 16, color: Colors.black38),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(LoginPage.phone
                                .substring(0, LoginPage.phone.length - 5) +
                            "XXXXX"),
                        const SizedBox(
                          height: 30,
                        ),
                        Pinput(
                          length: 6,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          showCursor: true,
                          onCompleted: (pin) => print(pin),
                          onChanged: (value) {
                            code = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'login-page', (route) => false);
                            },
                            child: const SizedBox(
                              width: 60,
                              child: Row(
                                children: [
                                  Text(
                                    'Back',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_left_sharp,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 120,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(225, 25, 167, 206))),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          foregroundColor: Color.fromARGB(225, 25, 167, 206)),
                      child: const Text(
                        'Resend',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(
                    width: 120,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () async {
                          try {
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: LoginPage.verify,
                                    smsCode: code);
                            await auth.signInWithCredential(credential);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "home-page", (route) => false);
                          } catch (e) {
                            print("wrong phone");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(225, 25, 167, 206),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
