import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themechange/bloc/CounterCubit.dart';
import 'package:themechange/bloc/themeCubit.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (_) => ThemeCubit(),
      ),
      BlocProvider(
        create: (_) => CounterQubit(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: theme,
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
   final themeCubit = context.read<ThemeCubit>();
   final counterCubit = context.read<CounterQubit>();
    return MultiBlocListener(
      listeners: [
        BlocListener<CounterQubit, int>(
            listener: (context, state){
              if(state == 5 || state == 10){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The Counter is at ${State}")));
              }
            }
            ),
        BlocListener<ThemeCubit, ThemeData>(
            listener: (context, state){
              if(state == ThemeData.light()){
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                    SnackBar(
                        content: Text("The Theme changes to Light")));
              }
              else{
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                    SnackBar(
                        content: Text("The Theme changes to Dark")));
              }
            }
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              ElevatedButton(
                  onPressed: (){
                    themeCubit.toogleTheme();
                  },
                  child: Text('Change Theme')),
              const Text('You have pushed the button this many times:'),
              BlocBuilder<CounterQubit, int>(
                  builder: (context, count){
                    return Text(
                      '$count',
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  }
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: .center,
          children: [
            FloatingActionButton(
              onPressed: counterCubit.increment,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: counterCubit.decrement,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
