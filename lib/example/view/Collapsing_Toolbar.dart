import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// https://www.developerlibs.com/2018/08/flutter-collapsing-toolbar-layout.html

main() => runApp(
    Home()
    //Collapsing()
    //MyApp()
    //
    );

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Home"),
        ),
      ),
    );
  }
}

class Collapsing extends StatelessWidget {
  build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.yellowAccent,
        appBar: new AppBar(
          leading: new Icon(Icons.menu),
          title: new Text("Developer Libs"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            new IconButton(
              icon: new Icon(Icons.monetization_on),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFF167F67),
      ),
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/': (context) => CollapsingTab(),
        // When we navigate to the "/profile" route, build the SecondScreen Widget
        '/profile': (context) => CollapsingProfile(),
      },
    );
  }
}

class CollapsingTab extends StatefulWidget {
  @override
  _CollapsingTabState createState() => new _CollapsingTabState();
}

class _CollapsingTabState extends State<CollapsingTab> {
  ScrollController scrollController;

  Widget _buildActions() {
    Widget profile = new GestureDetector(
      onTap: () => showProfile(),
      child: new Container(
        height: 30.0,
        width: 45.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
          image: new DecorationImage(
            image: new ExactAssetImage("assets/logo.png"),
            fit: BoxFit.cover,
          ),
          border: Border.all(color: Colors.black, width: 2.0),
        ),
      ),
    );

    double scale;
    if (scrollController.hasClients) {
      scale = scrollController.offset / 300;
      scale = scale * 2;
      if (scale > 1) {
        scale = 1.0;
      }
    } else {
      scale = 0.0;
    }

    return new Transform(
      transform: new Matrix4.identity()..scale(scale, scale),
      alignment: Alignment.center,
      child: profile,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    var flexibleSpaceWidget = new SliverAppBar(
      expandedHeight: 200.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text("Developer Libs",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              )),
          background: Image.asset(
            "assets/logo.png",
          )),
      actions: <Widget>[
        new Padding(
          padding: EdgeInsets.all(5.0),
          child: _buildActions(),
        ),
      ],
    );

    return Scaffold(
      body: new DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              flexibleSpaceWidget,
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.black26,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.account_box),
                        text: "Detail",
                      ),
                      Tab(icon: Icon(Icons.add_location), text: "Address"),
                      Tab(icon: Icon(Icons.monetization_on), text: "Earning"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: new TabBarView(
            children: <Widget>[
              //new TabScreen("Detail"),
              //new TabScreen("Address"),
              //new TabScreen("Earning"),
              Container(
                child: Center(
                  child: Text("Detail"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("Address"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("Earning"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showProfile() {
    Navigator.pushNamed(context, '/profile');
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class CollapsingProfile extends StatefulWidget {
  CollapsingProfile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CollapsingProfileState createState() => new _CollapsingProfileState();
}

class _CollapsingProfileState extends State<CollapsingProfile> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Builder(
        builder: (context) => new SliverContainer(
          floatingActionButton: new Container(
            height: 60.0,
            width: 60.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
              image: new DecorationImage(
                image: new ExactAssetImage("assets/logo.png"),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.black, width: 2.0),
            ),
          ),
          expandedHeight: 256.0,
          slivers: <Widget>[
            new SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              expandedHeight: 256.0,
              pinned: true,
              flexibleSpace: new FlexibleSpaceBar(
                title: new Text(
                  "Developer Libs",
                  style: TextStyle(color: Colors.white),
                ),
                background: new Image.asset(
                  "assets/logo.png",
                ),
              ),
            ),
            new SliverList(
              delegate: new SliverChildListDelegate(
                new List.generate(
                  30,
                  (int index) => new ListTile(title: new Text("Item $index")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverContainer extends StatefulWidget {
  final List<Widget> slivers;
  final Widget floatingActionButton;
  final double expandedHeight;
  final double marginRight;
  final double topScalingEdge;

  SliverContainer(
      {@required this.slivers,
      @required this.floatingActionButton,
      this.expandedHeight = 256.0,
      this.marginRight = 16.0,
      this.topScalingEdge = 96.0});

  @override
  State<StatefulWidget> createState() {
    return new SliverFabState();
  }
}

class SliverFabState extends State<SliverContainer> {
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new CustomScrollView(
          controller: scrollController,
          slivers: widget.slivers,
        ),
        _buildFab(),
      ],
    );
  }

  Widget _buildFab() {
    final topMarginAdjustVal =
        Theme.of(context).platform == TargetPlatform.iOS ? 12.0 : -4.0;
    final double defaultTopMargin = widget.expandedHeight + topMarginAdjustVal;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      top -= offset > 0 ? offset : 0;
      if (offset < defaultTopMargin - widget.topScalingEdge) {
        scale = 1.0;
      } else if (offset < defaultTopMargin - widget.topScalingEdge / 2) {
        scale = (defaultTopMargin - widget.topScalingEdge / 2 - offset) /
            (widget.topScalingEdge / 2);
      } else {
        scale = 0.0;
      }
    }

    return new Positioned(
      top: top,
      right: widget.marginRight,
      child: new Transform(
        transform: new Matrix4.identity()..scale(scale, scale),
        alignment: Alignment.center,
        child: widget.floatingActionButton,
      ),
    );
  }
}
