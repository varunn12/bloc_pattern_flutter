import 'model.dart';
import 'bloc.dart';

import 'package:flutter/widgets.dart';

class InheritedProvider extends InheritedWidget{
  final MovieBloc movieBloc;


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
   return true;
  }

  static MovieBloc of(BuildContext context)=>
            (context.inheritFromWidgetOfExactType(InheritedProvider) as InheritedProvider)
            .movieBloc;

  InheritedProvider({Key key, MovieBloc movieBloc, Widget child})
    : this.movieBloc=movieBloc??MovieBloc(API()),
    super(child: child,key: key);
  }


