import 'package:flutter/material.dart';
import 'package:controle_animal/model/Animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
	Firestore db = Firestore.instance;
	
	_body() {
		return StreamBuilder(
			stream: db.collection("animais").snapshots(),
// ignore: missing_return
			builder: (context, snapshot) {
				switch( snapshot.connectionState ) {
					case ConnectionState.none :
					case ConnectionState.active :
					
					case ConnectionState.waiting :
						return Center(
							child: Column(
								children: <Widget>[
									Text("Carregando animais..."),
									CircularProgressIndicator()
								],
							),
						);
						break;
						
					case ConnectionState.done :
						QuerySnapshot querySnapshot = snapshot.data;
						
						if(snapshot.hasError) {
							return Container(
								child: Text("Ocorreram erros ao carregar os dados!"),
							);
						}
						else {
							print("DADOS CARREGADOS: "+snapshot.data.toString());
							
							return Container(
								child: ListView.builder(
									itemCount: querySnapshot.documents.length,
									itemBuilder: (context, index) {
										
										//recupera os animais
										List<DocumentSnapshot> animais = querySnapshot.documents.toList();
										DocumentSnapshot dados = animais[index];
										
										Animal animal = Animal(dados["nome"], dados["idade"], dados["raca"], dados["foto"]);
										
										return ListTile(
											leading: CircleAvatar(
												backgroundImage: NetworkImage(animal.foto),
											),
											title: Text( animal.nome ),
											subtitle: Text( animal.raca + ", " + animal.idade + " anos."),
										);
									}
								)
							);
						}
				}
				
			}
		
		);
		
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Seus Pets"),
			),
			
			body: _body(),
			
			bottomNavigationBar: BottomAppBar(
				//shape: const CircularNotchedRectangle(),
				child: Container(
					height: 50.0,
					child: Row(
						mainAxisSize: MainAxisSize.min,
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						
						children: <Widget>[
							IconButton(
								padding: EdgeInsets.only(right: 20.0, left: 20.0),
								color: Colors.blue,
								icon: Icon(Icons.home),
								onPressed: () {/* */}
							),
							
							IconButton(
								padding: EdgeInsets.only(right: 50.0, left: 50.0),
								color: Colors.blue,
								icon: Icon(Icons.pets),
								onPressed: () {/* */}
							),
							
							IconButton(
								padding: EdgeInsets.only(right: 30.0, left: 30.0),
								color: Colors.blue,
								icon: Icon(Icons.person),
								onPressed: () {/* */}
							),
							
							IconButton(
								padding: EdgeInsets.only(right: 20.0, left: 20.0),
								color: Colors.blue,
								icon: Icon(Icons.event),
								onPressed: () {/* */}
							),
						],
					),
				),
			),
			
			floatingActionButton: FloatingActionButton(
				onPressed: () {/* */},
				tooltip: 'Novo Pet',
				child: Icon(Icons.add),
			),
		);
	}
}
