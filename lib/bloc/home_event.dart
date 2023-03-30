import 'package:equatable/equatable.dart';


abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadApiEvent extends HomeEvent {
  final int type;
  final String book;

  LoadApiEvent(this.book, this.type);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}