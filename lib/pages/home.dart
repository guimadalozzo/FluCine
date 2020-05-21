import 'package:controle_animal/components/menu_inferior.dart';
import 'package:controle_animal/pages/novo_pet.dart';
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
					case ConnectionState.done :
						
						print("ACTIVE");
						return Center(
							child: Column(
								children: <Widget>[
									Text("Activing..."),
									CircularProgressIndicator()
								],
							),
						);
						break;
					
					case ConnectionState.waiting :
						print("WAINTING");
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
						break;
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
			
			bottomNavigationBar: MenuInferior(),
			
			floatingActionButton: FloatingActionButton(
				onPressed: () {
//						Navigator.push(context,
//							MaterialPageRoute(
//								builder: (context) => NovoPet()
//							)
//						);
						//db.collection("animais").document("005").setData({"nome": "pompom"});
					},
				tooltip: 'Novo Pet',
				child: Icon(Icons.add),
			),
		);
	}
	
	final _formKey = GlobalKey<FormState>();
	
	
	_novoPet() {
		return showDialog(
			context: context,
			builder: (BuildContext context)
			{
				return AlertDialog(
					content: Stack(
						overflow: Overflow.visible,
						children: <Widget>[
							Positioned(
								right: -40.0,
								top: -40.0,
								child: InkResponse(
									onTap: () {
										Navigator.of(context).pop();
									},
									child: CircleAvatar(
										child: Icon(Icons.close),
										backgroundColor: Colors.red,
									),
								),
							),
							Form(
								key: _formKey,
								child: Column(
									mainAxisSize: MainAxisSize.min,
									children: <Widget>[
										Padding(
											padding: EdgeInsets.all(8.0),
											child: TextFormField(),
										),
										Padding(
											padding: EdgeInsets.all(8.0),
											child: TextFormField(),
										),
										Padding(
											padding: const EdgeInsets.all(8.0),
											child: RaisedButton(
												child: Text("Submitß"),
												onPressed: () {
													if (_formKey.currentState
														.validate()) {
														_formKey.currentState
															.save();
													}
												},
											),
										)
									],
								),
							),
						],
					),
				);
			});
		
	}
}
