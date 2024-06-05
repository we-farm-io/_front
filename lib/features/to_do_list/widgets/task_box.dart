import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/to_do_list/models/task.model.dart';
import 'package:smart_farm/features/to_do_list/providers/tasks_provider.dart';
import 'package:smart_farm/features/to_do_list/widgets/dialog_button.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskBox extends StatefulWidget {
  final Task task;
  const TaskBox({
    super.key,
    required this.task,
  });

  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(builder: (context, tasksprovider, child) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(220, 232, 214, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.task.title,
                style: const TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.task.startTime} to ${widget.task.endTime}',
                    style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 120,
                    height: 35,
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.task.state == 'To Do'
                                      ? IconButton(
                                          onPressed: () {},
                                          icon: DialogButton(
                                            buttonText:
                                                AppLocalizations.of(context)!
                                                    .taskStarted,
                                            onPressed: () {
                                              tasksprovider.setTaskState(
                                                  widget.task, 'In progress');
                                              Navigator.of(context).pop();
                                            },
                                            color: Palette.buttonGreen,
                                          ),
                                        )
                                      : Container(
                                          height: 0,
                                        ),
                                  widget.task.state != 'Done'
                                      ? IconButton(
                                          onPressed: () {},
                                          icon: DialogButton(
                                            buttonText:
                                                AppLocalizations.of(context)!
                                                    .taskCompleted,
                                            onPressed: () {
                                              tasksprovider.setTaskState(
                                                  widget.task, 'Done');
                                              Navigator.of(context).pop();
                                            },
                                            color: Palette.buttonGreen2,
                                          ),
                                        )
                                      : Container(
                                          height: 0,
                                        ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: DialogButton(
                                      buttonText:
                                          AppLocalizations.of(context)!
                                              .deleteTask,
                                      onPressed: () {
                                        tasksprovider.deleteTask(widget.task);
                                        Navigator.of(context).pop();
                                      },
                                      color: const Color.fromARGB(
                                          255, 199, 90, 83),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Text(
                        widget.task.state,
                        style: const TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(52, 206, 108, 1),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
