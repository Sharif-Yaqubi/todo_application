import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  final String titleRadio;
  final Color categoryColor;
  final int value;
  final VoidCallback onChangedValue;
  const RadioWidget({
    super.key,
    required this.titleRadio,
    required this.categoryColor,
    required this.value,
    required this.onChangedValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioController = ref.watch(radioProvider);
    return Material(
      child: Theme(
        data: ThemeData(unselectedWidgetColor: categoryColor),
        child: RadioListTile(
          activeColor: categoryColor,
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(
            offset: const Offset(-22, 0),
            child: Text(
              titleRadio,
              style: TextStyle(
                color: categoryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          value: value,
          groupValue: radioController,
          onChanged: (value) => onChangedValue(),
        ),
      ),
    );
  }
}
