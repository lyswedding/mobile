import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/liste/components/task_component.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/services/task_list.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/utils.dart';

class ListTasks extends StatefulWidget {
  List<Task> listTasks;
  String? idList;
  bool isAdmin;
  ListTasks({required this.listTasks, this.idList,this.isAdmin=true});

  @override
  _ListTasksState createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  bool isInCall = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "List tasks",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildListTasks(),
      ),
    );
  }

  Widget _buildListTasks() {
    return ListView.builder(
        itemCount: widget.listTasks.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          var animation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve:
                  const Interval((1 / 6) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          );
          animationController.forward();
          var item = index.toString();
          return widget.isAdmin?TaskComponent(
            task: widget.listTasks[index],
            animationController: animationController,
            text: 'text',
            animation: animation,
            idList: widget.idList,
          ):Dismissible(
            background: Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        EvaIcons.trash,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
                color: const Color(0xffD8E2DC)),
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              checkIfTokenExists((){
                _deleteTask(widget.listTasks[index].id);
              }, context);
            },
            child: TaskComponent(
              task: widget.listTasks[index],
              animationController: animationController,
              text: 'text',
              animation: animation,
              idList: widget.idList,
            ),
          );
        });
  }

  _deleteTask(idTask)async {
    print(widget.idList);
    print(idTask);
    await ListCalls.deletTaskListFromTaskList(widget.idList, idTask)
        .then((value) => print(value.body));
    setState(() {
      isInCall = true;
    });
  }
}
