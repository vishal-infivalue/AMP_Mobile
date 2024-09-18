import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../routes/route_names.dart';
import '../utils/app_colors.dart';
import 'dashboard_screen.dart';

class NotificationItem {
  final String title;
  final String content;
  final DateTime dateTime;
  final bool isNew;

  NotificationItem({
    required this.title,
    required this.content,
    required this.dateTime,
    this.isNew = false,
  });
}

class NotificationScreen extends StatelessWidget {
  final List<NotificationItem> notifications;
  final int currentIndex;

  const NotificationScreen(
      {Key? key, required this.notifications, required this.currentIndex})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildSmallScreenLayout(context);
        } else {
          return _buildLargeScreenLayout(context);
        }
      },
    );
  }

  Widget _buildLargeScreenLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            child: Text('Audit Management Platform',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: AppColors.meruWhite,
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                ))),
        backgroundColor: AppColors.meruRed,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: Colors.white),
          // Blue icon
          onPressed: () => Navigator.pop(context), // Handle back button press
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.white,
            selectedIndex: 2, // Adjust selectedIndex as needed
            onDestinationSelected: (index) {
              String message;
              switch (index) {
                case 0:

                  Navigator.pushNamed(context, Routenames.dmDashboardScreen);
                 /* Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );*/
                  break;
                case 1:
                  break;
                case 2:

                  break;
                case 3:

                  break;
                default:
                  message = "";
              }
            },
            labelType: NavigationRailLabelType.all,
            selectedIconTheme: IconThemeData(color: Colors.blueGrey),
            selectedLabelTextStyle: TextStyle(color: Colors.blueGrey),
            unselectedIconTheme: IconThemeData(color: Colors.grey),
            unselectedLabelTextStyle: TextStyle(color: Colors.grey),
            destinations:  [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard, color: Colors.grey),
                label: Text('Dashboard',style:TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 11.0,
                ),),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.map_outlined, color: Colors.grey),
                label: Text('Stations',style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 11.0,
                ),),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person, color: Colors.grey),
                label: Text('Profile',style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 11.0,
                ),),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notifications, color: Colors.blue),
                label: Text('Notifications',style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: AppColors.meruBlack,
                  fontSize: 12.0,
                ),),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (notification.isNew)
                                Container(
                                  width: 8.0,
                                  height: 8.0,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              const SizedBox(width: 10.0),
                              Text(
                                notification.title,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(notification.content),
                          const SizedBox(height: 8.0),
                          Text(
                            DateFormat('dd MMM yyyy, HH:mm').format(notification.dateTime),
                            style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallScreenLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Audit Management Platform',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: AppColors.meruWhite,
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                ))),
        backgroundColor: AppColors.meruRed,
        automaticallyImplyLeading: false,
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Notifications',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: AppColors.meruBlack,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (notification.isNew)
                                  Container(
                                    width: 8.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                const SizedBox(width: 10.0),
                                Text(
                                  notification.title,
                                  style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: AppColors.meruBlack,
                                  fontSize: 12.0,
                                ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Text(notification.content,style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.grey,
                              fontSize: 11.0,
                            ),),
                            const SizedBox(height: 8.0),
                            Text(
                              DateFormat('dd MMM yyyy, HH:mm').format(notification.dateTime),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.blueGrey,
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 3), // Adjust currentIndex as needed
    );
  }
}

