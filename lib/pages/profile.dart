import 'package:aplicacion_final/pages/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Profile());
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Perfil",style: TextStyle(color: Colors.white),),),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey ,
                  backgroundImage: NetworkImage("https://prodigits.co.uk/thumbs/wallpapers/p2/spiritual/44/c9829d2012314502.jpg"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Julian Muñoz",style: TextStyle(fontSize: 20),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Estudiante",style: TextStyle(fontSize: 10,color: Colors.grey),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Medellin - Antioquia, Colombia",style: TextStyle(fontSize: 10, color: Colors.grey),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(child: Image.asset("assets/rutheless logo.png"),
                  height: 200,
                  width: 200,
                ),
              ),
              RaisedButton(
                child: Text("Salir",style: TextStyle(fontSize: 20,color: Colors.grey)),
                onPressed: (){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Login()));
                  Icon(Icons.logout,color: Colors.grey,);
                },
              ),
            ],
          ),
        ),
      );
  }
}
