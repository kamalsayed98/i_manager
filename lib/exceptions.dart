/// This exception will be thrown when we don't find instance of IManager in the tree while it got summoned
class ManagerNotFoundException implements Exception {
  /// Instance name of the manager can be passed
  final String instanceName;

  const ManagerNotFoundException([this.instanceName]);

  @override
  String toString() {
    return 'An Instance of IManager'
        '${instanceName != null ? '($instanceName)' : ''}'
        ' was not found in widget tree!';
  }
}
