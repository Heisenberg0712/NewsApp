import 'package:flutter/material.dart';
import 'apicall.dart';
import 'model.dart';
import 'package:url_launcher/url_launcher.dart';

class newsList extends StatefulWidget {
  newsList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _newsListState createState() => _newsListState();
}

class _newsListState extends State<newsList> {
  Future<Welcome> wallStreetnewsResult;
  Future<Welcome> techNewsResult;
  @override
  @override
  void initState() {
    super.initState();
    wallStreetnewsResult = getWallStreetNews();
    techNewsResult = getTechNews();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Container(
        child: futurefunc(),
      ),
    );
  }

  FutureBuilder<Welcome> futurefunc() {
    return FutureBuilder<Welcome>(
      future: techNewsResult,
      builder: (BuildContext context, Welcome) {
        if (Welcome.hasData) {
          return ListView.builder(
            itemCount: Welcome.data.articles.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: cardFunc(Welcome, index),
              );
            },
          );
        } else if (Welcome.hasError) {
          return (Text("${Welcome.error}"));
        }
        return Align(
          child: CircularProgressIndicator(),
          alignment: Alignment.center,
        );
      },
    );
  }

  Card cardFunc(AsyncSnapshot<Welcome> Welcome, int index) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Image.network(Welcome.data.articles[index].urlToImage),
            ListTile(
              leading: Icon(Icons.view_compact_outlined),
              title: Text(Welcome.data.articles[index].title),
              subtitle: Text(Welcome.data.articles[index].author),
              onTap: () async {
                if (await canLaunch(Welcome.data.articles[index].url)) {
                  launch(Welcome.data.articles[index].url);
                }
              },
            )
          ],
        ));
  }
}
