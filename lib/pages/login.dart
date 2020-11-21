import 'dart:math';
import 'package:aplicacion_final/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user =  TextEditingController();

  TextEditingController password =  TextEditingController();
  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children:[
            SafeArea(child: ClippedPartsWidget(
              top: Container(color: Colors.orange,),
              bottom: Container(color: Colors.white,),
              splitFunction: (Size size, double x){
                final normalizedX = x / size.width * 2 * pi;
                final waveHeight = size.height / 15;
                final y = size.height / 4 - sin(normalizedX) * waveHeight;

                return y;
              },
            )),
            Center(
              child: ListView(
                children:[
                    Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        height: 120,
                        width: 100,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(child: Image.asset("assets/rutheless logo.png"),
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: TextField(
                            controller: user,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: "Ingrese su email", labelText: "Nombre de usuario"
                            ),
                          ),
                          width: 300,
                          height: 60,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: TextField(
                            controller: password,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(onTap: (){
                                setState(() {
                                  _obscureText= !_obscureText;
                                });
                               },
                                child: Icon(Icons.remove_red_eye_outlined),
                              ),
                              hintText: "Ingrese su contraseña", labelText: "contraseña",
                            ),
                            obscureText: _obscureText,
                          ),
                          width: 300,
                          height: 60,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: RaisedButton(child: Text("Ingresar",style: TextStyle(color: Colors.white)),
                                color: Colors.orange,
                                onPressed: (){
                                  if(user != null && user.text == "julianmunoz0901@hotmail.com"
                                      && password != null && password.text == "quizasmañanatelade")
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage() ));
                                }),
                            width: 230,
                          )
                      ),
                      Container(
                        width: 1,
                        height: 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.8),
                        child: Text("Aplicacion desarrollada por Julian Muñoz",style: TextStyle(color: Colors.grey,fontSize: 12)),
                      ),
                    ],
                  ),
                ]
              ),
            ),
          ]
      ),
    );
  }
}

class ClippedPartsWidget extends StatelessWidget {
  final Widget top;
  final Widget bottom;
  final double Function(Size, double) splitFunction;

  ClippedPartsWidget({
    @required this.top,
    @required this.bottom,
    @required this.splitFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        top,
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: FunctionClipper(splitFunction: splitFunction),
            child: bottom,
          ),
        ),
      ],
    );
  }
}

class FunctionClipper extends CustomClipper<Path> {
  final double Function(Size, double) splitFunction;

  FunctionClipper({@required this.splitFunction}) : super();

  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, splitFunction(size, 0));

    for (double x = 1; x <= size.width; x++) {
      path.lineTo(x, splitFunction(size, x));
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
