import 'package:flutter/material.dart';

class Home extends StatefulWidget {
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Seus Pets"),
			),
			
			body: Column(
				children: <Widget>[
					Container(
						child: Card(
							child: Column(
								mainAxisSize: MainAxisSize.min,
								children: <Widget>[
									const ListTile(
										leading: CircleAvatar(
											backgroundImage: NetworkImage("https://www.petlove.com.br/images/breeds/193442/profile/original/buldogue_frances-p.jpg?1532538793"),
										),
										title: Text('Junior'),
										subtitle: Text('Bulldog Francês, 6 anos.'),
									),
									ButtonBar(
										children: <Widget>[
											FlatButton(
												child: const Text('EDITAR'),
												onPressed: () { /* ... */ },
											),
											FlatButton(
												child: const Text('CARTEIRINHA'),
												onPressed: () { /* ... */ },
											),
										],
									),
								],
							),
						),
					),
					
					Container(
						child: Card(
							child: Column(
								mainAxisSize: MainAxisSize.min,
								children: <Widget>[
									const ListTile(
										leading: CircleAvatar(
											backgroundImage: NetworkImage("https://http2.mlstatic.com/buldogue-campeiro-filhote-macho-D_NQ_NP_876205-MLB27307359945_052018-F.jpg"),
										),
										title: Text('Luppi'),
										subtitle: Text('Bulldog Campeiro, 2 anos.'),
									),
									ButtonBar(
										children: <Widget>[
											FlatButton(
												child: const Text('EDITAR'),
												onPressed: () { /* ... */ },
											),
											FlatButton(
												child: const Text('CARTEIRINHA'),
												onPressed: () { /* ... */ },
											),
										],
									),
								],
							),
						),
					),
				],
			),
			
			
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

