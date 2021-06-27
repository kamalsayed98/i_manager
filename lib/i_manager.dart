library i_manager;

import 'package:flutter/material.dart';
import 'package:i_manager/exceptions.dart';
import 'package:rxdart/rxdart.dart';

import 'extensions.dart';

/// SingleIMangerBuilder is a typedef that will take widget and return instance of IManager
typedef SingleIMangerBuilder = IManager Function(Widget);

/// MultiIManagerProvider is used to changes the appearance of the code when injecting nested IManagers.
class MultiIManagerProvider extends StatelessWidget {
  MultiIManagerProvider({
    Key key,
    @required this.iManagersBuilder,
    this.child,
  })  : assert(iManagersBuilder != null),
        super(key: key);

  /// child is the widget that will be wraped with the List of IManagers
  final Widget child;

  /// iManagersBuilder is a List of functions that will take child
  /// and return IManager from each item
  final List<SingleIMangerBuilder> iManagersBuilder;

  @override
  Widget build(BuildContext context) {
    /// Initialize widget to the child that is passed by develper
    Widget widget = child;

    /// simply we will loop throw the builders
    /// and we will inject widget to get widget wraped with IManager at each step
    for (final m in iManagersBuilder) widget = m(widget);

    /// return the child passed by user wrapped by all the IManagers provided in iManagersBuilder List.
    return widget;
  }
}

/// IManager is an abstract class that should be extended so the new class can by placed in the widget tree
/// and its intance will be shared between widgets in its widget subtree
///
/// NOTE: if you wrapped a widget(below [MaterialApp]) with IManager instance
/// you can't access the same instance from another route
abstract class IManager extends _IManager {
  IManager(
    final WidgetBuilder builder, {
    Key key,
  }) : super(
          key: key,
          builder: builder,
          dispose$: false.rx,
        );

  /// static method to get IManager instanManagerNotFoundExceptionce from widget tree
  /// this method will throw [ManagerNotFoundException] if widget counldn't be found in the tree
  static T getManager<T extends IManager>(BuildContext context) {
    final manager = (context.dependOnInheritedWidgetOfExactType<T>());
    if (manager == null) throw ManagerNotFoundException(T.toString());
    return manager;
  }
}

/// _IManager will take bool BehaviorSubject and subscribe to it
/// when true event being sinked this widget will fire dispose method
/// (when true event sinked this means the widget is being removed from widget tree)
abstract class _IManager extends InheritedWidget {
  final BehaviorSubject<bool> dispose$;
  _IManager({
    Key key,
    @required final WidgetBuilder builder,
    @required this.dispose$,
  })  : assert(builder != null),
        super(
          key: key,
          child: _IWidgetBuilder(
            dispose$: dispose$,
            builder: builder,
          ),
        ) {
    /// listen to dispose BehaviorSubject
    dispose$.listen(
      (value) {
        /// run dispose method once true event being added to the sink
        if (value == true) dispose();
      },
    );
  }

  /// dispose can be overrided but it should call super.dispose() so dispose$ stream got closed
  @mustCallSuper
  void dispose() {
    dispose$.close();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

/// _IWidgetBuilder is the widget that will notify _IManager when it got removed from widget tree
/// so it run dispose() method
class _IWidgetBuilder extends StatefulWidget {
  final BehaviorSubject<bool> dispose$;

  final WidgetBuilder builder;
  const _IWidgetBuilder({
    Key key,
    @required this.builder,
    @required this.dispose$,
  }) : super(key: key);
  @override
  __IWidgetBuilderState createState() => __IWidgetBuilderState();
}

class __IWidgetBuilderState extends State<_IWidgetBuilder> {
  @override
  void dispose() {
    /// sinking true value to run dipose in _IManager
    widget.dispose$.sink.add(true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
