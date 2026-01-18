import "package:flutter/material.dart";
import "ride_flow_controller.dart";

class RideFlowScope extends InheritedNotifier<RideFlowController> {
  const RideFlowScope({
    super.key,
    required RideFlowController controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static RideFlowController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<RideFlowScope>();
    if (scope == null || scope.notifier == null) {
      throw StateError("RideFlowScope not found");
    }
    return scope.notifier!;
  }
}
