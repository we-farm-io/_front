import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/to_do_list/providers/tasks.provider.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({super.key});

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(builder: (context, tasksprovider, child) {
      return EasyDateTimeLine(
        initialDate: DateTime.now(),
        onDateChange: (selectedDate) {
          tasksprovider.setDate(DateFormat.yMMMEd().format(selectedDate));
          tasksprovider.fetchTasks(
              tasksprovider.selectedDate, tasksprovider.selectedFilter);
        },
        itemBuilder:
            (context, dayNumber, dayName, monthName, fullDate, isSelected) =>
                Container(
          margin: const EdgeInsets.symmetric(horizontal: 7),
          height: 100,
          width: 75,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                offset: Offset(1, 1),
                color: Color.fromRGBO(217, 217, 217, 1),
                blurRadius: 2,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: isSelected
                ? const Color.fromRGBO(52, 206, 108, 1)
                : const Color.fromRGBO(220, 232, 214, 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                monthName,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontFamily: 'poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                dayNumber,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontFamily: 'poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                dayName,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontFamily: 'poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    });
  }
}
