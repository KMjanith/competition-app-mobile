import 'package:competition_app/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/cubit/db_cubit.dart';
import 'blocs/cubit/recentgradings_cubit.dart';
import 'firebase_options.dart';
import 'services/ViewStudent.dart';
import 'blocs/viewData/view_data_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Viewstudent(),
        ),
        BlocProvider(
          create: (context) => ViewDataBloc(Provider.of<Viewstudent>(context, listen: false)),
        ),
        BlocProvider(
          create: (_) => DbCubit(),
        ),
        BlocProvider(
          create: (_) => RecentgradingsCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
