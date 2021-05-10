import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _addToItems(String taskLabel) {
    if (taskLabel.length > 0) {
      setState(() => _todoItems.insert(0, taskLabel));
    }
  }

  //region: private methods
  Widget _buildTodoList() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return _buildToolItem(context, _todoItems[index], index);
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: _todoItems.length);
  }

  Widget _buildToolItem(BuildContext context, String todoText, int index) {
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: Key(todoText),
      onDismissed: (direction) {
        setState(() {
          _todoItems.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("「${_todoItems[index]}」のタスクを削除しました。"),
          duration: const Duration(seconds: 3),
        ));
      },
      child: ListTile(title: Text(todoText)),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
        onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                          appBar: AppBar(title: Text('新しいタスクを追加')),
                          body: TextField(
                            autofocus: true,
                            onSubmitted: (value) {
                              _addToItems(value);
                              Navigator.pop(context);
                            },
                            decoration: InputDecoration(
                                hintText: "タスクを入力してください",
                                contentPadding: const EdgeInsets.all(16.0)),
                          ))))
            },
        child: Icon(Icons.add));
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo")),
      body: _buildTodoList(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}
