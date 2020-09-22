import 'dart:ffi';

import 'package:flutter_app/bmimodel.dart';
import 'package:flutter_app/resultscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class Bmi extends StatefulWidget {
  @override
  _BmiState createState() => _BmiState();
}

class _BmiState extends State<Bmi> {
  double _heightOfUser = 100.0;
  double _weightOfUser = 40.0;

  double _bmi = 0;
  BmiModel _bmiModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("BMI",textAlign: TextAlign.center,),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
               /*   Container(
                    width: 200,
                    height: 200,
                    child: SvgPicture.asset("assets/images/bmi.svg", fit: BoxFit.contain,),
                  ),
                 */ SizedBox(height: 16,),

                  CircleAvatar(
                   radius: 75,
                    //backgroundColor: Color(0xffFDCF09),
                    child: CircleAvatar(
                      radius: 50,
                      child: SvgPicture.asset("assets/images/bmi.svg", fit: BoxFit.contain,),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("BMI Calculator", style: TextStyle(color: Colors.blue, fontSize: 34, fontWeight: FontWeight.w700),),
                  Text("We care about your health", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400),),
                  SizedBox(
                    height: 32,
                  ),
                  Text("Height (cm)", style: TextStyle(color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w400),),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Slider(
                      min: 80.0,
                      max: 250.0,
                      onChanged: (height){
                        setState(() {
                          _heightOfUser = height;
                        });
                      },
                      value: _heightOfUser,
                      divisions: 20,
                      activeColor: Colors.pink,
                      label: "$_heightOfUser",
                    ),
                  ),
                  Text("$_heightOfUser cm", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.w900),),

                  SizedBox(height: 24,),

                  Text("Weight (kg)", style: TextStyle(color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w400),),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Slider(
                      min: 30.0,
                      max: 120.0,
                      onChanged: (height){
                        setState(() {
                          _weightOfUser = height;
                        });
                      },
                      value: _weightOfUser,
                      divisions: 20,
                      activeColor: Colors.pink,
                      label: "$_weightOfUser",
                    ),
                  ),

                  Text("$_weightOfUser kg", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.w900),),
                  Container(
                    child: FlatButton.icon(
                      onPressed: (){
                        setState(() {
                          _bmi = _weightOfUser/((_heightOfUser/100)*(_heightOfUser/100));

                          if(_bmi >= 18.5 && _bmi <= 25){
                            _bmiModel = BmiModel(bmi: _bmi, isNormal: true, comments: "You are Totaly Fit");
                          }else if(_bmi < 18.5){
                            _bmiModel = BmiModel(bmi: _bmi, isNormal: false, comments: "You are Underweighted");
                          }else if(_bmi > 25 && _bmi <= 30){
                            _bmiModel = BmiModel(bmi: _bmi, isNormal: false, comments: "You are Overweighted");
                          }else{
                            _bmiModel = BmiModel(bmi: _bmi, isNormal: false, comments: "You are Obesed");
                          }
                        });

                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ResultScreen(BmiModel: _bmiModel,)
                        ));
                      },
                      icon: Icon(Icons.favorite, color: Colors.white,),
                      label: Text("CALCULATE"),
                      textColor: Colors.white,
                      color: Colors.pink,

                    ),
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 16, right: 16),
                  ),
                ],
              )
          )
         )
    );
  }
}
