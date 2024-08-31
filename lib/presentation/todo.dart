import 'package:flutter/material.dart';
import 'package:todo_unmodified/domain/todo/todo_model.dart';

class ScreenTodo extends StatefulWidget {
  const ScreenTodo({super.key});

  @override
  State<ScreenTodo> createState() => _ScreenTodoState();
}

class _ScreenTodoState extends State<ScreenTodo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<TodoModel> todoList = [
    // TodoModel(todoId: '1', todoName: 'Birthday', todoStatus: '1'),
    // TodoModel(todoId: '2', todoName: 'Anniversary', todoStatus: '1'),
    // TodoModel(todoId: '3', todoName: 'School', todoStatus: '0'),
    // TodoModel(todoId: '4', todoName: 'College', todoStatus: '0'),
    // TodoModel(todoId: '5', todoName: 'Hotel', todoStatus: '0'),
    // TodoModel(todoId: '6', todoName: 'Travel', todoStatus: '0'),
    // TodoModel(todoId: '7', todoName: 'Holiday', todoStatus: '0'),
    // TodoModel(todoId: '8', todoName: 'Lab', todoStatus: '0'),
    // TodoModel(todoId: '9', todoName: 'Exam', todoStatus: '0'),
    // TodoModel(todoId: '10', todoName: 'Calculator', todoStatus: '0'),
    // TodoModel(todoId: '11', todoName: 'Bag', todoStatus: '0'),
    // TodoModel(todoId: '12', todoName: 'Train', todoStatus: '0'),
  ];
  final todoController = TextEditingController();
  int id = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo App',
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                  child: Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Task cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                              controller: todoController,
                              decoration: const InputDecoration(
                                  hintText: 'Enter your Task here..',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              TodoModel todoModel = TodoModel(
                                  todoId: (id + 1).toString(),
                                  todoName: todoController.text,
                                  todoStatus: '0');
                              id = id + 1;
                              setState(() {
                                todoList.add(todoModel);
                              });
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(Colors.pink)),
                          child: const Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            const Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * .7,
              child: ListView.separated(
                  itemBuilder: (context, int index) {
                    return ListTile(
                      onTap: () {
                        updateTodo(todoList[index].todoId);
                      },
                      leading: Text(index.toString()),
                      title: Text(
                        todoList[index].todoName,
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        todoList[index].todoStatus == '0'
                            ? 'Not Completed'
                            : 'Completed',
                        style: TextStyle(
                            color: todoList[index].todoStatus == '0'
                                ? Colors.red
                                : Colors.green),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            deleteTodo(todoList[index].todoId);
                          },
                          icon: const Icon(Icons.delete)),
                    );
                  },
                  separatorBuilder: (context, int index) {
                    return const Divider();
                  },
                  itemCount: todoList.length),
            )
          ],
        ),
      ),
    );
  }

  void deleteTodo(String id) {
    setState(() {
      todoList.removeWhere((todo) => todo.todoId == id);
    });
  }

  void updateTodo(String id) {
    setState(() {
      for (var doc in todoList) {
        if (doc.todoId == id) {
          doc.todoStatus == '0' ? doc.todoStatus = '1' : doc.todoStatus = '0';
        }
      }
    });
  }
}
