import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

/// IManagerBuilder is same as [StreamBuilder] but instead of getting null as data
/// and waiting as connectionState when we first try to render the widget
/// we will set data to the value in the BehaviorSubject
class IManagerBuilder<T> extends StatelessWidget {
  IManagerBuilder({
    Key key,
    @required this.subject,
    @required this.builder,
  }) : super(key: key);

  final BehaviorSubject<T> subject;
  final AsyncWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: subject.stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return this.builder(
            context,
            AsyncSnapshot<T>.withData(
              ConnectionState.waiting,
              subject.value,
            ),
          );
        }
        if (snapshot.hasError) {
          return this.builder(
            context,
            AsyncSnapshot<T>.withError(
              ConnectionState.active,
              snapshot.error,
            ),
          );
        }
        return this.builder(
          context,
          AsyncSnapshot<T>.withData(
            ConnectionState.active,
            snapshot.data,
          ),
        );
      },
    );
  }
}
