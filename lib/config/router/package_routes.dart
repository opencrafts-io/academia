import 'package:billing/billing.dart' as billing;
import 'package:courses/courses.dart' as courses;
import 'package:go_router/go_router.dart';
import 'package:in_app_update/in_app_update.dart' as in_app_update;
import 'package:permissions/permissions.dart' as permissions;
import 'package:pomodoro/pomodoro.dart' as pomodoro;
import 'package:rewards/rewards.dart' as rewards;
import 'package:settings/settings.dart' as settings;
import 'package:study_tools/study_tools.dart' as study_tools;
import 'package:todos/todos.dart' as todos;

List<RouteBase> get packageRoutes => [
  ...billing.routes,
  ...in_app_update.routes,
  ...settings.routes,
  ...permissions.routes,
  ...courses.routes,
  ...todos.routes,
  ...pomodoro.routes,
  ...study_tools.routes,
  ...rewards.routes,
];
