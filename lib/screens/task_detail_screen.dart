import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/views/due_date_element_view.dart';
import '../services/theme_service.dart';

class TaskDetailScreen extends StatefulWidget {
  static const id = "new_screen";
  final ToDo? toDo;

  const TaskDetailScreen({Key? key, this.toDo}) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {


  late ToDo _toDo;
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  initState() {
    super.initState();
    _getTodo();
  }

  void _getTodo() {
    _toDo = widget.toDo!;
    titleController = TextEditingController(text: _toDo.taskName);
    contentController = TextEditingController(text: _toDo.taskContent);
  }

  void _addOrRemoveToDoInImportant(ToDo toDo) {
    // TODO this note's isImportant field changed and changed database
    setState((){
      toDo.isImportant = !toDo.isImportant;
    });
  }

  void _selectDueDate() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: ThemeService.colorBackgroundLight,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text("Due", style: ThemeService.textStyleHeader(),),
                ),
                const Divider(color: ThemeService.colorBlack,),
                DueDateElement(onTap: () {}, title: "Today",),
                DueDateElement(onTap: () {}, title: "Tomorrow",),
                DueDateElement(onTap: () {}, title: "Next Week",),
                DueDateElement(onTap: () {}, title: "Pick a Date", visible: true,),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: ThemeService.colorBackgroundLight,
        title: Text(
          "Task List",
          style: ThemeService.textStyleHeader(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ThemeService.colorBlack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 34),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 18,
                                  ),
                                  width: 24,
                                  height: 24,
                                  child: Checkbox(
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _toDo.isCompleted = value!;
                                      });
                                    },
                                    value: _toDo.isCompleted,
                                  ),
                                ),
                                const SizedBox(
                                  width: 19,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  child: TextField(
                                    controller: titleController,
                                    style: ThemeService.textStyleHeader(),
                                    decoration: const InputDecoration(
                                      hintText: "Text Name",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 20),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => _addOrRemoveToDoInImportant(_toDo),
                                  icon: _toDo.isImportant ? const Icon(CupertinoIcons.star_fill, color: ThemeService.colorPink) : const Icon(CupertinoIcons.star),
                                ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Divider(
                          thickness: 1,
                          color: Color(0x1f1c1b1f),
                        ),
                      ),
                      GestureDetector(
                        onTap: _selectDueDate,
                        child: _toDo.dueDate == null
                            ? Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 18,
                                ),
                                width: 24,
                                height: 24,
                                child:Icon(
                                  Icons.edit_calendar,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(
                                width: 19,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add Due Date',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                            :Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                        left: 18,
                                      ),
                                      width: 24,
                                      height: 24,
                                      child: const Icon(
                                        Icons.edit_calendar,
                                        color: Color(0xff5946D2),
                                      )
                                  ),
                                  const SizedBox(
                                    width: 19,
                                  ),
                                  const Text(
                                    'Due Sun, 10 April',
                                    style: TextStyle(
                                        color: Color(0xff5946D2),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.only(right: 33),
                                  child: Icon(Icons.backspace_outlined, color: Colors.grey.shade700, size: 20,)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Divider(
                          thickness: 1,
                          color: Color(0x1f1c1b1f),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 248,
                        child: const TextField(
                          maxLines: 13,
                          decoration: InputDecoration(
                              hintText: "Add Note",
                              helperStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0x991c1b1f)),
                              border: InputBorder.none),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Divider(
                          thickness: 2,
                          color: Color(0x1f1c1b1f),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
            const SizedBox(height: 170,),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(left: 20, right: 23),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Created on Mon, 28 March",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0x991c1b1f),
                    ),
                  ),
                  Icon(Icons.delete_outline, color: Color(0x991c1b1f))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


