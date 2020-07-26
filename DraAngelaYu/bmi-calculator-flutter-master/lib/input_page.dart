import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'icon_content.dart';
import 'reusable_card.dart';

enum Gender {MALE,FEMALE}


class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  Gender genderSelected;
  int height = 180;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI CALCULATOR'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCard(
                      onTap: (){
                        setState(() {
                          genderSelected = Gender.MALE;
                        });
                      },
                      colour: genderSelected == Gender.MALE
                          ? kActiveCardColour
                          :kInactiveCardColour,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.mars,
                        text: 'MALE',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onTap: (){
                        setState(() {
                          genderSelected = Gender.FEMALE;
                        });
                      },
                      colour: genderSelected == Gender.FEMALE
                      ? kActiveCardColour
                      :kInactiveCardColour,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.venus,
                        text: 'FEMALE',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCard(
                colour: kInactiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HIGHT',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: kNumberTextStyle
                        ),
                        Text(
                          'cm',
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Color(0xFF8D8E98),
                        activeTrackColor: Colors.white,
                        thumbColor: Color(0xFFEB1555),
                        overlayColor: Color(0x29EB1555),
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0)
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220,
                        onChanged: (double passedHeight){
                          setState(() {
                            height = passedHeight.toInt();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCard(
                      colour: kInactiveCardColour,
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: kInactiveCardColour,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: kBottonConteinerColour,
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: kBottonConteinerHeight,
            )
          ],
        ));
  }
}

