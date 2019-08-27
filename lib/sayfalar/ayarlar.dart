import 'package:flutter/material.dart';

class Ayarlar extends StatefulWidget {
  @override
  _AyarlarState createState() => _AyarlarState();
}
class _AyarlarState extends State<Ayarlar> {

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Tema Ayarları",style: TextStyle(fontSize: 20,),),
          ),
          Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
            Expanded(child: ListTile(leading: Icon(Icons.add_to_home_screen),title: Text("Dark Tema"))),
            Expanded(
                child: SwitchListTile(
                onChanged: (secilenDeger){
                  setState(() {     
                      
                  });
                },
                value: true,
              ),
            ),
          ],
          ),
          

        ],
      ),
    );
  }
}