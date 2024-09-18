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

class ComplainceManagerDash extends StatefulWidget {
  @override
  _ComplainceManagerDashState createState() => _ComplainceManagerDashState();
}

class _ComplainceManagerDashState extends State<ComplainceManagerDash> {
  UserResponse? user;
  String initials = '';

  @override
  void initState() {
    super.initState();
    loadUserDetails();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final apiProvider = Provider.of<APIProvider>(context, listen: false);
      await apiProvider.fetchPendingAudits(context);
      await apiProvider.getclusteravgscore(context);
      await apiProvider.getperformingstations(context);
      await apiProvider.getperformingstationsBottom(context);
      await apiProvider.getAllDashBoard(context);
    });
  }



  Future<void> loadUserDetails() async {
    UserResponse? userDetails = await UserDetailsHelper.getUserDetails();
    if (userDetails != null && mounted) {
      setState(() {
        user = userDetails;
        initials = UserDetailsHelper.getInitials(user!);
      });
    }
  }

  /*Future<void> loadUserDetails() async {
    UserResponse? userDetails = await UserDetailsHelper.getUserDetails();
    if (userDetails != null) {
      setState(() {
        user = userDetails;
        initials = UserDetailsHelper.getInitials(user!);
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {



    final List<BarChartData> barChart = [
      BarChartData('<1', 500, 2, 3, 3),
      BarChartData('<6', 750, 2, 3, 3),
      BarChartData('1-3', 900, 2, 3, 3),
      BarChartData('3-6', 1250, 2, 3, 3),
    ];

    final List<NChartData> ndata = [
      NChartData('ERBCONA  - 1', 1),
      NChartData('ERBTECH - 1', 1),
      NChartData('HSE   - 2', 2),
      NChartData('FUEL - 2', 2),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildSmallScreenLayout(context, ndata, barChart);
        } else {
          return _buildLargeScreenLayout(context, ndata, barChart);
        }
      },
    );
  }

  Widget _buildSmallScreenLayout(
      BuildContext context,
      List<NChartData> ndata,
      List<BarChartData> barData) {
    final logInProvider = Provider.of<APIProvider>(context);

    if (logInProvider == null || logInProvider.pendingAuditTable == null) {
      return Center(child: CircularProgressIndicator());  // Or any placeholder
    }
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

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Center(
                    child: TweenAnimationBuilder<Color?>(
                      tween: ColorTween(begin: Colors.red, end: Colors.yellow),
                      duration: Duration(seconds: 1),
                      builder: (context, color, _) {
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(color!),
                        );
                      },
                      onEnd: () {
                        // No need to do anything here
                      },
                    ),
                  );
                },
              );

              Future.delayed(Duration(seconds: 4), () {
                Navigator.of(context).pop();

                Navigator.pushNamed(context,
                    Routenames.profileScreen);
              });


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
          _buildSmallScreenBody(context, ndata, barData),
        ],
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }

  Widget _buildLargeScreenLayout(
      BuildContext context,
      List<NChartData> ndata,
      List<BarChartData> barData) {
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

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Center(
                    child: TweenAnimationBuilder<Color?>(
                      tween: ColorTween(begin: Colors.red, end: Colors.yellow),
                      duration: Duration(seconds: 1),
                      builder: (context, color, _) {
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(color!),
                        );
                      },
                      onEnd: () {
                        // No need to do anything here
                      },
                    ),
                  );
                },
              );

              // Simulate a delay of 4 seconds
              Future.delayed(Duration(seconds: 4), () {
                Navigator.of(context)
                    .pop(); // Close the CircularProgressIndicator dialog

                Navigator.pushNamed(context,
                    Routenames.profileScreen);
              });


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
          _buildSmallScreenBody(context, ndata, barData),
        ],
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }

  Widget _buildSmallScreenBody(
      BuildContext context,
      List<NChartData> ndata,
      List<BarChartData> barData) {
    final logInProvider = Provider.of<APIProvider>(context);

    GlobalVariables gb = GlobalVariables();
    double avgScore = logInProvider.avgScoreDB;
    String gradeValue = logInProvider.gradeValueDB;



    String roundoff_avgScore = CommonFunctions.roundDoubleToString(avgScore) as String;

    String numberofaudits = logInProvider.numberofaudits;

    gb.pendingAuditTable_gb = logInProvider.pendingAuditTable;
    gb.ncAuditTable_gb = logInProvider.ncAuditTable;
    gb.completedAuditList_gb = logInProvider.completedAuditList;
    gb.upcomingAuditMessage_gb = logInProvider.avgMessageDB;
    gb.numberOfAuditsUpcoming_gb = logInProvider.numberOfAuditsUpcoming;

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
                user != null
                    ? 'Hello, ${user!.firstName} ${user!.lastName}'
                    : 'Loading user details...',
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

            //ScheduledAudit
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
                                            logInProvider.numberOfAuditsUpcoming+" "+"List of audits pending final signature and submission",
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

                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: TweenAnimationBuilder<Color?>(
                                                tween: ColorTween(begin: Colors.red, end: Colors.yellow),
                                                duration: Duration(seconds: 1),
                                                builder: (context, color, _) {
                                                  return CircularProgressIndicator(
                                                    valueColor: AlwaysStoppedAnimation<Color>(color!),
                                                  );
                                                },
                                                onEnd: () {
                                                  // No need to do anything here
                                                },
                                              ),
                                            );
                                          },
                                        );

                                        // Simulate a delay of 4 seconds
                                        Future.delayed(Duration(seconds: 1), () {
                                          Navigator.of(context)
                                              .pop(); // Close the CircularProgressIndicator dialog

                                          Navigator.pushNamed(context, Routenames.submittedTable);
                                        });


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
                        color: Colors.yellow,
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
                                AppStrings.ScheduleAudits,
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

                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: TweenAnimationBuilder<Color?>(
                                                tween: ColorTween(begin: Colors.red, end: Colors.yellow),
                                                duration: Duration(seconds: 1),
                                                builder: (context, color, _) {
                                                  return CircularProgressIndicator(
                                                    valueColor: AlwaysStoppedAnimation<Color>(color!),
                                                  );
                                                },
                                                onEnd: () {
                                                  // No need to do anything here
                                                },
                                              ),
                                            );
                                          },
                                        );

                                        // Simulate a delay of 4 seconds
                                        Future.delayed(Duration(seconds: 1), () {
                                          Navigator.of(context)
                                              .pop(); // Close the CircularProgressIndicator dialog

                                          Navigator.pushNamed(context, Routenames.pendingTable);
                                        });


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

                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return Center(
                                                  child: TweenAnimationBuilder<Color?>(
                                                    tween: ColorTween(begin: Colors.red, end: Colors.yellow),
                                                    duration: Duration(seconds: 1),
                                                    builder: (context, color, _) {
                                                      return CircularProgressIndicator(
                                                        valueColor: AlwaysStoppedAnimation<Color>(color!),
                                                      );
                                                    },
                                                    onEnd: () {
                                                      // No need to do anything here
                                                    },
                                                  ),
                                                );
                                              },
                                            );

                                            // Simulate a delay of 4 seconds
                                            Future.delayed(Duration(seconds: 1), () {
                                              Navigator.of(context)
                                                  .pop(); // Close the CircularProgressIndicator dialog

                                              Navigator.pushNamed(context,
                                                  Routenames.completedTable);
                                            });


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
                                            logInProvider.getNCData(context);
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

                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (BuildContext context) {
                                                        return Center(
                                                          child: TweenAnimationBuilder<Color?>(
                                                            tween: ColorTween(begin: Colors.red, end: Colors.yellow),
                                                            duration: Duration(seconds: 1),
                                                            builder: (context, color, _) {
                                                              return CircularProgressIndicator(
                                                                valueColor: AlwaysStoppedAnimation<Color>(color!),
                                                              );
                                                            },
                                                            onEnd: () {
                                                              // No need to do anything here
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    );

                                                    // Simulate a delay of 4 seconds
                                                    Future.delayed(Duration(seconds: 1), () {
                                                      Navigator.of(context)
                                                          .pop(); // Close the CircularProgressIndicator dialog

                                                      Navigator.pushNamed(
                                                          context,
                                                          Routenames
                                                              .topPerformingTable);
                                                    });


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

                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (BuildContext context) {
                                                        return Center(
                                                          child: TweenAnimationBuilder<Color?>(
                                                            tween: ColorTween(begin: Colors.red, end: Colors.yellow),
                                                            duration: Duration(seconds: 1),
                                                            builder: (context, color, _) {
                                                              return CircularProgressIndicator(
                                                                valueColor: AlwaysStoppedAnimation<Color>(color!),
                                                              );
                                                            },
                                                            onEnd: () {
                                                              // No need to do anything here
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    );

                                                    // Simulate a delay of 4 seconds
                                                    Future.delayed(Duration(seconds: 1), () {
                                                      Navigator.of(context)
                                                          .pop(); // Close the CircularProgressIndicator dialog

                                                      Navigator.pushNamed(
                                                          context,
                                                          Routenames
                                                              .bottomPerformingTable);
                                                    });


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
}


class NChartData {
  final String title;
  final int value;

  NChartData(this.title, this.value);
}

