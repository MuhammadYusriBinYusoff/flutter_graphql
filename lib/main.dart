import 'package:flutter/material.dart';
import 'package:flutter_graphql/providers/fetch_characters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget{
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Characters"),
      ),
      body: ref.watch(fetchCharactersProvider).maybeWhen(
        fetching: (){
          Center(child: CircularProgressIndicator(),);
        },
        fetched: (characters){
          return ListView(
            children: characters.map((e) => ListTile(
              title: Text(e.name!),
              leading: Image.network(e.image!,height: 100, fit: BoxFit.cover,),
              subtitle: Text(e.status!),
            )).toList(),
          );
        },
        orElse: (){
        return Container();
      }),
    );
  }
  
}
