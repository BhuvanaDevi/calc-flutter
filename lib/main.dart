import 'package:flutter/material.dart';
import 'package:flutter_app/bmi.dart';
import 'package:flutter_app/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  var userQuestion='';
  var userAnswer='';
final myTextStyle=TextStyle(fontSize: 30,color: Colors.deepPurple[900]);

  final List<String> buttons = [
    'AC',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'X',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 50,),
                  Container(
                    padding: EdgeInsets.all(20),
                      alignment:Alignment.centerLeft,
                      child: Text(userQuestion,style: TextStyle(fontSize: 20),)),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment:Alignment.centerRight,
                      child: Text(userAnswer,style: TextStyle(fontSize: 20),)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
    if(index==0)
    {
    return MyButton(
    buttonTapped: (){
    setState(() {
    userQuestion="";
    userAnswer="0";
    });
    },
    buttonText: buttons[index],
    color: Colors.green,
    textColor: Colors.white,
    );
    }

   /* else if(index==18)
    {
    return MyButton(
    buttonTapped: (){
    setState(() {
    String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
    }
    userAnswer=format(double.parse(userAnswer));
    });

    },
    buttonText: buttons[index],
    color: Colors.blue,
    textColor: Colors.white,
    );
    }
  */  else if (index==16){
    return MyButton(
    buttonTapped:()
    {
    setState(() {
    if (userQuestion.startsWith('0')) {
    userQuestion='';
    userAnswer = '';
    return;
    }
    userQuestion+=buttons[index];
    });

    },
    buttonText: buttons[index],
    color: Colors.white,
    textColor: Colors.deepPurple,
    );
    }
    else if (index==17){
    return MyButton(
    buttonTapped:()
    {
    setState(() {
    if (userQuestion.endsWith('.')) {
    return;
    }
    userQuestion+=buttons[index];
    });

    },
    buttonText: buttons[index],
    color: Colors.white,
    textColor: Colors.deepPurple,
    );
    }

    else if (index==1){
    return MyButton(
    buttonTapped:()
    {
    setState(() {
    userQuestion=userQuestion.substring(0,userQuestion.length-1);
    });

    },
    buttonText: buttons[index],
    color: Colors.red,
    textColor: Colors.white,
    );
    }

    else if (index==buttons.length-1){
    return MyButton(
    buttonTapped:()
    {
    setState(() {
    equalPressed ();

    });
    },
    buttonText: buttons[index],
    color: Colors.blue,
    textColor: Colors.white,
    );
    }
                               else {
                      return MyButton(
                        buttonTapped:()
                        {
                          setState(() {
                            userQuestion+=buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple[50],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepPurple,
                      );
                    }
                  }),
            ),
          ),
        ],
              ), floatingActionButton: new FloatingActionButton(
mini: false,
        elevation: 0.0,
        child: new Text('BMI',style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.pink[200],
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Bmi()),
          );
        }
    )
    );

  }
  bool isOperator(String x)
  {
       if(x=='%' || x=='/'||x=='X'||x=='-'||x=='+')
      {
        return true;
      }
        return false;
   }
  void equalPressed() {
    String finalquestinon = userQuestion;

    finalquestinon = finalquestinon.replaceAll('X', '*');
    try {
      Parser p = Parser();
      Expression exp = p.parse(finalquestinon);
      ContextModel cm = ContextModel();
        var eval = '${exp.evaluate(EvaluationType.REAL, cm)}';
  userAnswer = eval.toString();
   //userQuestion = finalquestinon + "=" + eval.toString() + "\n";
      String format(double n) {
        return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
      }
      userAnswer=format(double.parse(userAnswer));
      userQuestion="";
      }
    catch (e) {
     userAnswer = "Error";
    }
  }
}
