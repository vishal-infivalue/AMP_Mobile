import 'package:amp/providers_vm/audit_provider.dart';
import 'package:amp/utils/app_colors.dart';
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

  TextEditingController _nineTextControllerLU = TextEditingController();

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

  TextEditingController _nineTextControllerLP = TextEditingController();

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
      Provider.of<AuditProvider>(context).fetchStockAuditsHeaderDetails(
          ""); // Hard coded in api calling function. Need to bring it from Shared Preference.
      Provider.of<AuditProvider>(context)
          .fetchStockAuditsNozzelsUSTDetails(auditId: '', type: 'DK');
      Provider.of<AuditProvider>(context).fetchStockAuditsLubeLPGDetails(
          auditId: '',
          type:
              'LUBE'); // Hard coded in api calling function. Need to bring it from Shared Preference.
      Provider.of<AuditProvider>(context).fetchStockAuditsLubeLPGDetails(
          auditId: '',
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
          'Stock Audit',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: AppColors.meruRed,
            fontSize: 15.0,
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
                  fontSize: 15.0,
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
                  fontSize: 15.0,
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
                  fontSize: 15.0,
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
                              fontWeight: FontWeight.bold,
                              color: AppColors.meruBlack,
                              fontSize: 15.0,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Station Name"),
                                  Text(
                                    "${stockAuditsHeaderDetails['stationname']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Station Code"),
                                  Text(
                                    "${stockAuditsHeaderDetails['stationcode']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Station Type"),
                                  Text(
                                    "${stockAuditsHeaderDetails['stationtype']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("SM Name"),
                                  Text(
                                    "${stockAuditsHeaderDetails['smname']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("RH Code"),
                                  Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("CM Name"),
                                  Text(
                                    "${stockAuditsHeaderDetails['cmname']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Auditor Name"),
                                  Text(
                                    "${stockAuditsHeaderDetails['auditorname']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Audit Start Time"),
                                  Text(
                                    "${DateFormat('dd-MM-yyy\nkk:mm:ss').format(DateTime.now())}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Audit End Time"),
                                  Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                  color: AppColors.meruYellow,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.all(13.0),
                                child: const Text(
                                  '1',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                width: MediaQuery.of(context).size.width * .50,
                                child: const Text(
                                  'Stock Reconciliation\n(All Figures in ltrs)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.meruBlack,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                  lubeProductsTextControllers,
                                  stockAuditsTypeListLube),
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
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 15.0,
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
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 15.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 15.0,
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
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
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
                                              horizontal: 10.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
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
                                        child: Text(value),
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
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 1.0),
                                        hintText: 'Remark',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LUBE Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },
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
                          horizontal: 15.0,
                          vertical: 15.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 15.0,
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
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
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
                                              horizontal: 10.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
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
                                        child: Text(value),
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
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 1.0),
                                        hintText: 'Remark',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LUBE Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },
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
                          horizontal: 15.0,
                          vertical: 15.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 15.0,
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
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
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
                                    value: _fiveTextControllerLU.text,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
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
                                        child: Text(value),
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
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 1.0),
                                        hintText: 'Remark',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LUBE Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },
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
                          horizontal: 15.0,
                          vertical: 15.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 15.0,
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
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
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
                                    value: _sevenTextControllerLU.text,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
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
                                        child: Text(value),
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
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 1.0),
                                        hintText: 'Remark',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LUBE Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 18.0),
                        child: TextFormField(
                          controller: _nineTextControllerLU,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Remarks',
                            hintText: 'Remarks',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter LUBE Audit Remarks';
                            } else {
                              return null;
                            }
                          },
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

                                  var payload = {
                                    "productCategory": "LUBE",
                                    "auditId": 3108202401,
                                    "stationCode":
                                        "${stockAuditsHeaderDetails['stationcode']}",
                                    "totalizerTotal": "00.00",
                                    "ustTotal": "00.00",
                                    "overallRemarks":
                                        "${_nineTextControllerLU.text}",
                                    "LUBE": lube_list,
                                    "LPG": [],
                                    "hygieneChecklists": [
                                      {
                                        "question": "1", //
                                        "answer":
                                            "${_oneTextControllerLU.text}",
                                        "remark": "${_twoTextControllerLU.text}"
                                      },
                                      {
                                        "question": "2",
                                        "answer":
                                            "${_threeTextControllerLU.text}",
                                        "remark":
                                            "${_fourTextControllerLU.text}"
                                      },
                                      {
                                        "question": "3",
                                        "answer":
                                            "${_fiveTextControllerLU.text}",
                                        "remark": "${_sixTextControllerLU.text}"
                                      },
                                      {
                                        "question": "4",
                                        "answer":
                                            "${_sevenTextControllerLU.text}",
                                        "remark":
                                            "${_eightTextControllerLU.text}"
                                      },
                                    ]
                                  };
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showMaterialBanner(
                                    MaterialBanner(
                                      content: const Text(
                                          'Please fill all the LUBE Audit fields'),
                                      actions: [
                                        TextButton(
                                          child: const Text('Close'),
                                          onPressed: () =>
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentMaterialBanner(),
                                        ),
                                      ],
                                    ),
                                  );
                                }
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Station Name"),
                                  Text(
                                    "${stockAuditsHeaderDetails['stationname']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Station Code"),
                                  Text(
                                    "${stockAuditsHeaderDetails['stationcode']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Station Type"),
                                  Text(
                                    "${stockAuditsHeaderDetails['stationtype']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("SM Name"),
                                  Text(
                                    "${stockAuditsHeaderDetails['smname']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("RH Code"),
                                  Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("CM Name"),
                                  Text(
                                    "${stockAuditsHeaderDetails['cmname']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Auditor Name"),
                                  Text(
                                    "${stockAuditsHeaderDetails['auditorname']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Audit Start Time"),
                                  Text(
                                    "${DateFormat('dd-MM-yyy\nkk:mm:ss').format(DateTime.now())}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Audit End Time"),
                                  Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                  color: AppColors.meruYellow,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.all(13.0),
                                child: const Text(
                                  '1',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                width: MediaQuery.of(context).size.width * .50,
                                child: const Text(
                                  'Stock Reconciliation\n(All Figures in ltrs)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.meruBlack,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                  lpgProductsTextControllers,
                                  stockAuditsTypeListLpg),
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
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 15.0,
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
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 15.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 15.0,
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
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
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
                                              horizontal: 10.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
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
                                        child: Text(value),
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
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5.0,
                                          vertical: 1.0,
                                        ),
                                        hintText: 'Remark',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LPG Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },
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
                          horizontal: 15.0,
                          vertical: 15.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 15.0,
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
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
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
                                              horizontal: 10.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
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
                                        child: Text(value),
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
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 1.0),
                                        hintText: 'Remark',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LPG Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },
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
                          horizontal: 15.0,
                          vertical: 15.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 15.0,
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
                              "Is LPGs display stand is clean & well Branded?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
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
                                              horizontal: 10.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
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
                                        child: Text(value),
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
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 1.0),
                                        hintText: 'Remark',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LPG Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },
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
                          horizontal: 15.0,
                          vertical: 15.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 15.0,
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
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
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
                                              horizontal: 10.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
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
                                        child: Text(value),
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
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 1.0),
                                        hintText: 'Remark',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter LPG Checklist Remark';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 18.0),
                        child: TextFormField(
                          controller: _nineTextControllerLP,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Remarks',
                            hintText: 'Remarks',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter LPG Audit Remarks';
                            } else {
                              return null;
                            }
                          },
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

                                  var payload = {
                                    "productCategory": "LPG",
                                    "auditId": 3108202401,
                                    "stationCode":
                                        "${stockAuditsHeaderDetails['stationcode']}",
                                    "totalizerTotal": "00.00",
                                    "ustTotal": "00.00",
                                    "overallRemarks":
                                        "${_nineTextControllerLP.text}",
                                    "LUBE": [],
                                    "LPG": lpg_list,
                                    "hygieneChecklists": [
                                      {
                                        "question": "1", //
                                        "answer":
                                            "${_oneTextControllerLP.text}",
                                        "remark": "${_twoTextControllerLP.text}"
                                      },
                                      {
                                        "question": "2",
                                        "answer":
                                            "${_threeTextControllerLP.text}",
                                        "remark":
                                            "${_fourTextControllerLP.text}"
                                      },
                                      {
                                        "question": "3",
                                        "answer":
                                            "${_fiveTextControllerLP.text}",
                                        "remark": "${_sixTextControllerLP.text}"
                                      },
                                      {
                                        "question": "4",
                                        "answer":
                                            "${_sevenTextControllerLP.text}",
                                        "remark":
                                            "${_eightTextControllerLP.text}"
                                      },
                                    ]
                                  };

                                  print("payload:   $payload");

                                  /*var result = await Provider.of<AuditProvider>(
                                        context,
                                        listen: false)
                                    .saveStockAuditData(stockAuditData: payload);*/
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showMaterialBanner(
                                    MaterialBanner(
                                      content: const Text(
                                          'Please fill all the LPG Audit fields'),
                                      actions: [
                                        TextButton(
                                          child: const Text('Close'),
                                          onPressed: () =>
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentMaterialBanner(),
                                        ),
                                      ],
                                    ),
                                  );
                                }
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
                        var auditId =
                            "3108202401"; // Need to fetch from shared preference
                        var result = await Provider.of<AuditProvider>(context,
                                listen: false)
                            .stock_audit_submit_to_station(auditId: auditId);
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
    if (productList.length > 0) {
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
      padding: const EdgeInsets.only(bottom: 6.0),
      child: TapToExpand(
        backgroundcolor: AppColors.meruWhite,
        iconColor: AppColors.meruBlack,
        title: Flexible(
          child: Text(
            '${eachProduct['productname']}',
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: AppColors.meruBlack,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
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
                    width: MediaQuery.sizeOf(context).width * .32,
                    child: Column(
                      children: [
                        const Text("Opening Stock"),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][0],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Opening Stock',
                          ),
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },
                          onChanged: (val) {
                            calculate_product();
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .32,
                    child: Column(
                      children: [
                        const Text("Recipient"),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][1],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Recipient',
                          ),
                          onChanged: (val) {
                            calculate_product();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },
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
                    width: MediaQuery.sizeOf(context).width * .32,
                    child: Column(
                      children: [
                        const Text("Returns"),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][2],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Returns',
                          ),
                          onChanged: (val) {
                            calculate_product();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .32,
                    child: Column(
                      children: [
                        const Text("Total Sales"),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][3],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Total Sales',
                          ),
                          onChanged: (val) {
                            calculate_product();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },
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
                    width: MediaQuery.sizeOf(context).width * .32,
                    child: Column(
                      children: [
                        const Text("Booking Stocks"),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][4],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Booking Stocks',
                          ),
                          onChanged: (val) {
                            calculate_product();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },
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
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][5],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Closing Stocks',
                          ),
                          onChanged: (val) {
                            calculate_product();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },
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
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][6],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Diff',
                          ),
                          onChanged: (val) {
                            calculate_product();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },
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
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: lubeProductsTextControllers[
                              '${eachProduct['id']}']["textControllers"][7],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Remarks',
                          ),
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Lube data required';
                            }
                          },
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
    if (productList.length > 0) {
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
      padding: const EdgeInsets.only(bottom: 6.0),
      child: TapToExpand(
        backgroundcolor: AppColors.meruWhite,
        iconColor: AppColors.meruBlack,
        title: Flexible(
          child: Text(
            '${eachProduct['productname']}',
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: AppColors.meruBlack,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
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
                    width: MediaQuery.sizeOf(context).width * .32,
                    child: Column(
                      children: [
                        const Text("Opening Stock"),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][0],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Opening Stock',
                          ),
                          onChanged: (val) {
                            calculate_product();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .32,
                    child: Column(
                      children: [
                        const Text("Recipient"),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][1],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Recipient',
                          ),
                          onChanged: (val) {
                            calculate_product();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },
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
                    width: MediaQuery.sizeOf(context).width * .32,
                    child: Column(
                      children: [
                        const Text("Returns"),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][2],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Returns',
                          ),
                          onChanged: (val) {
                            calculate_product();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .32,
                    child: Column(
                      children: [
                        const Text("Total Sales"),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][3],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Total Sales',
                          ),
                          onChanged: (val) {
                            calculate_product();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },
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
                    width: MediaQuery.sizeOf(context).width * .32,
                    child: Column(
                      children: [
                        const Text("Booking Stocks"),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][4],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Booking Stocks',
                          ),
                          onChanged: (val) {
                            calculate_product();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },
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
                          height: 5.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][5],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Closing Stocks',
                          ),
                          onChanged: (val) {
                            calculate_product();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },
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
                          height: 5.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][6],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Diff',
                          ),
                          onChanged: (val) {
                            calculate_product();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },
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
                          height: 5.0,
                        ),
                        TextFormField(
                          controller:
                              lpgProductsTextControllers['${eachProduct['id']}']
                                  ["textControllers"][7],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.0),
                            hintText: 'Remarks',
                          ),
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'LPG data required';
                            }
                          },
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
