import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: DemoHomeScreen(),
    );
  }
}

class DemoHomeScreen extends StatefulWidget {
  @override
  _DemoHomeScreenState createState() => _DemoHomeScreenState();
}

class _DemoHomeScreenState extends State<DemoHomeScreen>
    with SingleTickerProviderStateMixin {
  PageController _controller = PageController(
    initialPage: 0,
  );

  int currentPageIndex;
  void pageviewListener(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  void initState() {
    currentPageIndex = 0;
    _pages = <Widget>[
      Column(
        children: [
          SizedBox(
            height: 400,
          ),
          Text(
            "Page 1",
            style: TextStyle(fontSize: 15),
          ),
          FlutterLogo(
            textColor: Colors.blue,
            size: 100,
          ),
          RaisedButton(
              child: Text("Next"),
              onPressed: () {
                setState(() {
                  _controller.animateToPage(1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease);
                  this.currentPageIndex = 1;
                });
              }),
        ],
      ),
      Column(
        children: [
          SizedBox(
            height: 400,
          ),
          Text(
            "Page 2",
            style: TextStyle(fontSize: 15),
          ),
          FlutterLogo(
            style: FlutterLogoStyle.stacked,
            textColor: Colors.red,
            size: 200,
          ),
          RaisedButton(
              child: Text("Next"),
              onPressed: () {
                setState(() {
                  _controller.animateToPage(2,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease);
                  this.currentPageIndex = 2;
                });
              })
        ],
      ),
      Column(
        children: [
          SizedBox(
            height: 400,
          ),
          Text(
            "Page 3",
            style: TextStyle(fontSize: 15),
          ),
          FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            textColor: Colors.green,
            size: 200,
          ),
          RaisedButton(child: Text("Next"), onPressed: () {}),
        ],
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<Widget> _pages;
  void gotoNextPage() {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Project"),
        ),
        body: Stack(
          children: [
            PageView.builder(
                onPageChanged: pageviewListener,
                controller: _controller,
                itemBuilder: (BuildContext context, int index) {
                  if (index < _pages.length) return _pages[index];
                  return null;
                }),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 10,
              child: new Container(
                padding: const EdgeInsets.all(20.0),
                child: new Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                        _pages.length, buildRawMaterialButton),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RawMaterialButton buildRawMaterialButton(int index) {
    return RawMaterialButton(
      onPressed: null,
      elevation: 2.0,
      fillColor: Colors.white,
      child: Icon(
        index < currentPageIndex
            ? Icons.check
            : index == currentPageIndex
                ? Icons.circle
                : null,
      ),
      shape: CircleBorder(side: BorderSide(width: 2)),
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController controller = PageController();
  List<Widget> _list = <Widget>[
    new Center(
        child: new Pages(
      text: "Page 1",
    )),
    new Center(
        child: new Pages(
      text: "Page 2",
    )),
    new Center(
        child: new Pages(
      text: "Page 3",
    )),
    new Center(
        child: new Pages(
      text: "Page 4",
    ))
  ];
  int _number = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Project"),
          backgroundColor: Colors.blue[500],
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Page: " +
                    (_number + 1).toString() +
                    "/" +
                    _list.length.toString(),
                textScaleFactor: 1.5,
              ),
            )
          ],
        ),
        body: PageView(
          children: _list,
          scrollDirection: Axis.horizontal,
          // reverse: true,
          physics: BouncingScrollPhysics(),
          controller: controller,
          onPageChanged: (num) {
            setState(() {
              _number = num;
            });
          },
        ));

    /* floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _list.add(
                        new Center(
                            child: new Text("New page",
                                style: new TextStyle(fontSize: 35.0))),
                      );
                    });
                    if (_number != _list.length - 1)
                      controller.jumpToPage(_number + 1);
                    else
                      controller.jumpToPage(0);
                  },
                  child: Icon(Icons.add)),
              FloatingActionButton(
                  onPressed: () {
                    _list.removeAt(_number);
                    setState(() {
                      controller.jumpToPage(_number - 1);
                    });
                  },
                  child: Icon(Icons.delete)),
            ]));*/
  }
}

class Pages extends StatelessWidget {
  final text;
  Pages({this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
              ),
            ),
          ]),
    );
  }
}

class ScrollView extends StatelessWidget {
  final dataKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      primary: true,
      appBar: new AppBar(
        title: const Text('Home'),
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new SizedBox(
                height: 160.0, width: double.infinity, child: new Card()),
            new SizedBox(
                height: 160.0, width: double.infinity, child: new Card()),
            new SizedBox(
                height: 160.0, width: double.infinity, child: new Card()),
            // destination
            new Card(
              key: dataKey,
              child: new Text("data\n\n\n\n\n\ndata"),
            )
          ],
        ),
      ),
      bottomNavigationBar: new RaisedButton(
        onPressed: () => Scrollable.ensureVisible(dataKey.currentContext),
        child: new Text("Scroll to data"),
      ),
    );
  }
}*/
