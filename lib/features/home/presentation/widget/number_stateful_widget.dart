import 'package:flutter/material.dart';
import 'package:flutter_state_management/core/injection.dart';
import 'package:flutter_state_management/features/home/domain/domain.dart';
import 'package:flutter_state_management/features/home/presentation/widget/number_widget.dart';

class NumberStatefulWidget extends StatefulWidget {
  const NumberStatefulWidget({super.key});

  @override
  State<NumberStatefulWidget> createState() => _NumberStatefulWidgetState();
}

class _NumberStatefulWidgetState extends State<NumberStatefulWidget> {
  late final IFetchRandomNumberUsecase _fetchRandomNumberUsecase;

  int number = 0;

  @override
  void initState() {
    super.initState();
    _fetchRandomNumberUsecase = getIt<IFetchRandomNumberUsecase>();
  }

  Future<void> random() async {
    final result = await _fetchRandomNumberUsecase.call();
    final value = result.maybeValue;

    if (value != null) {
      setState(() {
        number = value;
      });
    }
  }

  void add() {
    setState(() {
      number++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Stateful');
    print('value: $number');

    return NumberWidget(
      onRandom: random,
      onAdd: add,
      number: NumberText(number: number),
    );
  }
}
