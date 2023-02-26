import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/pallet/pallet.dart';

enum Unit { celsius, fahrenheit }

final currentUnitProvider = StateProvider<Unit>((ref) {
  return Unit.celsius;
});

class UnitSwitch extends ConsumerWidget {
  const UnitSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = ref.watch(currentUnitProvider);
    return Row(
      children: [
        TextButton(
          onPressed: () {
            ref
                .read(currentUnitProvider.notifier)
                .update((state) => Unit.celsius);
          },
          style: TextButton.styleFrom(
            minimumSize: const Size(20, 20),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            "°C",
            style: TextStyle(
              color: unit == Unit.celsius ? Pallet.black : Pallet.darkGrey,
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            ref
                .read(currentUnitProvider.notifier)
                .update((state) => Unit.fahrenheit);
          },
          style: TextButton.styleFrom(
            minimumSize: const Size(20, 20),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            "°F",
            style: TextStyle(
              color: unit == Unit.fahrenheit ? Pallet.black : Pallet.darkGrey,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
