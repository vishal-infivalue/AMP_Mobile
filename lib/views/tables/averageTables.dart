
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class AverageScoreTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Gradient a = const LinearGradient(
      colors: [Colors.blue, Colors.blue],
    );

    Gradient b = const LinearGradient(
      colors: [Colors.white, Colors.white],
    );
    return Scaffold(
      appBar: AppBar(
        title:
        Text('Average Score & Grades',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: AppColors.meruWhite,
              fontSize: 14.0,
              fontStyle: FontStyle.normal,
            )
        ),
        backgroundColor: AppColors.meruRed,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: Colors.white), // Blue icon
          onPressed: () => Navigator.pop(context), // Handle back button press
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(
                height: 17.0,
              ),
              Text(
                'n  Average Score & Grades',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.meruBlack,
                  fontSize: 14.0,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '  ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.meruBlack,
                  fontSize: 11.0,
                  letterSpacing: 0.5,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 3.0,
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 180.0,
                    height: 180.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: Gradient.lerp(a, b, 0.5),
                      color: Colors
                          .blue, // Change this to your desired background color
                    ),
                    child: Center(
                      child: Text(
                        '45 ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 50.0,
                          letterSpacing: 0.5,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Sum of scores of the last audits of all the stations divided by its number of stations ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 13.0,
                      letterSpacing: 0.5,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}







