import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'i_manager.dart';

/// This variable declared just to make it easear for the users to import this class
const importIManagerExtensions = 0;

/// In order to be able to write context.getManager<>()
/// this extension should be imported
extension EIManager<T> on BuildContext {
  T getManager<T extends IManager>() => IManager.getManager<T>(this);
}

/// to make the code more readable we can call setValue instead of sink.add
extension EBehaviorSubject<T> on BehaviorSubject<T> {
  void setValue(T e) => this.sink.add(e);
}

/// extensions on each type so we can get BehaviorSubject by typing .rx after any variable

extension EInt on int {
  BehaviorSubject<int> get rx => BehaviorSubject<int>.seeded(this);
}

extension EString on String {
  BehaviorSubject<String> get rx => BehaviorSubject<String>.seeded(this);
}

extension EDouble on double {
  BehaviorSubject<double> get rx => BehaviorSubject<double>.seeded(this);
}

extension EBool on bool {
  BehaviorSubject<bool> get rx => BehaviorSubject<bool>.seeded(this);
}

extension EList<T> on List<T> {
  BehaviorSubject<List<T>> get rx => BehaviorSubject<List<T>>.seeded(this);
}

extension EObject<T> on T {
  BehaviorSubject<T> get rx => BehaviorSubject<T>.seeded(this);
}
