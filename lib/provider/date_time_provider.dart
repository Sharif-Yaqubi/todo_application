import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateProvider = StateProvider<String>((ref) => 'dd/mm/yy');
final timeProvider = StateProvider<String>((ref) => 'hh : mm');
