import 'dart:ui';

import 'package:amp/providers_vm/audit_provider.dart';
import 'package:amp/utils/app_colors.dart';
import 'package:amp/utils/constant_strings.dart';
import 'package:amp/utils/shared_preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_to_expand/tap_to_expand.dart';
import 'package:intl/intl.dart';

import '../routes/route_names.dart';

class StockAuditListPage extends StatefulWidget {
  @override
  _StockAuditListPageState createState() => _StockAuditListPageState();
}

class _StockAuditListPageState extends State<StockAuditListPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  int _currentStep = 0;
  bool _init = true;

  bool _isSubmitToStationVisible = true;

  final _formKeyLube = GlobalKey<FormState>();
  final _formKeyLpg = GlobalKey<FormState>();

  final _headerTextStyle = const TextStyle(
    color: Colors.black,
    fontFamily: 'Montserrat',
    fontStyle: FontStyle.normal,
    fontSize: 13.0,
    fontWeight: FontWeight.bold,
  );

  final _headerValueTextStyle = const TextStyle(
    color: Colors.black,
    fontFamily: 'Montserrat',
    fontStyle: FontStyle.normal,
    fontSize: 13.0,
  );

  final _expandHeaderTextStyle = TextStyle(
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Lube form
  TextEditingController _oneTextControllerLU =
      TextEditingController(text: 'Select');
  TextEditingController _twoTextControllerLU = TextEditingController();
  TextEditingController _threeTextControllerLU =
      TextEditingController(text: 'Select');
  TextEditingController _fourTextControllerLU = TextEditingController();
  TextEditingController _fiveTextControllerLU =
      TextEditingController(text: 'Select');
  TextEditingController _sixTextControllerLU = TextEditingController();
  TextEditingController _sevenTextControllerLU =
      TextEditingController(text: 'Select');
  TextEditingController _eightTextControllerLU = TextEditingController();

  TextEditingController _nineTextControllerLU =
      TextEditingController(text: 'Select');
  TextEditingController _tenTextControllerLU = TextEditingController();

  TextEditingController _elevenTextControllerLU = TextEditingController();

  // LPG form
  TextEditingController _oneTextControllerLP =
      TextEditingController(text: 'Select');
  TextEditingController _twoTextControllerLP = TextEditingController();
  TextEditingController _threeTextControllerLP =
      TextEditingController(text: 'Select');
  TextEditingController _fourTextControllerLP = TextEditingController();
  TextEditingController _fiveTextControllerLP =
      TextEditingController(text: 'Select');
  TextEditingController _sixTextControllerLP = TextEditingController();
  TextEditingController _sevenTextControllerLP =
      TextEditingController(text: 'Select');
  TextEditingController _eightTextControllerLP = TextEditingController();

  TextEditingController _nineTextControllerLP =
      TextEditingController(text: 'Select');
  TextEditingController _tenTextControllerLP = TextEditingController();

  TextEditingController _elevenTextControllerLP =
      TextEditingController(text: 'Select');
  TextEditingController _twelveTextControllerLP = TextEditingController();

  TextEditingController _thirteenTextControllerLP = TextEditingController();

  final List<String> _stockLabelList = [
    'Product PMS',
    'Product LSD',
    'Product DK'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      Provider.of<AuditProvider>(context).fetchStockAuditsList("Fuel");
      Provider.of<AuditProvider>(context).fetchStockAuditsList("Lube");
      Provider.of<AuditProvider>(context).fetchStockAuditsList("Lpg");
      Provider.of<AuditProvider>(context).fetchStockAuditsHeaderDetails();
      Provider.of<AuditProvider>(context)
          .fetchStockAuditsNozzelsUSTDetails(type: 'DK');
      Provider.of<AuditProvider>(context).fetchStockAuditsLubeLPGDetails(
          type:
              'LUBE'); // Hard coded in api calling function. Need to bring it from Shared Preference.
      Provider.of<AuditProvider>(context).fetchStockAuditsLubeLPGDetails(
          type:
              'LPG'); // Hard coded in api calling function. Need to bring it from Shared Preference.

      _init = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var stockAuditsTypeListFuel =
        Provider.of<AuditProvider>(context).stockAuditsTypeListFuel; // Fuel
    var stockAuditsTypeListLube =
        Provider.of<AuditProvider>(context).stockAuditsTypeListLube; // Lube

    print("((()))))((((())))((((())))((((()))  $stockAuditsTypeListLube");

    var stockAuditsTypeListLpg =
        Provider.of<AuditProvider>(context).stockAuditsTypeListLpg; // Lpg

    var stockAuditsHeaderDetails = Provider.of<AuditProvider>(context)
        .stockAuditsHeaderDetails; // Audit header details for Lube & Lpg

    var lubeProductsTextControllers = Provider.of<AuditProvider>(context)
        .lubeProductsTextControllers; // Text controllers Lube
    var lpgProductsTextControllers = Provider.of<AuditProvider>(context)
        .lpgProductsTextControllers; // Text controllers Lpg

    var isStockAuditCompleted = Provider.of<AuditProvider>(context)
        .isStockAuditCompleted; // isStockAuditCompleted for Submit To Station Button Enable

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.merudashBg,
      appBar: AppBar(
        elevation: 0.5,
        title: const Text(
          'Stocks Audit',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: AppColors.meruRed,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: AppColors.meruWhite,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left_sharp,
            color: AppColors.meruRed,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          indicatorColor: AppColors.meruRed,
          unselectedLabelColor: AppColors.merubg,
          labelColor: AppColors.meruRed,
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: (index) {
            if (_tabController.index == 0) {
              setState(() {
                _isSubmitToStationVisible = true;
              });
            }
            if (_tabController.index == 1) {
              setState(() {
                _isSubmitToStationVisible = false;
              });
            }
            if (_tabController.index == 2) {
              setState(() {
                _isSubmitToStationVisible = false;
              });
            }
          },
          tabs: const <Widget>[
            Tab(
              child: Text(
                "Fuel",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Tab(
              child: Text(
                "Lube",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Tab(
              child: Text(
                "LPG",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              SizedBox(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Provider.of<AuditProvider>(context, listen: false)
                        .fetchStockAuditsList("Fuel");
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: stockAuditsTypeListFuel.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 55.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: AppColors.meruWhite,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(Icons.abc_rounded),
                            Text(
                              '${stockAuditsTypeListFuel[index]['productshortcode']}',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: AppColors.meruBlack,
                                fontSize: 13.0,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  if (stockAuditsTypeListFuel[index]
                                          ['productshortcode'] ==
                                      'PMS') {
                                    Navigator.pushNamed(
                                        context, Routenames.productPMS);
                                  }
                                  if (stockAuditsTypeListFuel[index]
                                          ['productshortcode'] ==
                                      'LSD') {
                                    Navigator.pushNamed(
                                        context, Routenames.productLSD);
                                  }
                                  if (stockAuditsTypeListFuel[index]
                                          ['productshortcode'] ==
                                      'DK') {
                                    Navigator.pushNamed(
                                        context, Routenames.productDK);
                                  }
                                },
                                child: const Icon(Icons.chevron_right)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ), // Fuel
              SingleChildScrollView(
                child: Form(
                  key: _formKeyLube,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                        child: LinearProgressIndicator(
                          value: (_currentStep + 1) / 4,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.meruYellow),
                          minHeight: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Station Name",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${stockAuditsHeaderDetails['stationname']}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Station Code",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${stockAuditsHeaderDetails['stationcode']}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Station Type",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${stockAuditsHeaderDetails['stationtype']}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "SM Name",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${stockAuditsHeaderDetails['smname']}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /*Text("RH Code",style: _headerValueTextStyle,),
                                  Text(
                                    "${stockAuditsHeaderDetails['id']}",
                                  ),*/
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "CM Name",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${stockAuditsHeaderDetails['cmname']}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Auditor Name",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${stockAuditsHeaderDetails['auditorname']}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Audit Start Time",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${DateFormat('dd-MM-yyy\nkk:mm:ss').format(DateTime.now())}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Audit End Time",
                                    style: _headerValueTextStyle,
                                  ),
                                  const Text(
                                    "-",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TapToExpand(
                          backgroundcolor: AppColors.meruWhite,
                          iconSize: 18.0,
                          titlePadding: EdgeInsets.all(10.0),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          iconColor: AppColors.meruBlack,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                  color: AppColors.meruYellow,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '1',
                                  style: _expandHeaderTextStyle,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 1.0),
                                width: MediaQuery.of(context).size.width * .55,
                                child: Text(
                                  'Stocks Reconciliation(All Figures in ltrs)',
                                  style: _expandHeaderTextStyle,
                                ),
                              ),
                            ],
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
                                height: 5.0,
                              ),
                              ...buildEachProductTapToExpandSectionLube(
                                  ((lubeProductsTextControllers ?? {}) as Map),
                                  ((stockAuditsTypeListLube ?? []))),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 2.0),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 1.0),
                                child: const Text(
                                  "If +ve or -ve variations not within permissible limits, Please provide analysis and action taken in bellow.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "Lubes Hygiene Checklist",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Is online DSR is updated daily (check online register)?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _oneTextControllerLU.text,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                    ),
                                    onChanged: (String? newValue) {
                                      _oneTextControllerLU.text = newValue!;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value == 'Select') {
                                        return 'Lube Checklist Answer';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: ['Select', 'Yes', 'No']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    child: TextFormField(
                                      controller: _twoTextControllerLU,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5.0,
                                          vertical: 11.0,
                                        ),
                                        hintText: 'Remark',
                                        isDense: true,
                                      ),
                                      style: const TextStyle(fontSize: 12.0),
                                      /*validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LUBE Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },*/
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Is Stock & Sales Matched in the Online DSR?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _threeTextControllerLU.text,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                    ),
                                    onChanged: (String? newValue) {
                                      _threeTextControllerLU.text = newValue!;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value == 'Select') {
                                        return 'Lube Checklist Answer';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: ['Select', 'Yes', 'No']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    child: TextFormField(
                                      controller: _fourTextControllerLU,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 11.0),
                                        hintText: 'Remark',
                                        isDense: true,
                                      ),
                                      style: const TextStyle(fontSize: 12.0),
                                      /*validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LUBE Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },*/
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Is Lubes display stand is clean & well Branded?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.33,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _fiveTextControllerLU.text,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                    ),
                                    onChanged: (String? newValue) {
                                      _fiveTextControllerLU.text = newValue!;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value == 'Select') {
                                        return 'Lube Checklist Answer';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: ['Select', 'Yes', 'No']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style:
                                              const TextStyle(fontSize: 12.0),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    child: TextFormField(
                                      controller: _sixTextControllerLU,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 10.0),
                                        hintText: 'Remark',
                                        isDense: true,
                                      ),
                                      style: TextStyle(fontSize: 12.0),
                                      /*validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LUBE Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },*/
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Is updated price board is displayed at forecourt?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.33,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _sevenTextControllerLU.text,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                    ),
                                    onChanged: (String? newValue) {
                                      _sevenTextControllerLU.text = newValue!;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value == 'Select') {
                                        return 'Lube Checklist Answer';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: ['Select', 'Yes', 'No']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    child: TextFormField(
                                      controller: _eightTextControllerLU,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 10.0),
                                          hintText: 'Remark',
                                          isDense: true),
                                      style: TextStyle(fontSize: 12.0),
                                      /* validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LUBE Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },*/
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Is station well stocked with all SKU of Lubes ?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.33,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _nineTextControllerLU.text,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                    ),
                                    onChanged: (String? newValue) {
                                      _nineTextControllerLU.text = newValue!;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value == 'Select') {
                                        return 'Lube Checklist Answer';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: ['Select', 'Yes', 'No']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    child: TextFormField(
                                      controller: _tenTextControllerLU,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 10.0),
                                          hintText: 'Remark',
                                          isDense: true),
                                      style: TextStyle(fontSize: 12.0),
                                      /* validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LUBE Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },*/
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: TextFormField(
                            controller: _elevenTextControllerLU,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                  vertical: 15.0,
                                ),
                                hintText: 'Remarks',
                                isDense: true),
                            style: const TextStyle(fontSize: 12.0),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter LUBE Audit Remarks';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        width: MediaQuery.of(context).size.width * .90,
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              child: Text('Delete'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.meruRed,
                                // background
                                foregroundColor: Colors.white,
                                // foreground
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(width: 10.0),
                            ElevatedButton(
                              child: Text('Save'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.meruRed,
                                // background
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: TweenAnimationBuilder<Color?>(
                                        tween: ColorTween(
                                            begin: Colors.red,
                                            end: Colors.yellow),
                                        duration: Duration(seconds: 1),
                                        builder: (context, color, _) {
                                          return CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    color!),
                                          );
                                        },
                                        onEnd: () {
                                          // No need to do anything here
                                        },
                                      ),
                                    );
                                  },
                                );
                                Future.delayed(Duration(seconds: 2), () async {
                                  if (_formKeyLube.currentState!.validate()) {
                                    var lube_list = [];
                                    var list_lube = Provider.of<AuditProvider>(
                                            context,
                                            listen: false)
                                        .lubeProductsTextControllers;

                                    list_lube.forEach((i, eachData) {
                                      lube_list.add({
                                        "id": "$i",
                                        "category": "LUBE",
                                        "productName":
                                            "${eachData['product_name']}",
                                        "productShortCode":
                                            "${eachData['product_shortCode']}",
                                        "productUOM": "LTRS",
                                        "productPrice":
                                            "${eachData['productPrice']}",
                                        "previousClosedReading": "00.00",
                                        "openingStock":
                                            "${eachData['textControllers'][0].text}",
                                        "closingStock":
                                            "${eachData['textControllers'][5].text}",
                                        "bookingStock":
                                            "${eachData['textControllers'][4].text}",
                                        "recipient":
                                            "${eachData['textControllers'][1].text}",
                                        "returns":
                                            "${eachData['textControllers'][2].text}",
                                        "totalSales":
                                            "${eachData['textControllers'][3].text}",
                                        "diff":
                                            "${eachData['textControllers'][6].text}",
                                        "remark":
                                            "${eachData['textControllers'][7].text}",
                                      });
                                    });

                                    final SharedPreferenceHelper _sharedPrefs =
                                        SharedPreferenceHelper();
                                    String? auditId = await _sharedPrefs
                                        .getString(ConstantStrings
                                            .selectedStockAuditID);

                                    var payload = {
                                      "productCategory": "LUBE",
                                      "auditId": "$auditId",
                                      "stationCode":
                                          "${stockAuditsHeaderDetails['stationcode']}",
                                      "totalizerTotal": "00.00",
                                      "ustTotal": "00.00",
                                      "overallRemarks":
                                          "${_elevenTextControllerLU.text}",
                                      "LUBE": lube_list,
                                      "LPG": [],
                                      "hygieneChecklists": [
                                        {
                                          "question": "LUBE_QUESTION_1", //
                                          "answer":
                                              "${_oneTextControllerLU.text}",
                                          "remark":
                                              "${_twoTextControllerLU.text}"
                                        },
                                        {
                                          "question": "LUBE_QUESTION_1",
                                          "answer":
                                              "${_threeTextControllerLU.text}",
                                          "remark":
                                              "${_fourTextControllerLU.text}"
                                        },
                                        {
                                          "question": "LUBE_QUESTION_3",
                                          "answer":
                                              "${_fiveTextControllerLU.text}",
                                          "remark":
                                              "${_sixTextControllerLU.text}"
                                        },
                                        {
                                          "question": "LUBE_QUESTION_4",
                                          "answer":
                                              "${_sevenTextControllerLU.text}",
                                          "remark":
                                              "${_eightTextControllerLU.text}"
                                        },
                                        {
                                          "question": "LUBE_QUESTION_5",
                                          "answer":
                                              "${_nineTextControllerLU.text}",
                                          "remark":
                                              "${_tenTextControllerLU.text}"
                                        },
                                      ]
                                    };

                                    var result =
                                        await Provider.of<AuditProvider>(
                                                context,
                                                listen: false)
                                            .saveStockAuditData(
                                                stockAuditData: payload);

                                    Navigator.of(context)
                                        .pop(); // Close the CircularProgressIndicator dialog

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          Future.delayed(Duration(seconds: 3),
                                              () {
                                            Provider.of<AuditProvider>(context,
                                                    listen: false)
                                                .fetchStockAuditsList("Fuel");
                                            Navigator.of(context).pop(true);
                                          });
                                          return AlertDialog(
                                            title: Text("Info"),
                                            content: Text("$result"),
                                          );
                                        });
                                  } else {
                                    Navigator.of(context)
                                        .pop(); // Close the CircularProgressIndicator dialog
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          Future.delayed(Duration(seconds: 3),
                                              () {
                                            Provider.of<AuditProvider>(context,
                                                    listen: false)
                                                .fetchStockAuditsList("Fuel");
                                            Navigator.of(context).pop(true);
                                          });
                                          return AlertDialog(
                                            title: Text("Warning"),
                                            content: Text(
                                                "Please fill all the LUBE Audit fields"),
                                          );
                                        });
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ), // Lube
              SingleChildScrollView(
                child: Form(
                  key: _formKeyLpg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                        child: LinearProgressIndicator(
                          value: (_currentStep + 1) / 4,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.meruYellow),
                          minHeight: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Station Name",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${stockAuditsHeaderDetails['stationname']}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Station Code",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${stockAuditsHeaderDetails['stationcode']}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Station Type",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${stockAuditsHeaderDetails['stationtype']}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "SM Name",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${stockAuditsHeaderDetails['smname']}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /*Text("RH Code",style: _headerValueTextStyle,),
                                  Text(
                                    "${stockAuditsHeaderDetails['id']}",
                                  ),*/
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "CM Name",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${stockAuditsHeaderDetails['cmname']}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Auditor Name",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${stockAuditsHeaderDetails['auditorname']}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Audit Start Time",
                                    style: _headerValueTextStyle,
                                  ),
                                  Text(
                                    "${DateFormat('dd-MM-yyy\nkk:mm:ss').format(DateTime.now())}",
                                    style: _headerTextStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Audit End Time",
                                    style: _headerValueTextStyle,
                                  ),
                                  const Text(
                                    "-",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TapToExpand(
                          backgroundcolor: AppColors.meruWhite,
                          iconColor: AppColors.meruBlack,
                          iconSize: 18.0,
                          titlePadding: const EdgeInsets.all(10.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                  color: AppColors.meruYellow,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '1',
                                  style: _expandHeaderTextStyle,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                width: MediaQuery.of(context).size.width * .55,
                                child: Text(
                                  'Stocks Reconciliation (All Figures in ltrs)',
                                  style: _expandHeaderTextStyle,
                                ),
                              ),
                            ],
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
                                height: 5.0,
                              ),
                              ...buildEachProductTapToExpandSectionLpg(
                                  (lpgProductsTextControllers ?? {}),
                                  (stockAuditsTypeListLpg ?? [])),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 2.0,
                                ),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 1.0),
                                child: const Text(
                                  "If +ve or -ve variations not within permissible limits, Please provide analysis and action taken in bellow.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "LPGs Hygiene Checklist",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Is online DSR is updated daily (check online register)?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _oneTextControllerLP.text,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                    ),
                                    onChanged: (String? newValue) {
                                      _oneTextControllerLP.text = newValue!;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value == 'Select') {
                                        return 'LPG Checklist Answer';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: ['Select', 'Yes', 'No']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    child: TextFormField(
                                      controller: _twoTextControllerLP,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 11.0),
                                        hintText: 'Remark',
                                        isDense: true,
                                      ),
                                      style: const TextStyle(fontSize: 12.0),
                                      /*validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LPG Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },*/
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Is Stock & Sales Matched in the Online DSR?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _threeTextControllerLP.text,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                    ),
                                    onChanged: (String? newValue) {
                                      _threeTextControllerLP.text = newValue!;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value == 'Select') {
                                        return 'LPG Checklist Answer';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: ['Select', 'Yes', 'No']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    child: TextFormField(
                                      controller: _fourTextControllerLP,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 11.0),
                                        hintText: 'Remark',
                                        isDense: true,
                                      ),
                                      style: const TextStyle(fontSize: 12.0),
                                      /*validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LPG Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },*/
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Is LPG cage is clean & well Branded?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _fiveTextControllerLP.text,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                    ),
                                    onChanged: (String? newValue) {
                                      _fiveTextControllerLP.text = newValue!;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value == 'Select') {
                                        return 'LPG Checklist Answer';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: ['Select', 'Yes', 'No']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    child: TextFormField(
                                      controller: _sixTextControllerLP,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 11.0),
                                        hintText: 'Remark',
                                        isDense: true,
                                      ),
                                      style: const TextStyle(fontSize: 12.0),
                                      /*validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LPG Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },*/
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Is all Sign & Warning boards displayed around the LPG cage?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _sevenTextControllerLP.text,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                    ),
                                    onChanged: (String? newValue) {
                                      _sevenTextControllerLP.text = newValue!;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value == 'Select') {
                                        return 'LPG Checklist Answer';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: ['Select', 'Yes', 'No']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    child: TextFormField(
                                      controller: _eightTextControllerLP,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 11.0),
                                        hintText: 'Remark',
                                        isDense: true,
                                      ),
                                      style: const TextStyle(fontSize: 12.0),
                                      /*validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LPG Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },*/
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Is DCP placed near the cage & Certificate available?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _nineTextControllerLP.text,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                    ),
                                    onChanged: (String? newValue) {
                                      _nineTextControllerLP.text = newValue!;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value == 'Select') {
                                        return 'LPG Checklist Answer';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: ['Select', 'Yes', 'No']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    child: TextFormField(
                                      controller: _tenTextControllerLP,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 11.0),
                                        hintText: 'Remark',
                                        isDense: true,
                                      ),
                                      style: const TextStyle(fontSize: 12.0),
                                      /*validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LPG Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },*/
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Is Station Well stocked with all SKU of LPG?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _elevenTextControllerLP.text,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                    ),
                                    onChanged: (String? newValue) {
                                      _elevenTextControllerLP.text = newValue!;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value == 'Select') {
                                        return 'LPG Checklist Answer';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: ['Select', 'Yes', 'No']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    child: TextFormField(
                                      controller: _twelveTextControllerLP,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 11.0),
                                        hintText: 'Remark',
                                        isDense: true,
                                      ),
                                      style: const TextStyle(fontSize: 12.0),
                                      /*validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LPG Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },*/
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: TextFormField(
                            controller: _thirteenTextControllerLP,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                  vertical: 15.0,
                                ),
                                hintText: 'Remarks',
                                isDense: true),
                            style: const TextStyle(fontSize: 12.0),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter LPG Audit Remarks';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        width: MediaQuery.of(context).size.width * .90,
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              child: Text('Delete'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.meruRed,
                                // background
                                foregroundColor: Colors.white,
                                // foreground
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(width: 10.0),
                            ElevatedButton(
                              child: Text('Save'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.meruRed,
                                // background
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: TweenAnimationBuilder<Color?>(
                                        tween: ColorTween(
                                            begin: Colors.red,
                                            end: Colors.yellow),
                                        duration: Duration(seconds: 1),
                                        builder: (context, color, _) {
                                          return CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    color!),
                                          );
                                        },
                                        onEnd: () {
                                          // No need to do anything here
                                        },
                                      ),
                                    );
                                  },
                                );
                                Future.delayed(Duration(seconds: 2), () async {
                                  if (_formKeyLpg.currentState!.validate()) {
                                    var lpg_list = [];

                                    var list_lpg = Provider.of<AuditProvider>(
                                            context,
                                            listen: false)
                                        .lpgProductsTextControllers;

                                    list_lpg.forEach((i, eachData) {
                                      lpg_list.add({
                                        "id": "$i",
                                        "category": "LPG",
                                        "productName":
                                            "${eachData['product_name']}",
                                        "productShortCode":
                                            "${eachData['product_shortCode']}",
                                        "productUOM": "LTRS",
                                        "productPrice":
                                            "${eachData['productPrice']}",
                                        "previousClosedReading": "00.00",
                                        "openingStock":
                                            "${eachData['textControllers'][0].text}",
                                        "closingStock":
                                            "${eachData['textControllers'][5].text}",
                                        "bookingStock":
                                            "${eachData['textControllers'][4].text}",
                                        "recipient":
                                            "${eachData['textControllers'][1].text}",
                                        "returns":
                                            "${eachData['textControllers'][2].text}",
                                        "totalSales":
                                            "${eachData['textControllers'][3].text}",
                                        "diff":
                                            "${eachData['textControllers'][6].text}",
                                        "remark":
                                            "${eachData['textControllers'][7].text}",
                                      });
                                    });

                                    final SharedPreferenceHelper _sharedPrefs =
                                        SharedPreferenceHelper();
                                    String? auditId = await _sharedPrefs
                                        .getString(ConstantStrings
                                            .selectedStockAuditID);

                                    var payload = {
                                      "productCategory": "LPG",
                                      "auditId": "$auditId",
                                      "stationCode":
                                          "${stockAuditsHeaderDetails['stationcode']}",
                                      "totalizerTotal": "00.00",
                                      "ustTotal": "00.00",
                                      "overallRemarks":
                                          "${_thirteenTextControllerLP.text}",
                                      "LUBE": [],
                                      "LPG": lpg_list,
                                      "hygieneChecklists": [
                                        {
                                          "question": "LPG_QUESTION_1", //
                                          "answer":
                                              "${_oneTextControllerLP.text}",
                                          "remark":
                                              "${_twoTextControllerLP.text}"
                                        },
                                        {
                                          "question": "LPG_QUESTION_2",
                                          "answer":
                                              "${_threeTextControllerLP.text}",
                                          "remark":
                                              "${_fourTextControllerLP.text}"
                                        },
                                        {
                                          "question": "LPG_QUESTION_3",
                                          "answer":
                                              "${_fiveTextControllerLP.text}",
                                          "remark":
                                              "${_sixTextControllerLP.text}"
                                        },
                                        {
                                          "question": "LPG_QUESTION_4",
                                          "answer":
                                              "${_sevenTextControllerLP.text}",
                                          "remark":
                                              "${_eightTextControllerLP.text}"
                                        },
                                        {
                                          "question": "LPG_QUESTION_5",
                                          "answer":
                                              "${_nineTextControllerLP.text}",
                                          "remark":
                                              "${_tenTextControllerLP.text}"
                                        },
                                        {
                                          "question": "LPG_QUESTION_6",
                                          "answer":
                                              "${_elevenTextControllerLP.text}",
                                          "remark":
                                              "${_twelveTextControllerLP.text}"
                                        },
                                      ]
                                    };

                                    // print("payload:   $payload");

                                    var result =
                                        await Provider.of<AuditProvider>(
                                                context,
                                                listen: false)
                                            .saveStockAuditData(
                                                stockAuditData: payload);

                                    Navigator.of(context)
                                        .pop(); // Close the CircularProgressIndicator dialog

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          Future.delayed(Duration(seconds: 3),
                                              () {
                                            Provider.of<AuditProvider>(context,
                                                    listen: false)
                                                .fetchStockAuditsList("Fuel");
                                            Navigator.of(context).pop(true);
                                          });
                                          return AlertDialog(
                                            title: Text("Info"),
                                            content: Text("$result"),
                                          );
                                        });
                                  } else {
                                    Navigator.of(context)
                                        .pop(); // Close the CircularProgressIndicator dialog
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          Future.delayed(Duration(seconds: 3),
                                              () {
                                            Provider.of<AuditProvider>(context,
                                                    listen: false)
                                                .fetchStockAuditsList("Fuel");
                                            Navigator.of(context).pop(true);
                                          });
                                          return AlertDialog(
                                            title: Text("Warning"),
                                            content: Text(
                                                "Please fill all the LPG Audit fields"),
                                          );
                                        });
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ), // LPG
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: _isSubmitToStationVisible,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text('Submit to Station'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isStockAuditCompleted == 'Yes'
                          ? AppColors.meruRed
                          : AppColors.meruRed.withOpacity(0.3),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    onPressed: () async {
                      if (isStockAuditCompleted == 'Yes') {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(
                              child: TweenAnimationBuilder<Color?>(
                                tween: ColorTween(
                                    begin: Colors.red, end: Colors.yellow),
                                duration: Duration(seconds: 1),
                                builder: (context, color, _) {
                                  return CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(color!),
                                  );
                                },
                                onEnd: () {
                                  // No need to do anything here
                                },
                              ),
                            );
                          },
                        );
                        Future.delayed(Duration(seconds: 2), () async {
                          final SharedPreferenceHelper _sharedPrefs =
                              SharedPreferenceHelper();
                          String? auditId = await _sharedPrefs
                              .getString(ConstantStrings.selectedStockAuditID);
                          var result = await Provider.of<AuditProvider>(context,
                                  listen: false)
                              .stock_audit_submit_to_station(auditId: auditId);
                          Navigator.of(context)
                              .pop(); // Close the CircularProgressIndicator dialog
                          showDialog(
                              context: context,
                              builder: (context) {
                                Future.delayed(Duration(seconds: 3), () {
                                  Provider.of<AuditProvider>(context,
                                          listen: false)
                                      .fetchStockAuditsList("Fuel");
                                  Navigator.of(context).pop(true);
                                });
                                return AlertDialog(
                                  title: Text("Info"),
                                  content: Text("$result"),
                                );
                              });
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    '* Please complete Fuel, Lube & LPG audits for "Submit to Station"',
                    style:
                        TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildEachProductTapToExpandSectionLube(
      Map lubeProductsTextControllers, List<Map> productList) {
    print("***************  $lubeProductsTextControllers");

    if (productList.length > 0 && !lubeProductsTextControllers.isEmpty) {
      return [
        ...productList.map((eachProduct) => buildProductTapToExpandSectionLube(
            lubeProductsTextControllers, eachProduct))
      ];
    } else {
      return [
        const SizedBox(
          height: 30.0,
          child: Center(
            child: Text(
              "Products not available",
              style: TextStyle(
                  color: AppColors.meruRed, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ];
    }
  }

  Widget buildProductTapToExpandSectionLube(
      Map lubeProductsTextControllers, Map eachProduct) {
    calculate_product() {
      var f_o = lubeProductsTextControllers['${eachProduct['id']}']
              ["textControllers"][0]
          .text;
      var f_t = lubeProductsTextControllers['${eachProduct['id']}']
              ["textControllers"][1]
          .text;
      var f_th = lubeProductsTextControllers['${eachProduct['id']}']
              ["textControllers"][2]
          .text;
      var f_fo = lubeProductsTextControllers['${eachProduct['id']}']
              ["textControllers"][3]
          .text;
      var f_si = lubeProductsTextControllers['${eachProduct['id']}']
              ["textControllers"][5]
          .text;

      var f_o_d = f_o == '' ? 0.0 : double.parse(f_o); // opening stock
      var f_t_d = f_t == '' ? 0.0 : double.parse(f_t); // recipient
      var f_th_d = f_th == '' ? 0.0 : double.parse(f_th); // returns
      var f_fo_d = f_fo == '' ? 0.0 : double.parse(f_fo); // total sales
      var f_si_d = f_si == '' ? 0.0 : double.parse(f_si); // closing stocks

      lubeProductsTextControllers['${eachProduct['id']}']["textControllers"][4]
          .text = '${((f_o_d + f_t_d + f_th_d) - f_fo_d)}';
      lubeProductsTextControllers['${eachProduct['id']}']["textControllers"][6]
          .text = '${(f_si_d - ((f_o_d + f_t_d + f_th_d) - f_fo_d))}';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TapToExpand(
        backgroundcolor: AppColors.meruWhite,
        iconColor: AppColors.meruBlack,
        iconSize: 18.0,
        titlePadding: const EdgeInsets.all(15.0),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        title: Container(
          width: MediaQuery.of(context).size.width * .52,
          child: Text(
            '${eachProduct['productname']}',
            textAlign: TextAlign.start,
            style: _expandHeaderTextStyle,
          ),
        ),
        content: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text("Opening Stock"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][0],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Opening Stock',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },*/
                          onChanged: (val) {
                            calculate_product();
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text("Receipts"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][1],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Receipts',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            calculate_product();
                          },
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text("Returns"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][2],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Returns',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            calculate_product();
                          },
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text("Total Sales"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][3],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Total Sales',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            calculate_product();
                          },
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text("Book Stocks"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][4],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Book Stocks',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            calculate_product();
                          },
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text('Closing Stocks'),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][5],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Closing Stocks',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            calculate_product();
                          },
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text("Diff"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][6],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Diff',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            calculate_product();
                          },
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text("Remarks"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][7],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Remarks',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          textAlign: TextAlign.center,
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildEachProductTapToExpandSectionLpg(
      Map lpgeProductsTextControllers, List<Map> productList) {
    if (productList.length > 0 && lpgeProductsTextControllers.isNotEmpty) {
      return [
        ...productList.map((eachProduct) => buildProductTapToExpandSectionLpg(
            lpgeProductsTextControllers, eachProduct))
      ];
    } else {
      return [
        const SizedBox(
          height: 30.0,
          child: Center(
            child: Text(
              "Products not available",
              style: TextStyle(
                  color: AppColors.meruRed, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ];
    }
  }

  Widget buildProductTapToExpandSectionLpg(
      Map lpgProductsTextControllers, Map eachProduct) {
    calculate_product() {
      var f_o = lpgProductsTextControllers['${eachProduct['id']}']
              ["textControllers"][0]
          .text;
      var f_t = lpgProductsTextControllers['${eachProduct['id']}']
              ["textControllers"][1]
          .text;
      var f_th = lpgProductsTextControllers['${eachProduct['id']}']
              ["textControllers"][2]
          .text;
      var f_fo = lpgProductsTextControllers['${eachProduct['id']}']
              ["textControllers"][3]
          .text;
      var f_si = lpgProductsTextControllers['${eachProduct['id']}']
              ["textControllers"][5]
          .text;

      var f_o_d = f_o == '' ? 0.0 : double.parse(f_o); // opening stock
      var f_t_d = f_t == '' ? 0.0 : double.parse(f_t); // recipient
      var f_th_d = f_th == '' ? 0.0 : double.parse(f_th); // returns
      var f_fo_d = f_fo == '' ? 0.0 : double.parse(f_fo); // total sales
      var f_si_d = f_si == '' ? 0.0 : double.parse(f_si); // closing stocks

      lpgProductsTextControllers['${eachProduct['id']}']["textControllers"][4]
          .text = '${((f_o_d + f_t_d + f_th_d) - f_fo_d)}';
      lpgProductsTextControllers['${eachProduct['id']}']["textControllers"][6]
          .text = '${(f_si_d - ((f_o_d + f_t_d + f_th_d) - f_fo_d))}';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TapToExpand(
        backgroundcolor: AppColors.meruWhite,
        iconColor: AppColors.meruBlack,
        iconSize: 18.0,
        titlePadding: const EdgeInsets.all(15.0),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        title: Container(
          width: MediaQuery.of(context).size.width * .52,
          child: Text(
            '${eachProduct['productname']}',
            textAlign: TextAlign.start,
            style: _expandHeaderTextStyle,
          ),
        ),
        content: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text("Opening Stock"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][0],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Opening Stock',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            calculate_product();
                          },
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text("Receipts"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][1],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Receipts',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            calculate_product();
                          },
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text("Returns"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][2],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Returns',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            calculate_product();
                          },
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text("Total Sales"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][3],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Total Sales',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            calculate_product();
                          },
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text("Book Stocks"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][4],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 10.0),
                            hintText: 'Book Stocks',
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            calculate_product();
                          },
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .32,
                    child: Column(
                      children: [
                        const Text('Closing Stocks'),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][5],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Closing Stocks',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            calculate_product();
                          },
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .32,
                    child: Column(
                      children: [
                        const Text("Diff"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][6],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Diff',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            calculate_product();
                          },
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .32,
                    child: Column(
                      children: [
                        const Text("Remarks"),
                        const SizedBox(
                          height: 3.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][7],
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Remarks',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          /*validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },*/
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
