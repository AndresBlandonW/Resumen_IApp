// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:resume_iapp/bloc/home_event.dart';
import 'package:resume_iapp/bloc/home_state.dart';
import 'package:resume_iapp/services/gptService.dart';
import 'package:resume_iapp/provider/chatsProvider.dart' as globals;


class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final GptService _gptService;

  HomeBloc(this._gptService) : super(HomeLoadingState()) {
    on<LoadApiEvent>((event, emit) async {
      emit(HomeLoadingState());
      
      String result = "resumen del libro ${event.book}";

      if (event.type == 2) {
        result = event.book;
        if (!result.contains('?')) {
          result = '$result?';
        }
      }
      Map format = {"role": "user", "content": result};
      globals.ChatAsks.conversations.add(format);
      print(globals.ChatAsks.conversations);
      
      final gpt = await _gptService.getGptResponse(event.book);
      emit(HomeLoadedState(gpt.choices));
    });
  }
}