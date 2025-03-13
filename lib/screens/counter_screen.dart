import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../controllers/counter_controller.dart';
import '../cubits/counter_cubit/counter__cubit.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TEST'),
      ),
      body: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state is CounterError) {
            showAboutDialog(context: context);
          }
        },
        builder: (context, state) {
          if (state is CounterChanged) {
            if (state.counter == 5) {
              return Center(child: Text("Counter is 5"));
            }
            return Center(child: Text(state.counter.toString()));
          }

          if (state is CounterError) {
            return Center(child: Text(state.message));
          }
          if (state is CounterLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(child: Text(state.toString()));
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // BlocProvider.of<CounterCubit>(context).increment();
              context.read<CounterCubit>().increment();
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterController>().decrement();
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
