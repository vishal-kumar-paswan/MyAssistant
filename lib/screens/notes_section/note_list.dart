import 'dart:async';
import 'package:assistant/database/notes_database.dart';
import 'package:assistant/models/notes_section/notes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import '../notes_section/note_detail.dart';

class NotesSection extends StatefulWidget {
  const NotesSection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NotesSectionState();
  }
}

class NotesSectionState extends State<NotesSection> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note>? noteList = null;
  int count = 0;
  int axisCount = 2;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = [];
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_back),
          onPressed: () => Get.toNamed('/homepage'),
        ),
        title: Text(
          'MyNotes',
          style: TextStyle(
              fontFamily: GoogleFonts.nunito().fontFamily,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: noteList!.isEmpty
          ? Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(255, 13, 4, 44),
                  ],
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Click on the add button to add a new note!',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(255, 13, 4, 44),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: getNotesList(),
              ),
            ),
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              navigateToDetail(
                  Note(
                    100,
                    '',
                    '',
                  ),
                  'Add Note');
            },
            tooltip: 'Add Note',
            shape: const CircleBorder(
              side: BorderSide(color: Colors.black, width: 2.0),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }

  Widget getNotesList() {
    return StaggeredGridView.countBuilder(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: count,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          navigateToDetail(noteList![index], 'Edit Note');
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Text(
                  noteList![index].title,
                  style: TextStyle(
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 6.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        noteList?[index].description ?? 'Hello',
                        style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  noteList![index].date,
                  style: TextStyle(
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(axisCount),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NoteDetail(note, title)));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          count = noteList.length;
        });
      });
    });
  }
}
