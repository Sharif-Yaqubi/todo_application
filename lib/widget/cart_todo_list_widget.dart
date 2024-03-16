import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/provider/firebase_crud_provider.dart';

class CardToDoListWidget extends ConsumerWidget {
  final int getIndex;
  const CardToDoListWidget({
    super.key,
    required this.getIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchData);
    return todoData.when(
      data: (data) {
        final getCategory = data[getIndex].category;
        final colors = {
          'Learning': Colors.green,
          'Working': Colors.blue.shade700,
          'General': Colors.amber.shade700
        };
        return Slidable(
          key: ValueKey(getIndex),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(
              onDismissed: () =>
                  ref.read(provider).deleteTask(data[getIndex].docID),
            ),
            children: [
              SlidableAction(
                onPressed: (context) =>
                    ref.read(provider).deleteTask(data[getIndex].docID),
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.circular(12),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colors[getCategory],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            data[getIndex].titleText,
                            maxLines: 1,
                            style: TextStyle(
                              decoration: data[getIndex].isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          subtitle: Text(
                            data[getIndex].description,
                            maxLines: 1,
                            style: TextStyle(
                              decoration: data[getIndex].isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.blue.shade800,
                              shape: const CircleBorder(),
                              value: data[getIndex].isDone,
                              onChanged: (value) => ref
                                  .read(provider)
                                  .updateTask(data[getIndex].docID, value),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -12),
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey.shade200,
                              ),
                              Row(
                                children: [
                                  const Text('Today'),
                                  const Gap(12),
                                  Text(data[getIndex].timeTask)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text('The Error is $stackTrace'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
