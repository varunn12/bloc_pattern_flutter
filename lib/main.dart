import 'package:bloc_project/bloc.dart';
import 'package:bloc_project/inherited_provider.dart';
import 'package:bloc_project/model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return InheritedProvider(
      movieBloc: MovieBloc(API()),
          child: new MaterialApp(
        title: 'Bloc Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
            ),
    );
        }
      
      }
      
class MyHomePage extends StatelessWidget{

 
  @override
  Widget build(BuildContext context){
     final movieBloc=InheritedProvider.of(context);
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Bloc Example'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: new EdgeInsets.all(10.0),
            child: TextField(
              onChanged: movieBloc.query.add,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search for a movie'
              ),
            ),
          ),
          StreamBuilder(
            stream: movieBloc.log,
            builder: (context, snapshot){
              return Container(
                child: new Text(''),
               // child: Text(snapshot?.data??''),
              );
            },
          ),
          Expanded(child: StreamBuilder(
            stream: movieBloc.results,
            builder: (context, snapshot){
              if(!snapshot.hasData){
                  return new Center(
                    child: CircularProgressIndicator(),
                  );
              }
              else{
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    return new ListTile(
                      leading: CircleAvatar(
                        child: Image.network("http://image.tmdb.org/t/p/w92"+snapshot.data[index].posterPath),
                      ),
                      title: Text(snapshot.data[index].title),
                      subtitle: Text(snapshot.data[index].overview),

                    );

                  },

                );
              }
            },
          )),
        ],
      ),

    );
  }
}

