import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/to_do_list/providers/tasks_provider.dart';
import 'package:smart_farm/features/to_do_list/screens/to_do_list_page.dart';
import 'package:smart_farm/features/to_do_list/widgets/text_input.dart';
import 'package:smart_farm/features/to_do_list/widgets/time_input.dart';
import 'package:smart_farm/shared/services/notifications/notifications_services.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import '../models/task.model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  Task? task;

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(builder: (context, tasksprovider, child) {
      return Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset('assets/logos/AgriTech.svg'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset('assets/icons/back_arrow.svg'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.addTask,
                    style: const TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextInput(
                    labelText: AppLocalizations.of(context)!.title,
                    prefixIcon: SvgPicture.asset(
                        'assets/icons/tasks_icons/title_icon.svg'),
                    controller: titleController,
                  ),
                  const SizedBox(height: 16),
                  TextInput(
                    labelText: AppLocalizations.of(context)!.description,
                    controller: descriptionController,
                  ),
                  const SizedBox(height: 16),
                  TimeInput(
                    labelText: AppLocalizations.of(context)!.startTime,
                    suffixIcon: const Icon(Icons.access_time_rounded,
                        color: Palette.buttonGreen),
                    controller: startTimeController,
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                          builder: (context, child) => Theme(
                              data: ThemeData().copyWith(
                                  colorScheme: const ColorScheme.light(
                                primary: Palette.buttonGreen,
                              )),
                              child: child!),
                          context: context,
                          initialTime: TimeOfDay.now());
                      if (pickedTime != null) {
                        setState(() {
                          startTimeController.text = pickedTime.format(context);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TimeInput(
                    labelText: AppLocalizations.of(context)!.endTime,
                    suffixIcon: const Icon(Icons.access_time_rounded,
                        color: Palette.buttonGreen),
                    controller: endTimeController,
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                          builder: (context, child) => Theme(
                              data: ThemeData().copyWith(
                                  colorScheme: const ColorScheme.light(
                                primary: Palette.buttonGreen,
                              )),
                              child: child!),
                          context: context,
                          initialTime: TimeOfDay.now());
                      if (pickedTime != null) {
                        setState(() {
                          endTimeController.text = pickedTime.format(context);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TimeInput(
                    labelText: AppLocalizations.of(context)!.date,
                    suffixIcon: SvgPicture.asset(
                        'assets/icons/tasks_icons/calendar_icon.svg'),
                    controller: dateController,
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                          builder: (context, child) => Theme(
                              data: ThemeData().copyWith(
                                  colorScheme: const ColorScheme.light(
                                primary: Palette.buttonGreen,
                              )),
                              child: child!),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2030));
                      dateController.text =
                          DateFormat.yMMMEd().format(DateTime.now());
                      if (pickedDate != null) {
                        setState(() {
                          dateController.text =
                              DateFormat.yMMMEd().format(pickedDate);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: Button(onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        tasksprovider.addTask(
                          titleController.text,
                          descriptionController.text,
                          startTimeController.text,
                          endTimeController.text,
                          dateController.text,
                        );
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ToDoListPage()));
                        NotificationsServices().createTaskNotification(
                            titleController.text,
                            AppLocalizations.of(context)!.finishYourTask);
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  const Button({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Palette.buttonGreen),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 13),
        child: Text(
          AppLocalizations.of(context)!.createTask,
          style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
