import 'package:flutter/material.dart';
import 'package:local_database/models/book_staging_model.dart';
import 'package:local_database/screens/book_screen.dart';
import 'package:local_database/authentication/email_password/screens/sign_in_screen.dart';

import '../models/note_model.dart';
import '../services/database_helper.dart';
import '../widgets/note_widget.dart';
import '../widgets/book_widget.dart';

import 'note_screen.dart';


class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override

  void onCompleteHandler(BookStaging bookStaging){
    DatabaseHelper.toggleComplete(bookStaging);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Books'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                // MaterialPageRoute(builder: (context) => const BookScreen()));
                MaterialPageRoute(builder: (context) => const SignInScreen()));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<BookStaging>?>(
          future: DatabaseHelper.getAllBookStaging(),
          builder: (context, AsyncSnapshot<List<BookStaging>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => BookWidget(

                    bookStaging: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookScreen(
                                bookStaging: snapshot.data![index],
                              )));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              // title: const Text(
                              //     'Are you sure you want to delete this note?'),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.red)),
                                  onPressed: () async {
                                    await DatabaseHelper.deleteBookStaging(
                                        snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text('Delete'),
                                ),
                                ElevatedButton(
                                  onPressed: () => {

                                    Navigator.pop(context)
                                  },
                                  child: const Text('Edit Book'),
                                ),
                              ],
                            );
                          });
                    },
                    onComplete: DatabaseHelper.toggleComplete,
                    onEdit: (){},
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('No notes yet'),
              );
            }
            return const SizedBox.shrink();
          },
        )
    );
  }
}
