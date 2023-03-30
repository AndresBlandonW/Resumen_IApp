import 'package:equatable/equatable.dart';


abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {

  final List content;

  HomeLoadedState(this.content);
  @override
  List<Object> get props => [content];
}