import 'package:flutter/material.dart';
import 'package:smart_farm/features/to_do_list/models/task.model.dart';

class TaskBox extends StatelessWidget {
  final Task task;
  const TaskBox({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Text(task.title, style: const TextStyle(fontFamily: 'poppins', fontSize: 24, fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${task.startTime} to ${task.endTime}', style: const TextStyle(fontFamily: 'poppins', fontSize: 16, fontWeight: FontWeight.bold),),
                SizedBox(
                  width: 120,
                  height: 35,
                  child: IconButton(
                    onPressed: () {},
                    icon: Text(
                      task.state,
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(52, 206, 108, 1),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
  }
}