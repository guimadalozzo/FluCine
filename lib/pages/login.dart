import 'package:controle_animal/pages/cadastro.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomPadding: false,
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/FundoeVetSIS.png"),
                        fit: BoxFit.cover,
                    ),
                ),
                child: Column(
                    children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 80, left: 30, right: 30),
                            child:
                                Image.asset(
                                    "assets/images/eVetSisLogoApp.png"
                                ),
                        ),

                        Padding(
                            padding: EdgeInsets.only(top: 40, left: 30, right: 30),
                            child:
                                TextField(
                                    decoration: InputDecoration(
                                        border: new OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(
                                                const Radius.circular(50.0),
                                            ),
                                        ),
                                        contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),

                                        filled: true,
                                        fillColor: Colors.white,

                                        alignLabelWithHint: true,
                                        hintText: 'E-mail',
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                ),
                        ),

                        Padding(
                            padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                            child:
                                TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: new OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(
                                                const Radius.circular(50.0),
                                            ),
                                        ),
                                        contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),

                                        filled: true,
                                        fillColor: Colors.white,

                                        alignLabelWithHint: true,
                                        labelText: 'Senha',
                                    ),
                                    keyboardType: TextInputType.text,
                                ),
                        ),

                        Padding(
                            padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                            child:
                                ButtonBar(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                        Container(
                                            width: 150,
                                            child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: new BorderRadius.circular(18.0),
                                                    side: BorderSide(color: Colors.blue)
                                                ),
                                                child: Text('CADASTRE-SE',
                                                    style: TextStyle(
                                                        fontFamily: 'Oswald',
                                                        color: Colors.white
                                                    ),
                                                ),
                                                color: Colors.blue,
                                                onPressed: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) => Cadastro()
                                                        )
                                                    );
                                                },
                                            ),
                                        ),

                                        Container(
                                            width: 150,
                                            child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: new BorderRadius.circular(18.0),
                                                    side: BorderSide(color: Colors.white)
                                                ),
                                                child: Text('ENTRAR',
                                                    style: TextStyle(
                                                        fontFamily: 'Oswald',
                                                        color: Colors.white
                                                    ),
                                                ),
                                                onPressed: () {/** */},
                                            ),
                                        ),
                                    ],
                                ),
                        ),

                        OutlineButton(
                            child: Text('Esqueci a senha',
                                style: TextStyle(
                                fontFamily: 'Oswald',
                                ),
                            ),
                            color: Colors.blue,
                            onPressed: () {/** */},
                        ),

                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(right: 40, bottom: 60),
                                child: Align(
                                    alignment: FractionalOffset.bottomRight,
                                    child: Container(
                                        child: Text(
                                            "A saúde dos\nseus pets\nem suas mãos!",
                                            textAlign: TextAlign.right,

                                            style: TextStyle(
                                                fontFamily: 'Oswald',
                                                fontSize: 25,
                                                color: Colors.white.withOpacity(0.7)),
                                        )
                                    ),
                                ),
                            ),
                        )

                    ]
                ),
            ),
        );
    }
}

