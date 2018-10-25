import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokemon/pokemon.dart';
import 'package:pokemon/details.dart';
import 'package:pokemon/anotherModel.dart';
import 'package:pokemon/AppColors.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Pokemon'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
var url="https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Pokehub pokehub;
static Color currentColor;

  @override
    void initState() {
      super.initState();
      fetchData();
          }
           void fetchData() async {
            var res= await http.get(url);
           var decodedJson=jsonDecode(res.body);
           pokehub=Pokehub.fromJson(decodedJson);
           setState(() {});
           }
        @override
        Widget build(BuildContext context) {
            return new Scaffold(
            appBar: new AppBar(
              title: new Text(widget.title),
              backgroundColor: appColor,
            ),
            drawer: Drawer(
              elevation: 5.0,
              child: new DrawerBody(currentColor
              ),
            ),
            body:pokehub==null?Center(child: CircularProgressIndicator(),):
            OrientationBuilder(
              builder: (context,orientation){
                return GridView.count(
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                  children: pokehub.pokemon.map((poke)=>Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>
                                SecondPage(
                                  pokemon: poke,

                                ))
                        );
                      },
                      child: Hero(
                        tag: poke.img,
                        child: Card(
                          elevation: 3.0,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image:NetworkImage(poke.img))
                                    )
                                ),
                                Text(poke.name,
                                  softWrap: true,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),)
                              ]
                          ),
                        ),
                      ),
                    ),
                  )).toList(),
                );
              },
            ),
          );
        }
}
class DrawerBody extends StatefulWidget {
  Color currentColor;

  DrawerBody(this.currentColor);

  @override
  DrawerBodyState createState() {
    return new DrawerBodyState();
  }
}

class DrawerBodyState extends State<DrawerBody> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  ValueChanged<Color> onColorChanged;
  changeMaterialColor(Color color) => setState(() {
    widget.currentColor = color;
    appColor=color;
    Navigator.of(context).pop();
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Align(
            alignment: Alignment.bottomLeft,
            child: Text('Pokemon',
              style:TextStyle(
                color: appColor,
                fontSize: 40.0,
                textBaseline: TextBaseline.ideographic,
                fontWeight: FontWeight.w500,
              ) ,
            ),
          ),
            decoration: BoxDecoration(
              image:DecorationImage(
                  fit:BoxFit.cover,
                  image:  AssetImage('assets/Pokeball.png')),
            ),
          ),
          ListTile(
            title: Text('Change your app theme',
              style: TextStyle(
                  color: appColor,
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic
              ),
            ),
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: EdgeInsets.all(0.0),
                    contentPadding: EdgeInsets.all(0.0),
                    content: SingleChildScrollView(
                      child: MaterialPicker(
                        pickerColor: widget.currentColor,
                        onColorChanged: changeMaterialColor,
                        enableLabel: true,
                      ),
                    ),
                  );
                },
              );
            },

          ),
          Divider(color: appColor,
            height: 4.0,)
        ],
      ),
    );
  }


}
