import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import '../providers/add_to_do_provider.dart';
import 'screens/add_to_do.dart';
import 'screens/home_screen.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>AddToDoProvider(localStorage))
      ],
          child: ToDo(),
  ));
}

class ToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

      MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false);
  }
}
