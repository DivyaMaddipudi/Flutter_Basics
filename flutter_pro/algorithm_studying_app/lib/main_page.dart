import 'package:flutter/material.dart';
import 'learn_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Study App')),
        body: BodyWidget(),
      ),
    );
  }
}

String learnUrl = "http://www.myiconfinder.com/uploads/iconsets/256-256-db2b4d88c93d0fbda843267378c4329e-ibooks.png";

String codeUrl ="https://cdn1.iconfinder.com/data/icons/internet-12/256/19-512.png";

class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(learnUrl),
          ),
          title: Text('Learn'),
          subtitle: Text('Explaination of all the algorithms'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LearnPage(),
              ),
            );
          },
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(codeUrl),
          ),
          title: Text('Code'),
          subtitle: Text('Coding for all the algorithms'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            print('Code');
          },
        ),
      ],
    );
  }
}
