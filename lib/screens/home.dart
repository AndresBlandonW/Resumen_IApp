import 'package:flutter/material.dart';
import 'package:resume_iapp/screens/book_result.dart';
import 'package:resume_iapp/provider/chatsProvider.dart' as globals;

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  TextEditingController bookToSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resume IAPP')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Image.network('https://ashmagautam.files.wordpress.com/2013/11/mcj038257400001.jpg', height: 400,),
              const SizedBox(height: 30),
              const Text('Resume libros y haz preguntas facilmente', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
              const SizedBox(height: 30),
              Card(
                  elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Que libro necesitas resumir?',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(8.0),
                        child:  Icon(Icons.search),
                      ),
                      border: InputBorder.none
                    ),
                    controller: bookToSearch,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: () {
                globals.ChatAsks.conversations = [];
                Navigator.push(context, MaterialPageRoute(builder: (context) => BookResult(bookToSearch: bookToSearch.text.trim())));
                //bookToSearch.text = "";
              }, child: const Text('Resumir'))
            ],
          )
          ),
      ),
    );
  }
}