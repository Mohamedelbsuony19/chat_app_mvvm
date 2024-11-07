  import 'package:provider/provider.dart';

import 'presentation/provider/theme_provider.dart';
import 'presentation/provider/user_provider.dart';

var providers = [
    ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ];