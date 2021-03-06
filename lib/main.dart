import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///
/// Applicazione di prova di Flutter
///  * Si interfaccia via rete con un dispositivo Volumio (il mio Raspberry)
///  * Mostra i titoli e le copertine
///  * Invia comandi di Start e Stop
///
///  @author SM 03.01.2020


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Volumio',
			theme: ThemeData(
				// This is the theme of your application.
				primarySwatch: Colors.blue,
			),
			home: MyHomePage(title: 'Flutter Volumio'),
		);
	}
}


class MyHomePage extends StatefulWidget {
	MyHomePage({Key key, this.title}) : super(key: key);

	// This widget is the home page of your application. It is stateful, meaning
	// that it has a State object (defined below) that contains fields that affect
	// how it looks.

	// This class is the configuration for the state. It holds the values (in this
	// case the title) provided by the parent (in this case the App widget) and
	// used by the build method of the State. Fields in a Widget subclass are
	// always marked "final".

	final String title;

	@override
	_MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

	int _counter = 0;
	Future<Media> post;

	void _incrementCounter() {
		setState(() {
			// This call to setState tells the Flutter framework that something has
			// changed in this State, which causes it to rerun the build method below
			// so that the display can reflect the updated values. If we changed
			// _counter without calling setState(), then the build method would not be
			// called again, and so nothing would appear to happen.
			_counter++;
			post = fetchPost(_counter);
		});
	}


	@override void initState(){
		super.initState();
		post = fetchPost(_counter);
	}



	///
	/// Future is a core Dart class for working with async operations.
	/// A Future object represents a potential value or error that will be available at some time in the future.
	/// The http.Response class contains the data received from a successful http call.
	///
	// Originale:
	//	Future<http.Response> fetchPost() {
	//		return http.get('https://jsonplaceholder.typicode.com/posts/1');
	//	}

	// Versione asincona e parametrizzata con la classe Media
	Future<Media> fetchPost(idx) async {
		final response =
		await http.get('https://jsonplaceholder.typicode.com/posts/'+idx.toString());

		if (response.statusCode == 200) {
			// If server returns an OK response, parse the JSON.
			return Media.fromJson(json.decode(response.body));
		} else {
			// If that response was not OK, throw an error.
			throw Exception('Failed to load post');
		}
	}


	@override
	Widget build(BuildContext context) {
		// This method is rerun every time setState is called, for instance as done
		// by the _incrementCounter method above.
		//
		// The Flutter framework has been optimized to make rerunning build methods
		// fast, so that you can just rebuild anything that needs updating rather
		// than having to individually change instances of widgets.
		return Scaffold(

			appBar: AppBar(
				// Here we take the value from the MyHomePage object that was created by
				// the App.build method, and use it to set our appbar title.
				title: Text(widget.title),
			),

			body: Center(
				// Center is a layout widget. It takes a single child and positions it
				// in the middle of the parent.
				child: Column(
					// Column is also a layout widget. It takes a list of children and
					// arranges them vertically. By default, it sizes itself to fit its
					// children horizontally, and tries to be as tall as its parent.
					//
					// Invoke "debug painting" (press "p" in the console, choose the
					// "Toggle Debug Paint" action from the Flutter Inspector in Android
					// Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
					// to see the wireframe for each widget.
					//
					// Column has various properties to control how it sizes itself and
					// how it positions its children. Here we use mainAxisAlignment to
					// center the children vertically; the main axis here is the vertical
					// axis because Columns are vertical (the cross axis would be
					// horizontal).
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Text(
							'You have pushed the\nbutton this many times:',
						),
						Text(
							'$_counter',
							style: Theme.of(context).textTheme.display1,
						),
						FutureBuilder<Media>(
							future: post,
							builder: (context, snapshot) {
								if (snapshot.hasData) {
									return Text(snapshot.data.title + '\nBody: ' + snapshot.data.body);
								} else if (snapshot.hasError) {
									return Text("${snapshot.error}");
								}

								// By default, show a loading spinner.
								return CircularProgressIndicator();
							},
						),

					],
				),
			),

			floatingActionButton: FloatingActionButton(
				onPressed: _incrementCounter,
				tooltip: 'Incrementa',
				child: Icon(Icons.add),
			), // This trailing comma makes auto-formatting nicer for build methods.

		);

	} // build()

} // class



///
/// Classe con i dati ricevuti dalla richiesta
/// Membro factory per la conversione da JSON
///
class Media {
	final int userId;
	final int id;
	final String title;
	final String body;

	Media({this.userId, this.id, this.title, this.body});

	factory Media.fromJson(Map<String, dynamic> json) {
		return Media(
			userId: json['userId'],
			id: json['id'],
			title: json['title'],
			body: json['body'],
		);
	}
}
