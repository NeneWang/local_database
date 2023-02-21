import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class TagsInput extends StatefulWidget{
  TagsInput();
  @override
  TagsInputState createState() => new TagsInputState();
}

class TagsInputState extends State<TagsInput> {

  TextEditingController inputController = new TextEditingController();
  List <Widget> items = [];

  @override
  void initState(){
    items.add(Chip(label: Text('Test'),));
    items.add(Chip(label: Text('Test'),));
    items.add(buildInput());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Wrap(
              spacing: 10,
              children: items,
            ),
          ),
        ],
      ),
    ); // <-- Add a closing parenthesis here
  }


  Widget buildInput(){
    return Container(width: 80,
        child: TextField(
          controller: inputController,
          maxLines: 1, minLines: 1,
          keyboardType: TextInputType.text,
          decoration: new InputDecoration.collapsed(
              hintText: '...'
          ),
          onSubmitted: (String val) {
            inputController.clear();
            setState(() {
              items.insert(items.length-1, Chip(label: Text(val)));
            });
          },
        )
    );
  }
}

