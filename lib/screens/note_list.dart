import 'dart:async';
import 'package:aplicacion_final/db_helper/db_helper.dart';
import 'package:aplicacion_final/modal_class/notes.dart';
import 'package:aplicacion_final/screens/note_detail.dart';
import 'package:aplicacion_final/screens/search_note.dart';
import 'package:aplicacion_final/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  int axisCount = 2;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }




    Widget myAppBar() {
      return AppBar(
        title: Text('Mis notas', style: TextStyle(color: Colors.white)),
        elevation: 0,
        backgroundColor: Colors.orange,
        leading: noteList.length == 0
            ? Container()
            : IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () async {
            final Note result = await showSearch(
                context: context, delegate: NotesSearch(notes: noteList));
            if (result != null) {
              navigateToDetail(result, 'Editar nota');
            }
          },
        ),
        actions: <Widget>[
          noteList.length == 0
              ? Container(

          )
              : IconButton(
            icon: Icon(
              axisCount == 2 ? Icons.list : Icons.grid_on,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                axisCount = axisCount == 2 ? 4 : 2;
              });
            },
          )
        ],
      );
    }

    return Scaffold(
      appBar: myAppBar(),
      body: noteList.length == 0
          ? Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Presione el boton + para crear una nueva nota',
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ),
      )
          : Container(
        color: Colors.white,
        child: getNotesList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Note('', '', 3, 0), 'Detalles');

        },

        tooltip: 'Add Note',
        shape: CircleBorder(side: BorderSide(color: Colors.orange, width: 2.0)),
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget getNotesList() {
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: count,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          navigateToDetail(this.noteList[index], 'Editar nota');
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: colors[this.noteList[index].color],
                border: Border.all(width: 2, color: Colors.orange),
                borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          this.noteList[index].title,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                    Text(
                      getPriorityText(this.noteList[index].priority),
                      style: TextStyle(
                          color: getPriorityColor(
                              this.noteList[index].priority)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                            this.noteList[index].description == null
                                ? ''
                                : this.noteList[index].description,
                            style: Theme.of(context).textTheme.bodyText2),
                      )
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(this.noteList[index].date,
                          style: Theme.of(context).textTheme.subtitle2),
                    ])
              ],
            ),
          ),
        ),
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(axisCount),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      case 3:
        return Colors.green;
        break;

      default:
        return Colors.yellow;
    }
  }

  String getPriorityText(int priority) {
    switch (priority) {
      case 1:
        return '!!!';
        break;
      case 2:
        return '!!';
        break;
      case 3:
        return '!';
        break;

      default:
        return '!';
    }
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NoteDetail(note, title)));
    {
    if (result == true)
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
          this.count = noteList.length;
        });
      });
    });
  }
}
