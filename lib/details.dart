import 'package:flutter/material.dart';
import 'package:pokemon/pokemon.dart';
import 'package:pokemon/AppColors.dart';
class PokemanDetails extends StatelessWidget {
  final Pokemon pokemon;
  PokemanDetails({this.pokemon});
  @override
  Widget build(BuildContext context) {
    final Color backgroundColor=appColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: backgroundColor,
        title: Text(pokemon.name,
          style: TextStyle(
            fontSize: 30.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: bodyWidget(context),
    );
  }
  bodyWidget(BuildContext context) =>OrientationBuilder(
    builder: (context,orientation){
      return Stack(
        children: <Widget>[
          Positioned(
            height: orientation==Orientation.portrait?MediaQuery.of(context).size.height/1.5:MediaQuery.of(context).size.height*0.9,
            width: MediaQuery.of(context).size.width-20,
            left: 10.0,
            top: orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.2:MediaQuery.of(context).size.height*0.4,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
              ),
              child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20.0,),
                        Text('Height :${pokemon.height}',style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('Weight :${pokemon.weight}',style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Types',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: pokemon.type.map((t)=>
                              FilterChip(backgroundColor:Colors.amber,label: Text(t), onSelected: (b){})).toList(),
                        ),
                        Text('Weakness',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: pokemon.weaknesses.map((t)=>
                              FilterChip(backgroundColor:Colors.red,label: Text(t,style: TextStyle(color: Colors.white),), onSelected: (b){})).toList(),
                        ),
                        Text('NextEvolution',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(
                            child:pokemon.nextEvolution==null?Container(child: Text('Your Pokemon has fully evolved'),):
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: pokemon.nextEvolution.map((n)=>
                                  FilterChip(backgroundColor:Colors.green,label: Text(n.name,style: TextStyle(color: Colors.white),), onSelected: (b){})).toList(),
                            )
                        ),
                      ],
                    ),
            ),
          ),
           Align(
                alignment: Alignment.topCenter,
                child: Hero(tag: pokemon.img,
                  child: Container(
                    height: orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.3:MediaQuery.of(context).size.height*0.5,
                    width: orientation==Orientation.portrait?MediaQuery.of(context).size.width*0.55: MediaQuery.of(context).size.height*0.5 ,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit:BoxFit.cover,
                            image: NetworkImage(pokemon.img))
                    ),
                  ),
                ),
              ),
        ],
      );
    },
  );
}


