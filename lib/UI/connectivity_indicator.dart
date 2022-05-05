import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:lys_wedding/UI/home/screens/buttom-navigation-bar.dart';

class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                height: 24.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                  child: Center(
                    child: Text("${connected ? 'ONLINE' : 'OFFLINE'}"),
                  ),
                ),
              ),
              connected
                  ? Home()
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(EvaIcons.wifiOff,size: 70,),
                          Text(
                            'Turn on your internet connection',
                          ),
                        ],
                      ),
                    ),
            ],
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'There are no bottons to push :)',
            ),
            Text(
              'Just turn off your internet.',
            ),
          ],
        ),
      ),
    );
  }
}
