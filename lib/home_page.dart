import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _bmiCategory = '';
  Color _bmiColor = Colors.black;

  void _calculateBMI() {
    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);

    if (weight != null && height != null && height > 0) {
      double heightInMeters;
      if (height >= 3) {
        // Assume height is in cm if it is 3 or greater (e.g., 175 cm)
        heightInMeters = height / 100;
      } else {
        // Assume height is in meters if it is less than 3 (e.g., 1.75 m)
        heightInMeters = height;
      }

      final heightInMetersSquared = heightInMeters * heightInMeters;
      final bmi = weight / heightInMetersSquared;

      String category;
      Color color;

      if (bmi < 18.5) {
        category = 'Underweight';
        color = Colors.yellow;
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        category = 'Normal';
        color = Colors.green;
      } else {
        category = 'Overweight';
        color = Colors.red;
      }

      setState(() {
        _bmiCategory = category;
        _bmiColor = color;
      });
    } else {
      setState(() {
        _bmiCategory = 'Invalid input';
        _bmiColor = Colors.black;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/calculate.jpg',
              fit: BoxFit.cover,
            ),
            Center(
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Height (cm or m)',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _calculateBMI,
                      child: Text('Calculate BMI'),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        'Category: $_bmiCategory',
                        style: TextStyle(color: _bmiColor, fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
