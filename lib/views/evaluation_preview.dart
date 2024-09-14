import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class EvaluationPreview extends StatefulWidget {
  final String omc;
  final String site;
  final String address;
  final String contacts;
  final String ocr;
  final String grading;

  const EvaluationPreview({
    Key? key,
    required this.omc,
    required this.site,
    required this.address,
    required this.contacts,
    required this.ocr,
    required this.grading,
  }) : super(key: key);

  @override
  _EvaluationPreviewState createState() => _EvaluationPreviewState();
}

class _EvaluationPreviewState extends State<EvaluationPreview> {
  bool _showLoading = false;
  bool _showLoadingSubmit = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, double> dataMap = {
      'Z W & M Certification (02)': 2,
      'Fire Certificate (02)': 2,
      'Trading License (02)': 2,
      'Storage of Petroleum License (02)': 2,
      'ERB Valid Retail License (01)': 1,
      'Filler Box (02)': 2,
      'Product Color Coding (Manhole Covers) (02)': 2,
      'Leak Detection Tank Farm (04)': 4,
      'Leak Detection Product Delivery Line (04)': 4,
      'Water Dip (02)': 2,
      'Offloading Point': 0,
      'Tank Capacities Petrol': 0,
      'Tank Capacities Diesel': 0,
      'Tank Capacities Low Sulphur Diesel': 0,
      'Tank Capacities Kerosene': 0,
      'Positioning of Tanks': 0,
      'Leak Detection': 0,
    };

    final Map<String, double> dataMap1 = {
      '21 January 2024': 425522,
      '25 March 2024': 673738,
      '3 June 2024': 899373,
    };

    final totalPoints = 51;
    final pointsReceived = dataMap.values.reduce((a, b) => a + b);
    final percentage = (pointsReceived / totalPoints) * 100;

    Gradient a = const LinearGradient(
      colors: [Colors.blue, Colors.blue],
    );

    Gradient b = const LinearGradient(
      colors: [Colors.white, Colors.white],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Preview',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: AppColors.meruWhite,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: AppColors.meruRed,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: AppColors.meruWhite),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Zamira Retail Station ERB Consumer Audit',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First row with a single text
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Station Name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Station Code',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Station Type',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Second row with two texts
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'SM Name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'RM Name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'CM Name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Second row with two texts
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First row with a single text
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Auditor Name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Audit Start Time',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Audit End time',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Second row with two texts
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),



            /*_buildTable([
              ['Station Name', ''],
              ['Station Code', ''],
              ['Station Type', ''],
              ['Region', ''],
              ['SM Name', ''],
              ['RH Name', ''],
              ['CM Name', ''],
              ['Auditor Name', ''],
              ['Last Audit Score', ''],
              ['Last Audit %', ''],
              ['Earned Points', ''],
              ['Overall Score', ''],
            ]),*/
            SizedBox(
              height: 20,
            ),
            Text(
              'Overall compliance rate (OCR) : Consumer calculated 67 and obtained 92%',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.meruBlack,
                fontSize: 16.0,
                fontStyle: FontStyle.normal,
              ),
            ),
            Text(
              'Grading : A(95-100% Very Good) (B: 80-94% Good) (C : 60-79% Fair) (D:1%-59% Deficient) (F:0%-0% Closed)',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: AppColors.meruBlack,
                fontSize: 18.0,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //'EVALUATION SCORE SUMMARY',
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'EVALUATION SCORE SUMMARY',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: AppColors.meruBlack,
                  fontSize: 18.0,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: const {
                    0: IntrinsicColumnWidth(),
                    1: IntrinsicColumnWidth(),
                    2: IntrinsicColumnWidth(),
                    3: IntrinsicColumnWidth(),
                    4: IntrinsicColumnWidth(),
                    5: IntrinsicColumnWidth(),
                    6: IntrinsicColumnWidth(),
                    7: IntrinsicColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('SNo', style: TextStyle(fontFamily: 'Poppins', color: AppColors.meruBlack, fontSize: 12.0, letterSpacing: 1, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Section Name', style: TextStyle(fontFamily: 'Poppins', color: AppColors.meruBlack, fontSize: 12.0, letterSpacing: 1, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('No of NC', style: TextStyle(fontFamily: 'Poppins', color: AppColors.meruBlack, fontSize: 12.0, letterSpacing: 1, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('%', style: TextStyle(fontFamily: 'Poppins', color: AppColors.meruBlack, fontSize: 12.0, letterSpacing: 1, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Maximum', style: TextStyle(fontFamily: 'Poppins', color: AppColors.meruBlack, fontSize: 12.0, letterSpacing: 1, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Obtained', style: TextStyle(fontFamily: 'Poppins', color: AppColors.meruBlack, fontSize: 12.0, letterSpacing: 1, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Score %', style: TextStyle(fontFamily: 'Poppins', color: AppColors.meruBlack, fontSize: 12.0, letterSpacing: 1, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Grade', style: TextStyle(fontFamily: 'Poppins', color: AppColors.meruBlack, fontSize: 12.0, letterSpacing: 1, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal)),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('1', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack, fontSize: 12.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('SAFETY', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack, fontSize: 12.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('1 ', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack, fontSize: 12.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('100 ', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack, fontSize: 12.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('20 ', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack, fontSize: 12.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('19 ', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack, fontSize: 12.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('95% ', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack, fontSize: 12.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('A ', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack, fontSize: 12.0, fontStyle: FontStyle.normal)),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack,fontWeight: FontWeight.bold, fontSize: 13.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('GRAND TOTAL', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack,fontWeight: FontWeight.bold, fontSize: 13.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('10 ', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack,fontWeight: FontWeight.bold, fontSize: 13.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('497% ', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack,fontWeight: FontWeight.bold, fontSize: 13.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('100 ', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack,fontWeight: FontWeight.bold, fontSize: 13.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('96 ', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack,fontWeight: FontWeight.bold, fontSize: 13.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('95% ', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack,fontWeight: FontWeight.bold, fontSize: 13.0, fontStyle: FontStyle.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('A ', style: TextStyle(fontFamily: 'Montserrat', color: AppColors.meruBlack,fontWeight: FontWeight.bold, fontSize: 13.0, fontStyle: FontStyle.normal)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),


            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.2,
                      50.0,
                    ),
                  ),
                  label: Text(
                    "Generate Score Card",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, Routenames.evaluationScorePage);
                  },
                ),
              ),
            ),*/

          ],
        ),
      ),
    );
  }

  Widget _buildTable(List<List<String>> data) {
    return Table(
      border: TableBorder.all(),
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: data.map((row) {
        return TableRow(
          children: row.map((cell) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cell,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: AppColors.meruBlack,
                  fontSize: 12.0,
                  fontStyle: FontStyle.normal,
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  Widget _buildTableForServices(List<List<String>> data) {
    return Table(
      border: TableBorder.all(),
      columnWidths: {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1),
        6: FlexColumnWidth(1),
        7: FlexColumnWidth(1),
      },
      children: data.map((row) {
        return TableRow(
          children: row.map((cell) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cell,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: AppColors.meruBlack,
                  fontSize: 12.0,
                  fontStyle: FontStyle.normal,
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
