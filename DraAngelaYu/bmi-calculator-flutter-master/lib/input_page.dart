import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'icon_content.dart';
import 'reusable_card.dart';

const bottonConteinerHeight = 80.0;
const activeCardColour = Color(0xFF1D1E33);
const inactiveCardColour = Color(0xFF111328);
const bottonConteinerColour = Color(0xFFEB1555);
enum Gender {MALE,FEMALE}


class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  Gender genderSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI CALCULATOR'),
        ),
        body: Column(
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
                          ? activeCardColour
                          :inactiveCardColour,
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
                      ? activeCardColour
                      :inactiveCardColour,
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
                colour: inactiveCardColour,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCard(
                      colour: inactiveCardColour,
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: inactiveCardColour,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: bottonConteinerColour,
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: bottonConteinerHeight,
            )
          ],
        ));
  }
}

