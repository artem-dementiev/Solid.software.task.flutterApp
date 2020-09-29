import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:solid_software_app/StepValidator.dart';

/// Application launch
void main() {
  runApp(new App());
}
/// Main Window
/// @author Artem Dementiev
class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new MyHomePage(title: "Test App")
    );
  }
}
/// Main Widget
/// @param title Application menu bar value
/// @author Artem Dementiev
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
/// Main Class which display logic of changing step and index parameters
///  @param _indexOfColor index of color
///  @param _step color index change step
///  @author Artem Dementiev
class _MyHomePageState extends State<MyHomePage> {
  int _indexOfColor = 0x00FFFFFF;
  int _step =1000;

  @override
  Widget build(BuildContext context) {
    return Material(
      //wrap our Scaffold in an InkWell to get a onTap method for container
      child: InkWell(
        onTap: () {
          //update the state of the class "_MyHomePageState"
          setState(() {
            //set a random color
            _indexOfColor=(Random().nextDouble() * 0xFFFFFF).toInt() << 0;
          });
          print("Container was tapped");
        },
        child:Scaffold(
          backgroundColor: Color(_indexOfColor).withOpacity(1.0),
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Hey there!"),
                Text(
                  'You pushed and got index color:',
                ),
                Text('$_indexOfColor'),
                //initialize class "Index"
                Index(
                  index: _indexOfColor,
                  step: _step,
                  onIndexChange: (int value)=>{
                    //update the state of the class "_MyHomePageState"
                    setState(() {
                      _indexOfColor+= value;
                    }),
                  },
                  onStepChange: (int value)=>{
                    //update the state of the class "_MyHomePageState"
                    setState(() {
                      _step= value;
                    }),
                  },
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
/// Helper Class which display logic of changing step and index parameters
///  @param index index of color
///  @param step color index change step
///  @onIndexChange Calling a function that will set a new state in the "_MyHomePageState" class for the "index" parameter
///  @onStepChange Calling a function that will set a new state in the "_MyHomePageState" class for the "step" parameter
///  @_formKey allows you to access form functionality from child elements for data validation
///  @stepController variable to store the value of the input field
///  @author Artem Dementiev
class Index extends StatelessWidget{
  final int index;
  final Function onIndexChange;
  final Function onStepChange;
  final _formKey = GlobalKey<FormState>();
  final int step;
  final stepController = TextEditingController();
  Index({this.index, this.onIndexChange,this.step, this.onStepChange});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: ()=> {
              print("IconAdd was tapped"),
              onIndexChange(step),
            }
        ),
        Expanded(
          child:Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text("Index change step: $step"),
                TextFormField(
                  controller: stepController,
                  // ignore: missing_return
                  validator: (val)=>StepValidator.validate(val),
                  //get only integer values
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
                RaisedButton(
                  child: Text("Set step"),
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      onStepChange(int.parse(stepController.text));
                    }
                  },)
              ],
            ),
          ),
        ),
        IconButton(
            icon: Icon(Icons.remove),
            onPressed: ()=> {
              print("IconRemove was tapped"),
              onIndexChange(-step),
            }
        ),
      ],
    );
  }

}
