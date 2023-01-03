import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:theme_testing/models/darktheme_provider.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  void getCurrentTheme() async{
    themeChangeProvider.darkTheme = await themeChangeProvider.darkThemePreference.getTheme();
  }


  @override
  void initState() {
    super.initState();
    getCurrentTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_){
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Theme testing",
            theme: themeChangeProvider.darkTheme ?
            ThemeData.dark().copyWith(
              appBarTheme: AppBarTheme(
                color: Colors.purple,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple[200]),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            )
                :
            ThemeData.light().copyWith(
              appBarTheme: AppBarTheme(
                color: Colors.orange,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange[200]),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
            ),
            home:Scaffold(
              appBar: AppBar(
                title: Text("Theme Testing"),
                actions: [
                  IconButton(
                    onPressed: (){
                      setState(() {
                        themeChangeProvider.darkTheme = !themeChangeProvider.darkTheme;
                      });
                    },
                    icon: themeChangeProvider.darkTheme ?
                    Icon(Icons.dark_mode)
                        :
                    Icon(Icons.light_mode),
                  ),
                ],
              ),
              body: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                      "Hello"
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

