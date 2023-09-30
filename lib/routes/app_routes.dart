import 'package:flutter/widgets.dart';

import '../modules/modules.dart';
import 'routes_name.dart';

/// Class that contains the routes of the app
/// This class is used to navigate between pages
/// and to get the name of the routes
class AppRoutes {
  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      RoutesNames.signIn: (_) => const SignInScreen(),
      RoutesNames.home: (_) => const HomeScreen(),
      RoutesNames.newPerson: (_) => const NewPersonScreen(),
    };
  }
}
