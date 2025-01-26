import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/clients/ApiClient.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<void> login() async{
    ApiClient apiClient = ApiClient();

    await apiClient.login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff3F762E),
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 200,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.4,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(150)),
                  color: Color(0xffFFFFFF),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 150, 30, 30),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Email",
                            style: TextStyle(fontFamily: "Inter"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: TextField(
                            decoration: InputDecoration(
                                fillColor: Color(0xffDCFFD1),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Senha",
                            style: TextStyle(fontFamily: "Inter"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: TextField(
                            decoration: InputDecoration(
                                fillColor: Color(0xffDCFFD1),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async{
                              await login();
                            },
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                color: Color(0xffF5FF6C),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff3F762E),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
