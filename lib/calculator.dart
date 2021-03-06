import 'package:flutter/material.dart';
import 'dart:math';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double weight = 75;
  double equipmentWeight = 10;
  double canopySize = 150;
  double wingLoad = 1.5;

  calculateWingLoad() {
    wingLoad = (weight + equipmentWeight) * 2.205 / canopySize;
  }

  calculateCanopySizeGivenWingLoad() {
    canopySize =
        min(max(((weight + equipmentWeight) * 2.205 / wingLoad), 50), 350);
  }

  getSkillLevel() {
    if (wingLoad < 1.05) return 'Beginner';
    if (wingLoad < 1.35) return 'Intermediate';
    if (wingLoad < 1.80) return 'Advanced';
    return 'Expert';
  }

  getMinimumAmountOfJumps() {
    switch (getSkillLevel()) {
      case 'Beginner':
        return '0-200';
      case 'Intermediate':
        return '200-600';
      case 'Advanced':
        return '600-1500';
      case 'Expert':
        return '1500+';
    }
  }

  getSkillColor() {
    switch (getSkillLevel()) {
      case 'Beginner':
        return Colors.green;
      case 'Intermediate':
        return Colors.blue;
      case 'Advanced':
        return Colors.orange;
      case 'Expert':
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('Your weight: ${weight.toStringAsFixed(0)} kg'),
              Slider(
                min: 40.0,
                max: 150.0,
                divisions: 150 - 40,
                value: weight,
                onChanged: (value) {
                  setState(() {
                    weight = value;
                    calculateWingLoad();
                  });
                },
              ),
              Text(
                  'Equipment weight: ${equipmentWeight.toStringAsFixed(0)} kg'),
              Slider(
                min: 5.0,
                max: 25.0,
                divisions: 25 - 5,
                value: equipmentWeight,
                onChanged: (value) {
                  setState(() {
                    equipmentWeight = value;
                    calculateWingLoad();
                  });
                },
              ),
              Text('Canopy size: ${canopySize.toStringAsFixed(0)} sq ft'),
              Slider(
                min: 50.0,
                max: 350.0,
                divisions: 350 - 50,
                value: canopySize,
                onChanged: (value) {
                  setState(() {
                    canopySize = value;
                    calculateWingLoad();
                  });
                },
              ),
              Text('Wing load: ${wingLoad.toStringAsFixed(2)}'),
              Slider(
                min: 0.0,
                max: 4.0,
                value: wingLoad,
                onChanged: (value) {
                  setState(() {
                    wingLoad = value;
                    calculateCanopySizeGivenWingLoad();
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: getSkillColor()),
                child: Text(getSkillLevel(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              Text('Recommended number of jumps: ${getMinimumAmountOfJumps()}'),
            ],
          ),
        ));
  }
}
