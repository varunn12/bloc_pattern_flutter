import 'dart:async';
import 'model.dart';

import 'package:rxdart/rxdart.dart';

class MovieBloc{
  final API api;

  Stream<List<Movie>> _results=Stream.empty();
  Stream<String> _log=Stream.empty();

  ReplaySubject<String> _query =ReplaySubject<String>();

  //getters method to access Stream outside this bloc
  Stream<String> get log=>_log;
  Stream<List<Movie>> get results=>_results;
  Sink<String> get query=>_query;


  MovieBloc(this.api){
    //distinct allows us to specify that we only want the events from the stream that are distinct
    //if user stops typing we will have same event over and over again and since we don't want to continually ping to
    //the api. We use distinct
    //BroadcastStream allows multiple subscribers
    _results=_query.distinct().asyncMap(api.get).asBroadcastStream();
    _log=Observable(results)
          .withLatestFrom(_query.stream,(_,query)=>'Results for $query' )
          .asBroadcastStream();
  }

  void dispose(){
    //we want to dispose query stream because streams in dart do not naturally dispose themselves. Leaving them open
    //can cause performance problems
    //Other two streams are originating from the bloc rather than coming into the bloc so not disposing them
    //query is coming from the Uri and going into the bloc

    _query.close();
  }

}