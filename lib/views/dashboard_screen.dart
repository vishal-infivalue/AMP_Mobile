import 'package:amp/response/performing_stations.dart';
import 'package:amp/utils/global_values.dart';
import 'package:amp/views/cm_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pie_chart/pie_chart.dart' as pie_chart;
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../global_theme/horizontalbar.dart';
import '../providers_vm/generateOtp_provider.dart';
import '../response/validateUserOtp.dart';
import '../routes/route_names.dart';
import '../utils/CommonFunctions.dart';
import '../utils/app_colors.dart';
import '../utils/status_data.dart';
import '../utils/strings.dart';
import '../utils/user_helper.dart';
import 'notification_screen.dart';

class DM_DashboardScreen extends StatefulWidget {
  @override
  _DM_DashboardScreenState createState() => _DM_DashboardScreenState();
}

class _DM_DashboardScreenState extends State<DM_DashboardScreen> {
  UserResponse? user;
  String initials = '';

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  Future<void> loadUserDetails() async {
    UserResponse? userDetails = await UserDetailsHelper.getUserDetails();
    if (userDetails != null) {
      setState(() {
        user = userDetails;
        initials = UserDetailsHelper.getInitials(user!);
      });
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> data = [
      ChartData('Emmm', 20),
      ChartData('ERB Consumer', 30),
      ChartData('ERB Consumer', 30),
    ];

    final List<BarChartData> barChart = [
      BarChartData('<1', 500, 2, 3, 3),
      BarChartData('<6', 750, 2, 3, 3),
      BarChartData('1-3', 900, 2, 3, 3),
      BarChartData('3-6', 1250, 2, 3, 3),
    ];

    GlobalVariables gb = GlobalVariables();
    final List<NChartData> ndata = [
      NChartData('ERBCONA  - 4', 4),
      NChartData('ERBTECH - 4', 4),
      NChartData('HSE   - 4', 4),
      NChartData('FUEL - 4', 4),

      // NChartData('ERB CONA', gb.numberOfAuditsUpcoming_gb as int),
      // NChartData('ERB TECH', gb.numberOfAuditsUpcoming_gb as int),
      // NChartData('HSE', gb.numberOfAuditsUpcoming_gb as int),
      // NChartData('FUEL', gb.numberOfAuditsUpcoming_gb as int),
    ];

    List<_ChartData>? topPerforming = <_ChartData>[
      _ChartData('S1', 21, 28),
      _ChartData('s2', 24, 44),
      _ChartData('s3', 36, 48),
      _ChartData('s4', 38, 50),
      _ChartData('s5', 54, 66),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildSmallScreenLayout(context, data, ndata, barChart,
              topPerforming, chartData, chartData2);
        } else {
          return _buildLargeScreenLayout(context, data);
        }
      },
    );
  }

  Widget _buildSmallScreenLayout(
      BuildContext context,
      List<ChartData> data,
      List<NChartData> ndata,
      List<BarChartData> barData,
      List<_ChartData> topPerforming,
      List<ChartData1> chartData,
      List<ChartData2> chartData2) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          width: 60, // Set your desired width
          height: 60, // Set your desired height
          child: IconButton(
            icon: Image.asset("assets/images/menu_logo.png"),
            iconSize: 40, // Set the size of the IconButton
            onPressed: () =>     Navigator.pushNamed(context,
                Routenames.profileScreen) // Handle back button press
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context,
                  Routenames.profileScreen);
            },
            child: Container(
              margin: EdgeInsets.only(right: 16.0),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red, // Background color of the circle
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$initials',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildSmallScreenBody(context, data, ndata, barData, chartData),
        ],
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }

  Widget _buildSmallScreenBody(
      BuildContext context,
      List<ChartData> data,
      List<NChartData> ndata,
      List<BarChartData> barData,
      List<ChartData1> charData) {
    final logInProvider = Provider.of<APIProvider>(context);

    // logInProvider.getclusteravgscore(context);
    logInProvider.getperformingstations(context);
    logInProvider.getperformingstationsBottom(context);
    logInProvider.getAllDashBoard(context);



    /*if (logInProvider.pendingAudits.isEmpty && !logInProvider.loading) {
      logInProvider.fetchPendingAudits(context);
    }*/
    GlobalVariables gb = GlobalVariables();
    double avgScore = logInProvider.avgScoreDB;
    String gradeValue = logInProvider.gradeValueDB;
    String grade = logInProvider.grade;



    String roundoff_avgScore = CommonFunctions.roundDoubleToString(avgScore) as String;

    String numberofaudits = logInProvider.numberofaudits;

    gb.pendingAuditTable_gb = logInProvider.pendingAuditTable;
    gb.completedAuditList_gb = logInProvider.completedAuditList;
    gb.upcomingAuditMessage_gb = logInProvider.avgMessageDB;
    gb.numberOfAuditsUpcoming_gb = logInProvider.numberOfAuditsUpcoming;

    /*String numberofERBCONAaudits_gb =logInProvider.numberofERBCONAaudits;
    String numberofERBTECHaudits_gb =logInProvider.numberofERBTECHaudits;
    String numberofHSEaudits_gb = logInProvider.numberofHSEaudits;
    String numberofFUELaudits_gb = logInProvider.numberofFUELaudits;*/

    // gb.numberOfAuditsUpcoming_gb = logInProvider.numberofERBCONAaudits;
    // gb.numberOfAuditsUpcoming_gb = logInProvider.numberofERBTECHaudits;
    // gb.numberOfAuditsUpcoming_gb = logInProvider.numberofHSEaudits;
    // gb.numberOfAuditsUpcoming_gb = logInProvider.numberofFUELaudits;

    return SingleChildScrollView(
      child: Container(
        color: AppColors.merudashBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 27.0,
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
              child: Text(
                'Hello, ${user!.firstName} ${user!.lastName}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.meruBlack,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Text(
                AppStrings.welcomeMessage,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: AppColors.meruBlack,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            // audit score &grade
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 100.8 / 2.0),
                    child: Container(
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.fromLTRB(16, 2, 16, 2),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(
                                15), // Ensures the gradient follows the card's rounded corners
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  15), // Keeps the padding inside the gradient
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            /*Navigator.pushNamed(context,
                                                Routenames.averageScoreTable);*/
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              logInProvider.avgMessageDB,
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: AppColors.meruBlack,
                                                fontSize: 12.0,
                                                letterSpacing: 1,
                                                fontStyle: FontStyle.normal,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SfRadialGauge(
                                        axes: <RadialAxis>[
                                          RadialAxis(
                                            minimum: 0,
                                            maximum: 100,
                                            radiusFactor: 0.7,
                                            // Adjust radius as needed
                                            interval: 20,
                                            startAngle: 170,
                                            // Set start angle to 270 for a semi-circle starting from the top
                                            endAngle: 370,
                                            // Set end angle to 450 to cover the remaining half
                                            ranges: <GaugeRange>[
                                              GaugeRange(
                                                startValue: -10,
                                                endValue: 19,
                                                startWidth: 25,
                                                endWidth: 25,
                                                color: Colors.red,
                                              ),
                                              GaugeRange(
                                                startValue: 20,
                                                endValue: 39,
                                                startWidth: 25,
                                                endWidth: 25,
                                                color: Colors.orange,
                                              ),
                                              GaugeRange(
                                                startValue: 40,
                                                endValue: 59,
                                                startWidth: 25,
                                                endWidth: 25,
                                                color: Colors.yellow,
                                              ),
                                              GaugeRange(
                                                startValue: 60,
                                                endValue: 79,
                                                startWidth: 25,
                                                endWidth: 25,
                                                color: Colors.greenAccent,
                                              ),
                                              GaugeRange(
                                                startValue: 80,
                                                endValue: 100,
                                                startWidth: 25,
                                                endWidth: 25,
                                                color: Colors.green,
                                              ),
                                            ],
                                            pointers: <GaugePointer>[
                                              NeedlePointer(value: avgScore)
                                            ],
                                            annotations: <GaugeAnnotation>[
                                              GaugeAnnotation(
                                                widget: Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '\n\n\n\nAverage Score : $roundoff_avgScore%\nAverage Grade : $gradeValue',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 2,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                angle: 90,
                                                positionFactor: 0.9,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      /*Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                Routenames.averageScoreTable);
                                          },
                                          child: Text(
                                            AppStrings.clickAuditScore,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: AppColors.meruBlack,
                                              fontSize: 12.0,
                                              letterSpacing: 1,
                                              fontStyle: FontStyle.normal,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),*/
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        margin: EdgeInsets.all(16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppStrings.auditScore,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // upcoming
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 100.8 / 2.0),
                    child: Container(
                        child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.fromLTRB(16, 2, 16, 2),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Colors.white,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                         logInProvider.numberOfAuditsUpcoming+" "+logInProvider.upcomingAuditMessage,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          letterSpacing: 2,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routenames.pendingTable);
                                  },
                                  child: Text(
                                    AppStrings.tapView,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: AppColors.meruBlack,
                                      fontSize: 12.0,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.underline, // Underline the text
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    )),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(4, 0, 4, 4),
                      child: Card(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        margin: EdgeInsets.all(16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppStrings.upcomingAudits,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            //completed
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 100.8 / 2.0),
                    child: Container(
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.fromLTRB(16, 2, 16, 2),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(
                                15), // Ensures the gradient follows the card's rounded corners
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  15), // Keeps the padding inside the gradient
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Text(
                                            logInProvider.completedaudits,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: AppColors.meruBlack,
                                              fontSize: 12.0,
                                              letterSpacing: 1,
                                              fontStyle: FontStyle.normal,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: pie_chart.PieChart(
                                          dataMap: ndata.asMap().map(
                                              (index, chartData) => MapEntry(
                                                  chartData.title,
                                                  chartData.value.toDouble())),
                                          chartRadius: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          // Adjust radius for mobile
                                          legendOptions:
                                              const pie_chart.LegendOptions(
                                            showLegendsInRow: false,
                                            legendPosition:
                                                pie_chart.LegendPosition.right,
                                            // Legend at the bottom
                                            showLegends: true,
                                          ),
                                          chartValuesOptions: const pie_chart
                                              .ChartValuesOptions(
                                            showChartValueBackground: false,
                                            showChartValues: false,
                                            showChartValuesInPercentage: false,
                                            showChartValuesOutside: false,
                                            decimalPlaces: 1,
                                          ),
                                          chartType: pie_chart.ChartType.ring,
                                          // Set chart type to ring for donut effect
                                          ringStrokeWidth:
                                              20, // Adjust ring stroke width as needed
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 2),
                                          child: Text(
                                            "Number of Completed Audits - $numberofaudits",
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: AppColors.meruBlack,
                                              fontSize: 12.0,
                                              letterSpacing: 1,
                                              fontStyle: FontStyle.normal,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 2),
                                          child: Text(
                                            "Number of NCs - 0",
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: AppColors.meruBlack,
                                              fontSize: 12.0,
                                              letterSpacing: 1,
                                              fontStyle: FontStyle.normal,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),

                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                Routenames.completedTable);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Tap to View Details",
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: AppColors.meruBlack,
                                                fontSize: 12.0,
                                                letterSpacing: 1,
                                                fontStyle: FontStyle.normal,
                                                decoration: TextDecoration.underline,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        color: AppColors.kBackgroundGradientStart,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        margin: EdgeInsets.all(16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppStrings.completedAudits,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            //nc aging
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 100.8 / 2.0),
                    child: Container(
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.fromLTRB(16, 2, 16, 2),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(
                                15), // Ensures the gradient follows the card's rounded corners
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  15), // Keeps the padding inside the gradient
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            AppStrings.titleNCText,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: AppColors.meruBlack,
                                              fontSize: 12.0,
                                              letterSpacing: 1,
                                              fontStyle: FontStyle.normal,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: SfCartesianChart(
                                          primaryXAxis: CategoryAxis(),
                                          series: [
                                            StackedColumnSeries<BarChartData,
                                                String>(
                                              color: Colors.indigo,
                                              dataSource: barData,
                                              xValueMapper:
                                                  (BarChartData br, _) =>
                                                      br.x as String,
                                              yValueMapper:
                                                  (BarChartData br, _) =>
                                                      br.y1 as num,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                Routenames.nonComplianceTable);
                                          },
                                          child: Text(
                                            AppStrings.tapDetails,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: AppColors.meruBlack,
                                              fontSize: 12.0,
                                              letterSpacing: 1,
                                              fontStyle: FontStyle.normal,
                                              decoration: TextDecoration.underline,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        margin: EdgeInsets.all(16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppStrings.ncAgeing,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            //performing stations
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 100.8 / 2.0),
                    child: Container(
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.fromLTRB(16, 2, 16, 2),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(
                                15), // Ensures the gradient follows the card's rounded corners
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  15), // Keeps the padding inside the gradient
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        Routenames
                                                            .topPerformingTable);
                                                  },
                                                  child: Text(
                                                    "Top 3 Performing Stations",
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                      fontSize: 12.0,
                                                      letterSpacing: 2,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 150,
                                                  child: SfCartesianChart(
                                                    primaryXAxis:
                                                        CategoryAxis(),
                                                    primaryYAxis: NumericAxis(
                                                        minimum: 0,
                                                        maximum: 120,
                                                        interval: 25),
                                                    series: <CartesianSeries<
                                                        Station, String>>[
                                                      BarSeries<Station,
                                                          String>(
                                                        dataSource: gb
                                                            .topStationList.reversed
                                                            .toList(),
                                                        xValueMapper: (Station
                                                                    data,
                                                                _) =>
                                                            data.stationCode ??
                                                            '',
                                                        yValueMapper:
                                                            (Station data, _) =>
                                                                data.avgScore ??
                                                                0,
                                                        name: 'Gold',
                                                        color: Colors.yellow,
                                                        width: 0.2,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        Routenames
                                                            .bottomPerformingTable);
                                                  },
                                                  child: Text(
                                                    "Bottom 3 Performing Stations",
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                      fontSize: 12.0,
                                                      letterSpacing: 2,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 150,
                                                  child: SfCartesianChart(
                                                    primaryXAxis:
                                                        CategoryAxis(),
                                                    primaryYAxis: NumericAxis(
                                                        minimum: 0,
                                                        maximum: 120,
                                                        interval: 25),
                                                    series: <CartesianSeries<
                                                        Station, String>>[
                                                      BarSeries<Station,
                                                          String>(
                                                        dataSource: gb
                                                            .bottomStationList
                                                            .toList(),
                                                        xValueMapper: (Station
                                                                    data,
                                                                _) =>
                                                            data.stationCode ??
                                                            '',
                                                        yValueMapper:
                                                            (Station data, _) =>
                                                                data.avgScore ??
                                                                0,
                                                        name: 'Gold',
                                                        color: Colors.red,
                                                        width: 0.2,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              Center(
                                                child: GestureDetector(
                                                  onTap: () {

                                                  },
                                                  child: Text(
                                                    AppStrings.tapView,
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: AppColors.meruBlack,
                                                      fontSize: 12.0,
                                                      fontStyle: FontStyle.normal,
                                                      decoration: TextDecoration.underline, // Underline the text
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        margin: EdgeInsets.all(16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppStrings.PerformingStation,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 10.0),
            Center(
              child: Text(
                ' © MERU AUDIT PLATFORM 2024 ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.grey,
                  fontSize: 11.0,
                  letterSpacing: 0.5,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildLargeScreenLayout(BuildContext context, List<ChartData> data) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Audit Management Platform',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: AppColors.meruWhite,
              fontSize: 14.0,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.meruRed,
      ),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.white,
            selectedIndex: 0,
            onDestinationSelected: (index) {
              String message;
              switch (index) {
                case 0:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DM_DashboardScreen()),
                  );
                  break;
                case 1:
                  // message = "Profile tapped";
                  //add map here
                  break;
                case 3:
                  // message = "Profile tapped";

                  break;
                case 2:
                  // message = "Notifications tapped";
                  final List<NotificationItem> notifications = [
                    NotificationItem(
                      title: 'New Order Received',
                      content: 'You have a new order #12345 from John Doe.',
                      dateTime:
                          DateTime.now().subtract(const Duration(hours: 2)),
                    ),
                    NotificationItem(
                      title: 'Reminder: Weekly Meeting',
                      content: 'Your weekly team meeting is today at 2 PM.',
                      dateTime:
                          DateTime.now().subtract(const Duration(days: 1)),
                    ),
                    NotificationItem(
                      title: 'App Update Available',
                      content:
                          'A new update for your app is available. Please update to enjoy the latest features.',
                      dateTime:
                          DateTime.now().subtract(const Duration(days: 3)),
                      isNew: true,
                    ),
                  ];
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(
                          notifications: notifications, currentIndex: index),
                    ),
                  );
                  break;
                default:
                  message = "";
              }
              // showToast(message);
            },
            labelType: NavigationRailLabelType.all,
            selectedIconTheme: IconThemeData(color: Colors.blueGrey),
            selectedLabelTextStyle: TextStyle(color: Colors.blueGrey),
            unselectedIconTheme: IconThemeData(color: Colors.grey),
            unselectedLabelTextStyle: TextStyle(color: Colors.grey),
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard, color: Colors.blue),
                label: Text(
                  'Dashboard',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: AppColors.meruBlack,
                    fontSize: 12.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.map_outlined, color: Colors.grey),
                label: Text(
                  'Stations',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 11.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person, color: Colors.grey),
                label: Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 11.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notifications, color: Colors.grey),
                label: Text(
                  'Notifications',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 11.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome Joe Rogan',
                                    style: TextStyle(
                                      color: Color(0xFFC62828),
                                      fontSize: 18,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Name : User',
                                    style: TextStyle(
                                      color: Color(0xFFC62828),
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/logo.jpeg'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PieChart(
                            dataMap: data.asMap().map((index, chartData) =>
                                MapEntry(chartData.title,
                                    chartData.value.toDouble())),
                            colorList: [
                              Colors.red,
                              Colors.blue,
                              Colors.green,
                              Colors.orange,
                            ],
                            chartRadius: MediaQuery.of(context).size.width / 3,
                            legendOptions: const LegendOptions(
                              // legendPosition: LegendPosition.right,
                              showLegendsInRow: false,
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: false,
                              decimalPlaces: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  _buildTopChecklistTable(),
                  const SizedBox(height: 20.0),
                  _buildChecklistUtilizationTable(),
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Audits',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, Routenames.form);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.title),
                              const Icon(Icons.chevron_right),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Location Overview',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildLocationOverViewTable(),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        /*Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuditLogin()),
                        );*/
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC62828),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Logout",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build the TopChecklistTable
  Widget _buildTopChecklistTable() {
    // Implementation of your TopChecklistTable widget
    return Placeholder();
  }

  Widget buildStatusGraph(List<StatusData> data) {
    final chartData = data.map((item) => item.count).toList();
    final colorList = data.map((item) => item.color).toList();
    final legendLabels = data.map((item) => item.status).toList();

    return PieChart(
      dataMap: Map.fromIterable(
        data,
        key: (item) => item.status,
        value: (item) => item.count,
      ),
      animationDuration: Duration(milliseconds: 800),
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      centerText: "Status",
      legendOptions: LegendOptions(
        showLegends: true,
        // legendPosition: LegendPosition.right,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesOutside: false,
        decimalPlaces: 0,
      ),
      colorList: colorList,
      chartLegendSpacing: 32,
      initialAngleInDegree: 0,
      // legendLabels: legendLabels,
    );
  }

  // Function to build the ChecklistUtilizationTable
  Widget _buildChecklistUtilizationTable() {
    // Implementation of your ChecklistUtilizationTable widget
    return Placeholder();
  }

  // Function to build the LocationOverViewTable
  Widget _buildLocationOverViewTable() {
    // Implementation of your LocationOverViewTable widget
    return Placeholder();
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DM_DashboardScreen()),
            );
            break;
          case 1:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('Location Service running. Background thread.')),
            );
            break;
          case 2:
            Navigator.pushNamed(context, Routenames.profileScreen);

            break;
          case 3:
            final List<NotificationItem> notifications = [
              NotificationItem(
                title: 'New Order Received',
                content: 'You have a new order #12345 from John Doe.',
                dateTime: DateTime.now().subtract(const Duration(hours: 2)),
              ),
              NotificationItem(
                title: 'Reminder: Weekly Meeting',
                content: 'Your weekly team meeting is today at 2 PM.',
                dateTime: DateTime.now().subtract(const Duration(days: 1)),
              ),
              NotificationItem(
                title: 'App Update Available',
                content:
                    'A new update for your app is available. Please update to enjoy the latest features.',
                dateTime: DateTime.now().subtract(const Duration(days: 3)),
                isNew: true,
              ),
            ];
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationScreen(
                    notifications: notifications, currentIndex: index),
              ),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Stations',
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: Colors.black),
      ],
      selectedIconTheme: const IconThemeData(
        color: Colors.purple,
      ),
      unselectedIconTheme: const IconThemeData(color: Colors.grey),
      selectedLabelStyle: const TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 11.0,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.normal,
        color: Colors.grey,
        fontSize: 11.0,
      ),
    );
  }
}

class BarChartData {
  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;

  BarChartData(this.x, this.y1, this.y2, this.y3, this.y4);
}

class ChartData {
  final String title;
  final int value;

  ChartData(this.title, this.value);
}

final chartData = [
  ChartData1('s1', 45),
  ChartData1('s2', 65),
  ChartData1('s3', 85),
];

class TopPerformingData {
  final String title;
  final int value;

  TopPerformingData(this.title, this.value);
}

final topPerformingData = [
  TopPerformingData('s7', 85),
  TopPerformingData('s6', 60),
  TopPerformingData('s5', 40),
];

class NChartData {
  final String title;
  final int value;

  NChartData(this.title, this.value);
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);

  final String x;
  final double y;
  final double y2;
}

class _BarChartProvider extends ChangeNotifier {
  List<_ChartData>? chartData = <_ChartData>[
    _ChartData('Mon', 21, 28),
    _ChartData('Tus', 24, 44),
    _ChartData('Wen', 36, 48),
    _ChartData('Thr', 38, 50),
    _ChartData('Fri', 54, 66),
    _ChartData('Sat', 57, 78),
    _ChartData('Sun', 70, 84)
  ];

  void init() {}

  @override
  void dispose() {
    chartData?.clear();
    super.dispose();
  }
}
