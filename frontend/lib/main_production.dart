import 'package:event_planr_app/app/app.dart';
import 'package:event_planr_app/bootstrap.dart';

import 'package:event_planr_app/env/env.dart';

void main() {
  Env.environment = 'prod';
  bootstrap(() => const App());
}
