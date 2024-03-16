import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/constants/app_style.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/provider/radio_provider.dart';

import '../provider/date_time_provider.dart';
import '../provider/firebase_crud_provider.dart';
import 'date_time_widget.dart';
import 'radio_widget.dart';
import 'text_form_widget.dart';

class NewTaskWidget extends ConsumerStatefulWidget {
  const NewTaskWidget({super.key});

  @override
  ConsumerState<NewTaskWidget> createState() => _NewTaskWidgetState();
}

class _NewTaskWidgetState extends ConsumerState<NewTaskWidget> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              'New Task Todo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey.shade200,
          ),
          const Gap(12),
          const Text('Title Task', style: AppStyle.heading1),
          const Gap(6),
          TextFormWidget(
            hintText: 'Add Task Name',
            maxLine: 1,
            controller: titleController,
          ),
          const Gap(12),
          const Text('Description', style: AppStyle.heading1),
          const Gap(6),
          TextFormWidget(
            hintText: 'Add Description',
            maxLine: 5,
            controller: descriptionController,
          ),
          const Gap(12),
          const Text('Category', style: AppStyle.heading1),
          Row(
            children: [
              Expanded(
                child: RadioWidget(
                  categoryColor: Colors.green,
                  titleRadio: 'LAN',
                  value: 1,
                  onChangedValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 1),
                ),
              ),
              Expanded(
                child: RadioWidget(
                    categoryColor: Colors.blue.shade700,
                    titleRadio: 'WRK',
                    value: 2,
                    onChangedValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 2)),
              ),
              Expanded(
                child: RadioWidget(
                    categoryColor: Colors.amberAccent.shade700,
                    titleRadio: 'GEN',
                    value: 3,
                    onChangedValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 3)),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(
                titleText: 'Date',
                valueText: date,
                iconSection: CupertinoIcons.calendar,
                onTap: () async {
                  final getValue = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2025));
                  if (getValue != null) {
                    final format = DateFormat.yMd();
                    ref
                        .read(dateProvider.notifier)
                        .update((state) => format.format(getValue));
                  }
                },
              ),
              const Gap(22),
              DateTimeWidget(
                titleText: 'Time',
                valueText: time,
                iconSection: CupertinoIcons.clock,
                onTap: () async {
                  final getTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (getTime != null) {
                    ref
                        .read(timeProvider.notifier)
                        .update((state) => getTime.format(context));
                  }
                },
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: Colors.blue.shade800),
                      padding: const EdgeInsets.symmetric(vertical: 14)),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const Gap(20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14)),
                  onPressed: () {
                    final getRadioValue = ref.read(radioProvider);
                    final categoryMap = {
                      1: 'Learning',
                      2: 'Working',
                      3: 'General',
                    };
                    String category = categoryMap[getRadioValue]!;
                    debugPrint('Sharif$category');
                    ref.read(provider).addNewTask(
                          TodoModel(
                            titleText: titleController.text,
                            description: descriptionController.text,
                            category: category,
                            dateTask: ref.read(dateProvider),
                            timeTask: ref.read(timeProvider),
                            isDone: false,
                          ),
                        );
                    titleController.clear();
                    descriptionController.clear();
                    ref.read(radioProvider.notifier).update((state) => 0);
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
