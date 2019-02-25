import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:popular_movie/movie.dart';
import 'package:popular_movie/pages/movie_detail.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var url =
      "http://api.themoviedb.org/3/movie/popular?api_key=b5481a85cbb44c13c6c6931834845104&page=1";

  MovieHub movieHub;

  @override
  void initState() {
    super.initState();
    //print("Ini");
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    // print(decodedJson);
    movieHub = MovieHub.fromJson(decodedJson);
    // print(movieHub.toJson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular"),
        backgroundColor: Colors.cyan,
      ),
      body: movieHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: movieHub.movie
                  .map((movie) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetail(
                                          movie: movie,
                                        )));
                          },
                          child: Hero(
                            tag: movie.backdrop_path,
                            child: Card(
                              elevation: 1.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AspectRatio(
                                      aspectRatio: 18.0 / 12.0,
                                      child: Image.network(
                                          "http://image.tmdb.org/t/p/w342" +
                                              movie.backdrop_path)),
                                  new Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            movie.title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Color(0xFFD73C29),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
      /* drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),*/
    );
  }
}
