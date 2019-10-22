import 'package:flutter/material.dart';
import 'source.dart';
import 'source_json_parser.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: FirstPage(title: 'Unsplash Gallery'),
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 26,
            color: Colors.deepOrange.shade200,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getPictures(),
        builder: (context, snapShot) {
          var data = snapShot.data;

          if (!snapShot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapShot.hasError) {
            print(snapShot.error);
            return Text(
              'Failed to get response from the server',
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            );
          }
          return Center(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var smallImage =
                    '${data[index]['urls'][jsonExecutionQueryProperties[0]]}';
                var bigImage =
                    '${data[index]['urls'][jsonExecutionQueryProperties[1]]}';
                var author =
                    '${data[index]['user'][jsonExecutionQueryProperties[2]]}';

                return Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        setState(() => secondPageImage = bigImage);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecondPage(),
                          ),
                        );
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Divider(),
                            Image.network(smallImage),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Author: ',
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    author,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Helvetica',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: Image.network(secondPageImage),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
