import 'dart:async';

import 'package:flashtask/models/launch.dart';
import 'package:flashtask/models/past_launches.dart';
import 'package:flashtask/services/launch_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   Timer timer;
   Launch launch;
   String countdown;
   Future<List<PastLaunches>> futureData;

  @override
  void initState() {
    var launchService = LaunchService();
    countdown = '';
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      var diff = launch.launchUTC.difference(DateTime.now().toUtc());
      setState(() {
        countdown = durationToString(diff);
      });
    });
    super.initState();
    futureData = launchService.fetchPastLaunches();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    launch = Provider.of<Launch>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('SpaceX Rockets', style: GoogleFonts.ubuntu()),
        centerTitle: true,
      ),
      body: (launch != null)
          ? Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Next Launch',
                            style: GoogleFonts.ubuntu(
                                fontSize: 12.0, color: Colors.yellow)),
                      ),
                      Text(countdown,
                          style: GoogleFonts.sourceCodePro(fontSize: 25.0)),
                      Text(launch.rocket.rocketName,
                          style: GoogleFonts.ubuntu(fontSize: 20.0)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Past Launches',
                          style: GoogleFonts.ubuntu(
                              fontSize: 18.0, color: Colors.yellow)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: FutureBuilder<List<PastLaunches>>(
                        future: futureData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<PastLaunches> data = snapshot.data;
                            return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    color: Colors.black54,
                                    child: Card(
                                      child: ListTile(
                                        title: Text(
                                          "RocketName: " + data[index].name,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          "Date: " +
                                              data[index].dateUtc.toString(),
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white),
                                        ),
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) => Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 4.0,
                                                      ),
                                                      Container(
                                                        height: 60.0,
                                                        width: 60.0,
                                                        child: Image.asset(
                                                            "assets/rocket.png"),
                                                      ),
                                                      Text(
                                                        data[index].name,
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.yellow),
                                                      ),
                                                      SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      Text(
                                                        data[index]
                                                            .dateUtc
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      SizedBox(
                                                        height: 4.0,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Details: " +
                                                              data[index]
                                                                  .details,
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "PayLoads: " +
                                                              data[index]
                                                                  .payloads
                                                                  .first,
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Video: "+
                                                              data[index].links.runtimeType.toString(),
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ));
                                        },
                                      ),
                                      elevation: 4,
                                      shadowColor: Colors.green,
                                      margin: EdgeInsets.all(6),
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                    ),
                                  );
                                });
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return Text("");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  String durationToString(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
