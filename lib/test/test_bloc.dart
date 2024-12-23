import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xhs/test/ticker.dart';

class TestBloc extends StatefulWidget {
  const TestBloc({super.key});

  @override
  State<TestBloc> createState() => _TestBlocState();
}

class _TestBlocState extends State<TestBloc> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => TimerBloc(ticker: const Ticker()), child: const TimerView());
  }
}

class TimerView extends StatelessWidget {
  const TimerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer"),
      ),
      body: Container(
        color: Colors.red,
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(20), child: Text("timer: $duration"),),
            BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
              return Row(
                children: [
                  ...switch (state) {
                    TimerInitial() => [
                        FloatingActionButton(
                          child: const Icon(Icons.play_arrow),
                          onPressed: () => context.read<TimerBloc>().add(TimerStarted(duration: state.duration)),
                        )
                      ],
                    TimerRunInProgress() => [
                        FloatingActionButton(
                          child: const Icon(Icons.pause),
                          onPressed: () {
                            // context.read<TimerBloc>().add(const TimerPaused());
                          },
                        ),
                        FloatingActionButton(
                          child: const Icon(Icons.replay),
                          onPressed: () {
                            // context.read<TimerBloc>().add(const TimerReset());
                          },
                        )
                      ],
                  }
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// Timer Event事件
sealed class TimerEvent {
  const TimerEvent();
}

final class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});

  final int duration;
}

class _TimerTicked extends TimerEvent {
  const _TimerTicked({required this.duration});

  final int duration;
}

/// Timer State
sealed class TimerState extends Equatable {
  const TimerState(this.duration);

  final int duration;

  @override
  List<Object> get props => [duration];
}

final class TimerInitial extends TimerState {
  const TimerInitial(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

final class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
  }

  final Ticker _ticker;
  static const int _duration = 60 * 60;

  StreamSubscription<int>? _tickerSubscription;

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick(ticks: event.duration).listen((duration) => add(_TimerTicked(duration: duration)));
  }
}
