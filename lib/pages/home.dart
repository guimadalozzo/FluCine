import 'package:controle_animal/components/menu_inferior.dart';
import 'package:controle_animal/pages/novo_pet.dart';
import 'package:flutter/material.dart';
import 'package:controle_animal/model/Animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Home extends StatefulWidget {
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
	Firestore db = Firestore.instance;
	String user;

	String _getUser() {
		FirebaseAuth.instance.currentUser().then((currentUser) =>
		{
			if (currentUser != "") {
				user = currentUser.uid,
			}
		});
		print("USER:: "+user);
		return user;
	}
	
	@override
	Widget build(BuildContext context) {
		
		return Scaffold(
			appBar: AppBar(title: Text("Seus Pets")),
			
			body: _body(),
			
			bottomNavigationBar: MenuInferior(),
			
			floatingActionButton: FloatingActionButton(
				onPressed: () {
					Navigator.push(context,
						MaterialPageRoute(
							builder: (context) => NovoPet()
						)
					);
				},
				tooltip: 'Novo Pet',
				child: Icon(Icons.add),
			),
		);
	}
	
	_body() {
		return StreamBuilder(
			stream: db.collection(_getUser()).document("pets").collection("pets").snapshots(),
// ignore: missing_return
			builder: (context, snapshot) {
				switch( snapshot.connectionState ) {
					case ConnectionState.none :
					case ConnectionState.done :
					
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
					
					case ConnectionState.active :
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
	
}
