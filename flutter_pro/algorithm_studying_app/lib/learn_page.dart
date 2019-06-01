import 'package:flutter/material.dart';

class LearnPage extends StatelessWidget {
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

class BodyWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      final titles = ['Get Started', 'Basics', 'Data Preprocessing', 'Linear Regression',
      'Decision Tree', 'Naive Bayes', 'KNN', 'K-means Clustering', 'SVM'];
      
      return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(18),
            elevation: 7.0,
            child: Center( 
              child: ListTile(
                title: Text(titles[index]),
            ),
          ),
        );
      },
    );
  }
}