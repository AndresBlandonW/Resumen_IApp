import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resume_iapp/bloc/home_bloc.dart';
import 'package:resume_iapp/bloc/home_event.dart';
import 'package:resume_iapp/bloc/home_state.dart';
import 'package:resume_iapp/services/gptService.dart';


// ignore: must_be_immutable
class BookResult extends StatefulWidget {
  String bookToSearch;
  BookResult({super.key, required this.bookToSearch});

  @override
  State<BookResult> createState() => _BookResultState();
}

class _BookResultState extends State<BookResult> {
  TextEditingController ask = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc(context.read<GptService>())..add(LoadApiEvent(widget.bookToSearch, 1)),),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Resume IAPP')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is HomeLoadedState) {
                      ask.text = "";

                      return Column(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                  const Text("Resumen del libro", style: TextStyle(fontSize: 25)),
                                  Text(widget.bookToSearch, style: const TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                        
                          Flexible(
                            flex: 5,
                            child: Container(
                              decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(10)),
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: SelectableText(state.content[0].message.content.toString()),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      flex: 5,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 255, 255, 255), border: Border.all(color: const Color(0xFF5D5D67)), borderRadius: BorderRadius.circular(15)),
                                        child: TextFormField(
                                          controller: ask,
                                          minLines: 1,
                                          maxLines: 1,
                                          decoration:
                                              const InputDecoration(border: InputBorder.none, hintText: 'Haz una pregunta sobre este libro'),
                                        ),
                                      )),
                                  const SizedBox(width: 7),
                                  Flexible(
                                      flex: 1,
                                      child: TextButton(
                                        child: const Icon(
                                          Icons.send_rounded,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          BlocProvider.of<HomeBloc>(context).add(LoadApiEvent(ask.text.trim(), 2));
                                        },
                                      ))
                                ],
                              ),
                            ),
                          )

                        ],
                      );
                    }
                    return Container();
                  },
                ),
          ),
        )
            ),
      );
  }
}