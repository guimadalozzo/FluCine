import 'package:flutter/material.dart';
import 'package:controle_animal/model/Animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
	
	Future<List<Animal>> _getAnimais() async {
		Firestore db = Firestore.instance;
		
		QuerySnapshot querySnapshot = await db.collection("animais")
			.getDocuments();
		
		List<Animal> listaAnimais = List();
		for(DocumentSnapshot item in querySnapshot.documents) {
			var dados = item.data;
			
			Animal animal = Animal(
								dados["nome"],
								dados["idade"],
								dados["raca"],
								dados["foto"]
							);
			
			listaAnimais.add(animal);
		}
		
		print("Quantidade de animais: "+listaAnimais.length.toString());
		
		return listaAnimais;
	}
	
	_body() {
		return FutureBuilder<List<Animal>>(
			future: _getAnimais(),
			builder: (context, snapshot) {
				switch( snapshot.connectionState ) {
					case ConnectionState.none : print("Conexão em estado nulo."); break;
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
					case ConnectionState.active : print("Conexão em estado ativo (útil em streaming."); break;
					
					case ConnectionState.done :
						return ListView.builder(
							itemCount: snapshot.data.length,
							itemBuilder: (context, index) {
								List<Animal> animais = snapshot.data;
								Animal animal = animais[index];
								
								print(animal.foto);
								
								return ListTile(
									leading: CircleAvatar(
										backgroundImage: NetworkImage(animal.foto),
									),
									title: Text( animal.nome ),
									subtitle: Text( animal.raca + ", " + animal.idade + " anos"),
								);
							}
						);
				}
				
				return null;
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

