// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/profile/screens/profile.dart';
import 'package:smart_farm/features/to_do_list/models/task.model.dart';
import 'package:smart_farm/features/to_do_list/providers/tasks_provider.dart';
import 'package:smart_farm/features/to_do_list/screens/add_task.dart';
import 'package:smart_farm/features/to_do_list/widgets/task_box.dart';
import 'package:smart_farm/features/to_do_list/widgets/time_line.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import '../widgets/do_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<TasksProvider>(context, listen: false).fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(builder: (context, tasksprovider, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          forceMaterialTransparency: true,
          title: SvgPicture.asset('assets/logos/AgriTech.svg'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            icon: SvgPicture.asset('assets/icons/back_arrow.svg'),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: SvgPicture.asset('assets/icons/notification_active.svg'),
                onPressed: () {}, // for notifications functionnality
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                AppLocalizations.of(context)!.todaysTasks,
                style: const TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TimeLine(),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    DoButton(
                      buttonText: AppLocalizations.of(context)!.all,
                      isSelected: tasksprovider.selectedFilter == 'All',
                      onPressed: () {
                        tasksprovider.setFilter('All');
                        tasksprovider.fetchTasks();
                      },
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    DoButton(
                      buttonText: AppLocalizations.of(context)!.toDo,
                      isSelected: tasksprovider.selectedFilter == 'To Do',
                      onPressed: () {
                        tasksprovider.setFilter('To Do');
                        tasksprovider.fetchTasks();
                      },
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    DoButton(
                      buttonText: AppLocalizations.of(context)!.inProgress,
                      isSelected: tasksprovider.selectedFilter == 'In progress',
                      onPressed: () {
                        tasksprovider.setFilter('In progress');
                        tasksprovider.fetchTasks();
                      },
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    DoButton(
                        buttonText: AppLocalizations.of(context)!.done,
                        isSelected: tasksprovider.selectedFilter == 'Done',
                        onPressed: () {
                          tasksprovider.setFilter('Done');
                          tasksprovider.fetchTasks();
                        }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.41,
              child: FutureBuilder<List<Task>>(
                future: tasksprovider.toDoList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Palette.buttonGreen,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child:
                          Text(AppLocalizations.of(context)!.errorLoadingTasks),
                    );
                  } else {
                    final todos = snapshot.data!;
                    return todos.isEmpty
                        ? Center(
                            child: Text(
                              AppLocalizations.of(context)!.noTasksHere,
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : ListView.builder(
                            itemCount: todos.length,
                            itemBuilder: (BuildContext context, int index) {
                              final todo = todos[index];
                              return TaskBox(
                                task: todo,
                              );
                            },
                          );
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AddTaskPage()),
              );
            },
            elevation: 0,
            backgroundColor: Palette.buttonGreen,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      );
    });
  }
}
