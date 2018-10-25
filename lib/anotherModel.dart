import 'package:flutter/material.dart';
import 'package:pokemon/pokemon.dart';
import 'package:pokemon/AppColors.dart';
class SecondPage extends StatefulWidget {
  final Pokemon pokemon;
  final Pokemon nextPokemon;
  SecondPage({this.pokemon,this.nextPokemon});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final Color backgroundColor = appColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: backgroundColor,
        title: Text(widget.pokemon.name,
          style: TextStyle(
              fontSize: 30.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: bodyWidget(widget.pokemon),
    );
  }
}


class bodyWidget extends StatelessWidget {
  Pokemon pokemon;

  bodyWidget(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context,orientation) {
          return Stack(
            children: <Widget>[
              Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Height :${pokemon.height}',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                    Text('Weight :${pokemon.weight}',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0)),
                    Text('Types', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: pokemon.type.map((t) =>
                          FilterChip(backgroundColor: Colors.amber,
                              label: Text(t,style: TextStyle(fontSize: 15.0,fontWeight:FontWeight.w600),),
                              onSelected: (b) {})).toList(),
                    ),
                    Text('Weakness',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: pokemon.weaknesses.map((t) =>
                          FilterChip(backgroundColor: Colors.red,
                              label: Text(
                                t, style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight:FontWeight.w600),),
                              onSelected: (b) {})).toList(),
                    ),
                    Text('NextEvolution',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(
                        child: pokemon.nextEvolution == null ? Container(
                          child: Text('Your Pokemon has fully evolved'),) :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: pokemon.nextEvolution.map((n) =>
                              FilterChip(backgroundColor: Colors.green,
                                  label: Text(
                                    n.name,
                                    style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight:FontWeight.w600),),
                                  onSelected: (b) {})).toList(),
                        )
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding:orientation==Orientation.portrait? const EdgeInsets.only(bottom: 200.0,right: 50.0):const EdgeInsets.only(bottom: 50.0,right: 10.0),
                  child: Hero(tag: pokemon.img,
                    child: Container(
                      height: orientation == Orientation.portrait ? MediaQuery
                          .of(context)
                          .size
                          .height * 0.5 : MediaQuery
                          .of(context)
                          .size
                          .height * 0.6,
                      width: orientation == Orientation.portrait ? MediaQuery
                          .of(context)
                          .size
                          .width * 0.55 : MediaQuery
                          .of(context)
                          .size
                          .width * 0.7,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: orientation==Orientation.portrait?BoxFit.contain:BoxFit.fill,
                              image: NetworkImage(pokemon.img))
                      ),
                    ),
                  ),
                ),
              ),

            ],
          );
        }
    );
  }
}
