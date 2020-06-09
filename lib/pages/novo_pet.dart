import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';


class NovoPet extends StatefulWidget {
  @override
  _NovoPetState createState() => _NovoPetState();
}

class _NovoPetState extends State<NovoPet> {
	
	TextEditingController _nomeController  = TextEditingController();
	TextEditingController _especieController = TextEditingController();
	TextEditingController _racaController = TextEditingController();
	TextEditingController _idadeController = TextEditingController();
	String _erroMsg = "";
	File _foto;
	
	Future _getImage() async {
		PickedFile img;
		ImagePicker cam = ImagePicker();
		img = await cam.getImage(source: ImageSource.camera);
		
		setState(() {
		    _foto = File(img.path);
		});
	}
	
	_validacao() {
		String nome    = _nomeController.text;
		String especie = _especieController.text;
		String raca    = _racaController.text;
		String idade   = _idadeController.text;
		
		if (nome.isNotEmpty && especie.isNotEmpty && raca.isNotEmpty && idade.isNotEmpty) {
			_cadastrar();
		}
		else {
			setState(() {
				_erroMsg = "Preencha todos os campos!";
			});
		}
	}
	
	Future _cadastrar() async {
		String nome    = _nomeController.text;
		String especie = _especieController.text;
		String raca    = _racaController.text;
		String idade   = _idadeController.text;
		
		String new_pet;
		FirebaseUser user;
		
		await FirebaseAuth.instance.currentUser().then((currentUser) => {
			if (currentUser != null) {
				user = currentUser
			}
		});
		
		await Firestore.instance
			.collection(user.uid)
			.document("pets")
			.collection("pets")
			.add({
				"nome": nome,
				"especie": especie,
				"idade": idade,
				"raca": raca,
			}).then((value){
				new_pet = value.documentID;
			});
		
		print("ID DOC: "+new_pet);
		
		FirebaseStorage storage = FirebaseStorage.instance;
		StorageReference rootFolder = storage.ref();
		StorageReference arquivo = rootFolder.child("pets_avatar").child(user.uid).child(new_pet);
		arquivo.putFile(_foto);
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Stack(
				children: <Widget>[
					Align(
						alignment: Alignment.topCenter,
						child: _image(),
					),
					Align(
						alignment: Alignment.topLeft,
						child: _avatar(),
					),
					Align(
						alignment: Alignment.topLeft,
						child: _addPhoto(),
					),
					Align(
						alignment: Alignment.bottomCenter,
						child: _action(),
					),
					Align(
						alignment: Alignment.topLeft,
						child: _backBtn(context),
					),
					Align(
						alignment: Alignment.bottomCenter,
						child: _title(),
					),
					Align(
						alignment: Alignment.bottomCenter,
						child: _content(),
					),
				],
			),
		);
	}
	
	Widget _avatar() {
		return _foto == null
			? Container()
			: Padding(
				padding: EdgeInsets.only(top: 225, left: 150, right: 30),
				child: CircleAvatar(
						radius: 55,
						backgroundColor: Colors.white,
						child: CircleAvatar(
							radius: 50,
							backgroundImage: AssetImage(_foto.path),
						),
					),
				);
	}
	
	Widget _image() {
		return Container(
				decoration: BoxDecoration(
				image: DecorationImage(
					image: AssetImage("assets/images/NovoPet.png"),
					fit: BoxFit.cover,
				),
			),
		);
	}
	
	Widget _title() {
		return Container(
			height: 450,
			width: 510,
			decoration: BoxDecoration(
				color: Colors.blue,
				borderRadius: BorderRadius.only(
					topLeft: Radius.circular(30),
					topRight: Radius.circular(30),
				),
			),
			child: Text(
						"Novo Pet",
						textAlign: TextAlign.center,
						
						style: TextStyle(
							fontFamily: 'Oswald',
							fontSize: 25,
							color: Colors.white),
					)
		);
	}
	
	Widget _content() {
		return Container(
			height: 410,
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.only(
					topLeft: Radius.circular(30),
					topRight: Radius.circular(30),
				),
			),
			child: Column(
					children: <Widget>[
						
						Padding(
							padding: EdgeInsets.only(top: 20, left: 30, right: 30),
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
									hintText: 'Nome',
								),
								controller: _nomeController,
								keyboardType: TextInputType.text,
							),
						),

						Padding(
							padding: EdgeInsets.only(top: 20, left: 30, right: 30),
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
									hintText: 'Espécie',
								),
								controller: _especieController,
								keyboardType: TextInputType.text,
							),
						),
						
						Padding(
							padding: EdgeInsets.only(top: 20, left: 30, right: 30),
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
									hintText: 'Raça',
								),
								controller: _racaController,
								keyboardType: TextInputType.text,
							),
						),
						
						Padding(
							padding: EdgeInsets.only(top: 20, left: 30, right: 30),
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
									hintText: 'Idade',
								),
								controller: _idadeController,
								keyboardType: TextInputType.text,
							),
						),
					
					]
			),
		);
	}
	
	Widget _action() {
		return Container(
			width: 200,
			height: 45,
			margin: EdgeInsets.only(bottom: 45),
			child: FlatButton(
				shape: RoundedRectangleBorder(
					borderRadius: new BorderRadius.circular(15.0),
					side: BorderSide(color: Colors.blue)
				),
				child: Text('ADICIONAR',
					style: TextStyle(
						fontFamily: 'Oswald',
						color: Colors.white
					),
				),
				color: Colors.blue,
				onPressed: () {
					_validacao();
				},
			),
		);
	}
	
	Widget _backBtn(BuildContext context) {
		return Container(
			height: 60,
			width: 60,
			margin: EdgeInsets.only(
				left: 40,
				top: 100,
			),
			child: RaisedButton(
				color: Colors.white,
				onPressed: () {
					Navigator.pop(context);
				},
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(50.0),
				),
				child: Icon(
							Icons.arrow_back,
							color: Colors.blue,
						),
				),
		);
	}
	
	Widget _addPhoto() {
		return Container(
			height: 60,
			width: 330,
			margin: EdgeInsets.only(
				left: 40,
				top: 100,
			),
			child: RaisedButton(
				color: Colors.transparent,
				onPressed: () {
					_getImage();
				},
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(50.0),
				),
				child: Row(
					children: <Widget>[
						Padding(
							padding: EdgeInsets.only(left: 70),
							child: Icon(
								Icons.camera_enhance,
								color: Colors.blue,
							),
						),
						Padding(
							padding: EdgeInsets.only(left: 15),
							child: Text(
								"Clique para adicionar nova foto.",
								style: TextStyle(
									fontFamily: 'Oswald',
									color: Colors.white.withOpacity(0.5)
								),
							),
						),
					],
				),
			),
		);
	}
}