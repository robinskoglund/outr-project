import 'package:outr/API/dbapihandler.dart';
import 'package:outr/DataClasses/routedata.dart' as r;
import '../DataClasses/userdata.dart';
import 'package:flutter/material.dart';
import '../Components/navigation_bar.dart';

class SavedRoutesPage extends StatefulWidget {
  final User user;

  SavedRoutesPage(this.user);

  @override
  State<SavedRoutesPage> createState() => _SavedRoutesPageState();
}

class _SavedRoutesPageState extends State<SavedRoutesPage> {
  List<r.Route>? routes;

  void getRoutes() async {
    final myRoutes = await getAllUserRoutes(widget.user.email);
    setState(() {
      routes = myRoutes;
    });
    print("hello");
    print(myRoutes[1]);
  }

  @override
  void initState(){
    getRoutes();
    super.initState();
  }

  Widget buildBasicListView(BuildContext context){
    if(routes != null){
      return ListView(
          children: <Widget>[
            for(r.Route route in routes!)
              Route(route.typeOfWorkout, route.distance, route.nameOfRoute, route.durationInMinutes),
            SizedBox(height: 16),
            Divider(color: Colors.black),
            SizedBox(height: 16),
          ]);
    }
    return ListView(
      children: <Widget>[
        SizedBox(height: 30.0),
        ListTile(
          leading: Image.asset('assets/sadDude.png'),
          title: Text('You have not completed any workouts yet',
              style: TextStyle(fontFamily: "Dongle", fontSize: 24)
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        foregroundColor: Colors.black, //ändrar färgen på burgarmeny
        title: const Text('Saved Routes'
        ),
        titleTextStyle: TextStyle(
            fontFamily: "Dongle",
            fontSize: 44,
            color: Colors.black
        ),
        backgroundColor: Colors.white,
      ),
      endDrawer: OutrNavigationBar(widget.user),
      body: buildBasicListView(context),
    );
  }
}

class Route extends StatelessWidget{
  final String typeOfWorkout;
  final String distance;
  final String title;
  final String elapsedTime;

  Route(this.typeOfWorkout, this.distance, this.title, this.elapsedTime);

  @override
  Widget build(BuildContext context) {
    String image;

    if(typeOfWorkout == 'Beginner workout')
      image = 'assets/plainDude.png';
    else if(typeOfWorkout == 'Cardio')
      image = 'assets/cardioDude.png';
    else if(typeOfWorkout == 'Strength')
      image = 'assets/strengthDude.png';
    else
      image = 'assets/mixDude.png';

    return ListTile(
      leading: Image.asset(image),
      title: Text(title,
        style: TextStyle(
            fontFamily: "Dongle", fontSize: 24
        ),
      ),
      subtitle: Text('$elapsedTime minutes, $distance km',
        style: TextStyle(
            fontFamily: "Dongle", fontSize: 20
        ),
      ),
    );
  }
}