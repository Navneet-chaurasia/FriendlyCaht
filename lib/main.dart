import 'package:flutter/material.dart';

void main() {
  runApp(FriendlychatApp());
}

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Friendlychat",
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  //modified
  @override //new
  State createState() => new ChatScreenState(); //new
}

// Add the ChatScreenState class definition in main.dart.

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController =
      new TextEditingController(); //new
  final List<ChatMessage> _messages = <ChatMessage>[]; //new
  bool _isComposing = true;

  @override //new

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Friendlychat")),
      body: new Column(
        //modified
        children: <Widget>[
          //new
          new Flexible(
            //new
            child: new ListView.builder(
              //new
              padding: new EdgeInsets.all(8.0), //new
              reverse: true, //new
              itemBuilder: (_, int index) => _messages[index], //new
              itemCount: _messages.length, //new
            ), //new
          ), //new
          new Divider(height: 1.0), //new
          new Container(
            //new
            decoration:
                new BoxDecoration(color: Theme.of(context).cardColor), //new
            child: _buildTextComposer(), //modified
          ), //new
        ], //new
      ), //new
    );
  }

  // Add the following code in the ChatScreenState class definition.

  Widget _buildTextComposer() {
    return new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          Flexible(
            child: new TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              onChanged: (String text) {
                //new
                setState(() {
                  //new
                  _isComposing = text.length > 0; //new
                }); //new
              },
              decoration:
                  new InputDecoration.collapsed(hintText: "Send a message"),
            ),
          ),
          new Container(
              //new
              margin: new EdgeInsets.symmetric(horizontal: 4.0), //new
              child: new IconButton(
                //new
                icon: new Icon(Icons.send),
                color: Colors.lightBlueAccent, //new
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text) //modified
                    : null,
              )),
        ]));
  }

  void _handleSubmitted(String value) {
    _textController.clear();
    _isComposing = false;
    ChatMessage message = new ChatMessage(
      text: value,
      animationController: new AnimationController(
        //new
        duration: new Duration(milliseconds: 700), //new
        vsync: this, //new
      ), //new
    ); //new
    setState(() {
      //new
      _messages.insert(0, message); //new
    });

    message.animationController.forward();
  }
}

const String _name = "Navneet Chaurasia";

// Add the following class definition to main.dart.

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        //new
        sizeFactor: new CurvedAnimation(
            //new
            parent: animationController,
            curve: Curves.easeOut), //new
        axisAlignment: 0.0, //new
        child: new Container(
          //modified
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(child: new Text(_name[0])),
              ),
              Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(_name, style: Theme.of(context).textTheme.subhead),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(text),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ) //new
        );
  }
}
