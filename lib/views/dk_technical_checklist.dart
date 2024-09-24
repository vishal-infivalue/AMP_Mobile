import 'package:amp/providers_vm/audit_provider.dart';
import 'package:amp/utils/app_colors.dart';
import 'package:amp/utils/constant_strings.dart';
import 'package:amp/utils/shared_preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tap_to_expand/tap_to_expand.dart';
import 'package:intl/intl.dart';

class DKTechnicalCheckList extends StatefulWidget {
  @override
  _DKTechnicalCheckListState createState() => _DKTechnicalCheckListState();
}

class _DKTechnicalCheckListState extends State<DKTechnicalCheckList> {
  final _formKey = GlobalKey<FormState>();

  bool _init = true;
  int _currentStep = 0;

  TextEditingController nozzleTotalizers = TextEditingController();
  TextEditingController ustTotalizers = TextEditingController();

  TextEditingController grossStockVariation = TextEditingController();
  TextEditingController sumOfRecoverable = TextEditingController();
  TextEditingController netVariation = TextEditingController();
  TextEditingController stockVariation = TextEditingController();
  TextEditingController grossStockVariationS = TextEditingController();
  TextEditingController isNetStockVariationPermissionLimit =
      TextEditingController();

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      Provider.of<AuditProvider>(context).fetchStockAuditsHeaderDetails();
      Provider.of<AuditProvider>(context)
          .fetchStockAuditsNozzelsUSTDetails(type: 'DK');
      _init = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var stockAuditsHeaderDetails = Provider.of<AuditProvider>(context)
        .stockAuditsHeaderDetails; // Audit header details for Fuel->DK
    var stockAuditsFuelDKNozzleUSTDetails = Provider.of<AuditProvider>(context)
        .stockAuditsFuelPMSNozzleUSTDetails; // Fuel->DK re-consilation data
    var nozzelsTextControllers = Provider.of<AuditProvider>(context)
        .nozzelsUstsTextControllers; // Fuel->DK textControllers

    var ustsTextControllers = Provider.of<AuditProvider>(context)
        .ustTextControllers; // Fuel->DK textControllers

    var qnqTextControllers = Provider.of<AuditProvider>(context)
        .ustQnQTextControllers; // Fuel->DK textControllers Q&Q
    var ddrrTextControllers = Provider.of<AuditProvider>(context)
        .ddrrTextControllers; // Fuel->DK textControllers DDRR

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product DK Checklist',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: AppColors.meruRed,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_sharp,
              color: AppColors.meruRed),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
                child: LinearProgressIndicator(
                  value: (_currentStep + 1) / 4,
                  backgroundColor: Colors.grey[200],
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.meruYellow),
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
                        child: Text('Stock Reconciliation(All Figures in ltrs)',
                            style: _expandHeaderTextStyle),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Divider(
                        color: Colors.grey,
                        height: 5.0,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "Sales From Dispensing Units",
                          style: _headerTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ...buildEachNozzleTapToExpandSectionDK(
                          ((nozzelsTextControllers ?? {}) as Map),
                          ((stockAuditsFuelDKNozzleUSTDetails['NOZZLE'] ?? [])
                              as List)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total as per Totaliser",
                              style: _headerTextStyle,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .30,
                              height: 35.0,
                              child: TextFormField(
                                controller: nozzleTotalizers,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  isDense: true,
                                ),
                                style: TextStyle(fontSize: 12.0),
                                onChanged: (val) {
                                  nozzleTotalizers.text = val;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nozzle Totaliser is empty';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "Sales From UST",
                          style: _headerTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ...buildEachUSTTapToExpandSectionDK(
                          ((ustsTextControllers ?? {}) as Map),
                          ((stockAuditsFuelDKNozzleUSTDetails['UST'] ?? [])
                              as List)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total as per UST",
                              style: _headerTextStyle,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .30,
                              height: 35.0,
                              child: TextFormField(
                                controller: ustTotalizers,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  isDense: true,
                                ),
                                style: TextStyle(fontSize: 12.0),
                                onChanged: (val) {
                                  ustTotalizers.text = val;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'UST Totaliser empty';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "DK STOCK VARIATION(Ltrs)",
                          style: _headerTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Details",
                              style: _headerTextStyle,
                            ),
                            Text(
                              "(+/-)",
                              style: _headerTextStyle,
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Gross Stock Variation(L)=Totalizer sales(Σ E)-UST sales(Σ J)  L",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 40.0,
                                width: 100.0,
                                child: TextFormField(
                                  controller: grossStockVariation,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Value',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    isDense: true,
                                  ),
                                  style: TextStyle(fontSize: 12.0),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter Gross stock variation';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Sum of recoverable shortage from Transporter in (PODs) between at last audit & current audit date  Σ K",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 40.0,
                                width: 100.0,
                                child: TextFormField(
                                  controller: sumOfRecoverable,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Value',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    isDense: true,
                                  ),
                                  style: TextStyle(fontSize: 12.0),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter SUM of Recoverable';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    var textValue =
                                        val == '' ? 0.0 : double.parse(val);
                                    var grossStock =
                                        grossStockVariation.text == ''
                                            ? 0.0
                                            : double.parse(
                                                grossStockVariation.text);
                                    netVariation.text =
                                        "${grossStock + textValue}";
                                    calculateDKStockVariation();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Net Variation (M) = (L + ΣK)  M",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 40.0,
                                width: 100.0,
                                child: TextFormField(
                                  controller: netVariation,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Value',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    isDense: true,
                                  ),
                                  style: TextStyle(fontSize: 12.0),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter Net Variation';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Column(
                          children: [
                            const Text(
                              "Stock Variation as %age  Of Totalizer sales M/ΣE= DK %",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 40.0,
                                width: 100.0,
                                child: TextFormField(
                                  controller: stockVariation,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Value',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    isDense: true,
                                  ),
                                  style: TextStyle(fontSize: 12.0),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter Stock Variation';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .85,
                          child: Text(
                            "Permissible Stock Variation (As per company's norms)",
                            style: _headerTextStyle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Permitted Evaporation / Handling loss as per control order  (only in case of negative stock variation)",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 40.0,
                                width: 100.0,
                                child: TextFormField(
                                  controller: grossStockVariationS,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Value',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    isDense: true,
                                  ),
                                  style: TextStyle(fontSize: 12.0),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter Gross stock variation';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Is Net Stock Variation within permissible limit (Q)",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 40.0,
                                width: 100.0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: DropdownButtonFormField<String>(
                                    value: "Select",
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                      border: const OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onChanged: (String? newValue) {
                                      isNetStockVariationPermissionLimit.text =
                                          newValue!;
                                    },
                                    validator: (String? value) {
                                      if (value == null) {
                                        return 'Please select an option';
                                      }
                                      return null;
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 1.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: const Text(
                          "If +ve or -ve variations not within permissible limits, Please provide analysis and action taken in bellow.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 13.0,
                          ),
                        ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          color: AppColors.meruYellow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '2',
                          style: _expandHeaderTextStyle,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 1.0),
                        width: MediaQuery.of(context).size.width * .55,
                        child: Text(
                          'Quality & Quantity',
                          style: _expandHeaderTextStyle,
                        ),
                      ),
                    ],
                  ),
                  content: Column(
                    children: [
                      const Divider(
                        color: Colors.grey,
                        height: 5.0,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ...buildEachUSTTapToExpandSectionDKQualityQuantity(
                          ((qnqTextControllers ?? {}) as Map),
                          ((stockAuditsFuelDKNozzleUSTDetails['UST'] ?? [])
                              as List))
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          color: AppColors.meruYellow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '3',
                          style: _expandHeaderTextStyle,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 1.0),
                        width: MediaQuery.of(context).size.width * .55,
                        child: Text(
                          'Daily Density Record Reconciliation',
                          style: _expandHeaderTextStyle,
                        ),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Divider(
                        color: Colors.grey,
                        height: 5.0,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ...buildEachNozzleTapToExpandSectionDKDDRR(
                          ((ddrrTextControllers ?? {}) as Map),
                          ((stockAuditsFuelDKNozzleUSTDetails['NOZZLE'] ?? [])
                              as List)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                width: MediaQuery.of(context).size.width * .85,
                margin: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.meruRed, // background
                        foregroundColor: Colors.white, // foreground
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(width: 10.0),
                    ElevatedButton(
                      child: const Text('Save'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.meruRed, // background
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
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
                                    begin: Colors.red, end: Colors.yellow),
                                duration: Duration(seconds: 1),
                                builder: (context, color, _) {
                                  return CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(color!),
                                  );
                                },
                                onEnd: () {},
                              ),
                            );
                          },
                        );
                        Future.delayed(Duration(seconds: 2), () async {
                          if (_formKey.currentState!.validate()) {
                            var nozzle_list = [];
                            var list_nozzle = Provider.of<AuditProvider>(
                                    context,
                                    listen: false)
                                .nozzelsUstsTextControllers;
                            var list_nozzle_ddrr = Provider.of<AuditProvider>(
                                    context,
                                    listen: false)
                                .ddrrTextControllers;
                            var ust_list = [];
                            var list_ust = Provider.of<AuditProvider>(context,
                                    listen: false)
                                .ustTextControllers;
                            var list_ust_qnq = Provider.of<AuditProvider>(
                                    context,
                                    listen: false)
                                .ustQnQTextControllers;

                            list_nozzle.forEach((i, eachData) {
                              nozzle_list.add({
                                "id": '${eachData['nozzle_id']}',
                                "category": "DK-NOZ",
                                "productName": "$i",
                                "productShortCode": "$i",
                                "productUOM": "LTRS",
                                "closedReading":
                                    "${eachData['textControllers'][0].text}",
                                "openingReading":
                                    "${eachData['textControllers'][1].text}",
                                "stockTransfer":
                                    "${eachData['textControllers'][2].text}",
                                "grossSales":
                                    "${eachData['textControllers'][3].text}",
                                "pumpTest":
                                    "${eachData['textControllers'][4].text}",
                                "netNozzleSales":
                                    "${eachData['textControllers'][5].text}",
                                "nozzleTestResult":
                                    "${list_nozzle_ddrr[i]['textControllers'][1].text}",
                                "nozzleTestQty":
                                    "${list_nozzle_ddrr[i]['textControllers'][2].text}",
                                "nozzleTestRemarks":
                                    "${list_nozzle_ddrr[i]['textControllers'][3].text}",
                              });
                            });

                            list_ust.forEach((i, eachData) {
                              ust_list.add({
                                "id": "${eachData['ust_id']}",
                                "category": "DK-UST",
                                "productName": "$i",
                                "productShortCode": "$i",
                                "productUOM": "LTRS",
                                "openingStock":
                                    "${eachData['textControllers'][0].text}",
                                "sumOfDNote":
                                    "${eachData['textControllers'][1].text}",
                                "stockTransfer":
                                    "${eachData['textControllers'][2].text}",
                                "total":
                                    "${eachData['textControllers'][3].text}",
                                "closingStock":
                                    "${eachData['textControllers'][4].text}",
                                "salesPerUST":
                                    "${eachData['textControllers'][5].text}",
                                "observedDensity":
                                    "${list_ust_qnq[i]['textControllers'][0].text}",
                                "observedTemp":
                                    "${list_ust_qnq[i]['textControllers'][1].text}",
                                "observedDensityAt20deg":
                                    "${list_ust_qnq[i]['textControllers'][2].text}",
                                "refDensity":
                                    "${list_ust_qnq[i]['textControllers'][3].text}",
                                "variation":
                                    "${list_ust_qnq[i]['textControllers'][5].text}",
                                "isVariationWithinLimit":
                                    "${list_ust_qnq[i]['textControllers'][6].text}",
                              });
                            });

                            final SharedPreferenceHelper _sharedPrefs =
                                SharedPreferenceHelper();
                            String? auditId = await _sharedPrefs.getString(
                                ConstantStrings.selectedStockAuditID);

                            var payload = {
                              "productCategory": "FUEL",
                              "auditId": "$auditId",
                              "stationCode":
                                  "${stockAuditsHeaderDetails['stationcode']}",
                              "overallRemarks": "overallRemarks 2",
                              "NOZZLE": nozzle_list,
                              "UST": ust_list,
                              "stockVariation": {
                                "productSubCategory": "DK",
                                "grossStockVariation":
                                    "${grossStockVariation.text}",
                                "sumOfRecoverableStorage":
                                    "${sumOfRecoverable.text}",
                                "netVariation": "${netVariation.text}",
                                "stockVariationOfTotalizerSales":
                                    "${stockVariation.text}",
                                "permittedEvaporation":
                                    "${grossStockVariationS.text}",
                                "isWithinLimit":
                                    "${isNetStockVariationPermissionLimit.text}",
                                "totalizerTotal": "${nozzleTotalizers.text}",
                                "ustTotal": "${ustTotalizers.text}"
                              }
                            };

                            var result = await Provider.of<AuditProvider>(
                                    context,
                                    listen: false)
                                .saveStockAuditData(stockAuditData: payload);

                            Navigator.of(context)
                                .pop(); // Close the CircularProgressIndicator dialog

                            ScaffoldMessenger.of(context).showMaterialBanner(
                              MaterialBanner(
                                content: Text('DK $result'),
                                actions: [
                                  TextButton(
                                      child: const Text('Close'),
                                      onPressed: () {
                                        Provider.of<AuditProvider>(context,
                                                listen: false)
                                            .fetchStockAuditsList("Fuel");
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentMaterialBanner();
                                      }),
                                ],
                              ),
                            );
                          } else {
                            Navigator.of(context)
                                .pop(); // Close the CircularProgressIndicator dialog
                            ScaffoldMessenger.of(context).showMaterialBanner(
                              MaterialBanner(
                                content: const Text(
                                    'Please fill all the DK Audit fields'),
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
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildEachNozzleTapToExpandSectionDK(
      Map nozzelsTextControllers, List nozzleList) {
    if (nozzleList.length > 0 && nozzelsTextControllers.isNotEmpty) {
      return [
        ...nozzleList.map((eachNozzle) => buildNozzleTapToExpandSectionFule(
            nozzelsTextControllers, eachNozzle))
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

  calculateNozzletotalizers() {
    var nozzleTextControllers =
        Provider.of<AuditProvider>(context, listen: false)
            .nozzelsUstsTextControllers;
    var nozzleTotal = 0.0;
    nozzleTextControllers.forEach((k, v) {
      var eachNozzleFinalData = "${v['textControllers'][5].text}";
      if (eachNozzleFinalData == '') {
        eachNozzleFinalData = '0.0';
      }
      nozzleTotal = nozzleTotal + double.parse(eachNozzleFinalData);
    });
    nozzleTotalizers.text = '$nozzleTotal';
    calculateDKStockVariation();
  }

  Widget buildNozzleTapToExpandSectionFule(
      Map nozzelsTextControllers, Map eachNozzle) {
    void nozzleCalculation() {
      var cR = double.parse(
          nozzelsTextControllers['${eachNozzle['productName']}']
                          ['textControllers'][0]
                      .text ==
                  ''
              ? '0.0'
              : nozzelsTextControllers['${eachNozzle['productName']}']
                      ['textControllers'][0]
                  .text);
      var oPR = double.parse(
          nozzelsTextControllers['${eachNozzle['productName']}']
                          ['textControllers'][1]
                      .text ==
                  ''
              ? '0.0'
              : nozzelsTextControllers['${eachNozzle['productName']}']
                      ['textControllers'][1]
                  .text);
      var sT = double.parse(
          nozzelsTextControllers['${eachNozzle['productName']}']
                          ['textControllers'][2]
                      .text ==
                  ''
              ? '0.0'
              : nozzelsTextControllers['${eachNozzle['productName']}']
                      ['textControllers'][2]
                  .text);
      var pT = double.parse(
          nozzelsTextControllers['${eachNozzle['productName']}']
                          ['textControllers'][4]
                      .text ==
                  ''
              ? '0.0'
              : nozzelsTextControllers['${eachNozzle['productName']}']
                      ['textControllers'][4]
                  .text);

      nozzelsTextControllers['${eachNozzle['productName']}']['textControllers']
              [3]
          .text = '${cR - oPR - sT}';

      var gS = double.parse(
          nozzelsTextControllers['${eachNozzle['productName']}']
                          ['textControllers'][3]
                      .text ==
                  ''
              ? '0.0'
              : nozzelsTextControllers['${eachNozzle['productName']}']
                      ['textControllers'][3]
                  .text);

      nozzelsTextControllers['${eachNozzle['productName']}']['textControllers']
              [5]
          .text = '${gS - pT}';

      calculateNozzletotalizers();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: TapToExpand(
        backgroundcolor: AppColors.meruWhite,
        iconSize: 18.0,
        titlePadding: EdgeInsets.all(15.0),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        iconColor: AppColors.meruBlack,
        title: Container(
          width: MediaQuery.of(context).size.width * .52,
          child: Text(
            '${eachNozzle['productName']}',
            textAlign: TextAlign.start,
            style: _expandHeaderTextStyle,
          ),
        ),
        content: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('(A)->CR'),
                        TextFormField(
                          controller: nozzelsTextControllers[
                                  '${eachNozzle['productName']}']
                              ['textControllers'][0],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Closing EMT',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (val) {
                            nozzelsTextControllers[
                                        '${eachNozzle['productName']}']
                                    ['textControllers'][0]
                                .text = val;
                            nozzleCalculation();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK Nozzle Data';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('(B)->OPR'),
                        TextFormField(
                          controller: nozzelsTextControllers[
                                  '${eachNozzle['productName']}']
                              ['textControllers'][1],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Opening Reading of(EMT)',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (val) {
                            nozzelsTextControllers[
                                        '${eachNozzle['productName']}']
                                    ['textControllers'][1]
                                .text = val;
                            nozzleCalculation();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK Nozzle Data';
                            } else {
                              return null;
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
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('(C)->ST'),
                        TextFormField(
                          controller: nozzelsTextControllers[
                                  '${eachNozzle['productName']}']
                              ['textControllers'][2],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Stock Transfer',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (val) {
                            nozzelsTextControllers[
                                        '${eachNozzle['productName']}']
                                    ['textControllers'][2]
                                .text = val;
                            nozzleCalculation();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK Nozzle Data';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('(D=A-B-C)->GS'),
                        TextFormField(
                          controller: nozzelsTextControllers[
                                  '${eachNozzle['productName']}']
                              ['textControllers'][3],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Gross Sales',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (val) {
                            nozzelsTextControllers[
                                        '${eachNozzle['productName']}']
                                    ['textControllers'][3]
                                .text = val;
                            nozzleCalculation();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK Nozzle Data';
                            } else {
                              return null;
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
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('(E)->PT'),
                        TextFormField(
                          controller: nozzelsTextControllers[
                                  '${eachNozzle['productName']}']
                              ['textControllers'][4],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Pump Test',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            nozzelsTextControllers[
                                        '${eachNozzle['productName']}']
                                    ['textControllers'][4]
                                .text = val;
                            nozzleCalculation();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK Nozzle Data';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('(F=D-E)->NNS'),
                        TextFormField(
                          controller: nozzelsTextControllers[
                                  '${eachNozzle['productName']}']
                              ['textControllers'][5],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Net Nozzle Sales',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            nozzelsTextControllers[
                                        '${eachNozzle['productName']}']
                                    ['textControllers'][5]
                                .text = val;
                            nozzleCalculation();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK Nozzle Data';
                            } else {
                              return null;
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

  List<Widget> buildEachUSTTapToExpandSectionDK(
      Map ustsTextControllers, List ustList) {
    if (ustList.length > 0 && ustsTextControllers.isNotEmpty) {
      return [
        ...ustList.map((eachUST) =>
            buildUSTTapToExpandSectionFule(ustsTextControllers, eachUST))
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

  calculateUSTtotalizers() {
    var ustsTextControllers =
        Provider.of<AuditProvider>(context, listen: false).ustTextControllers;
    var ustTotal = 0.0;
    ustsTextControllers.forEach((k, v) {
      var eachUSTFinalData = "${v['textControllers'][5].text}";
      if (eachUSTFinalData == '') {
        eachUSTFinalData = '0.0';
      }
      ustTotal = ustTotal + double.parse(eachUSTFinalData);
    });
    ustTotalizers.text = '$ustTotal';
    calculateDKStockVariation();
  }

  calculateDKStockVariation() {
    var sum_E = nozzleTotalizers.text == '' ? "0.0" : nozzleTotalizers.text;
    var sum_J = ustTotalizers.text == '' ? "0.0" : ustTotalizers.text;

    grossStockVariation.text =
        "${(double.parse(sum_E) - double.parse(sum_J)).toStringAsFixed(2)}";
    var l = grossStockVariation.text == '' ? "0.0" : grossStockVariation.text;

    var k = sumOfRecoverable.text == '' ? "0.0" : sumOfRecoverable.text;

    netVariation.text = '${double.parse(l) + double.parse(k)}';
    var m = netVariation.text == '' ? "0.0" : netVariation.text;

    stockVariation.text =
        '${((double.parse(m) / double.parse(sum_E)) * 100).toStringAsFixed(2)} %';

    grossStockVariationS.text = "${double.parse(sum_E) * (-0.005)}";
  }

  Widget buildUSTTapToExpandSectionFule(Map ustsTextControllers, Map eachUST) {
    void ustCalculation() {
      var oS = double.parse(ustsTextControllers['${eachUST['productName']}']
                      ['textControllers'][0]
                  .text ==
              ''
          ? '0.0'
          : ustsTextControllers['${eachUST['productName']}']['textControllers']
                  [0]
              .text);
      var dNote = double.parse(ustsTextControllers['${eachUST['productName']}']
                      ['textControllers'][1]
                  .text ==
              ''
          ? '0.0'
          : ustsTextControllers['${eachUST['productName']}']['textControllers']
                  [1]
              .text);

      var st = double.parse(ustsTextControllers['${eachUST['productName']}']
                      ['textControllers'][2]
                  .text ==
              ''
          ? '0.0'
          : ustsTextControllers['${eachUST['productName']}']['textControllers']
                  [2]
              .text);

      /*ustsTextControllers['${eachUST['productName']}']['textControllers'][2]
          .text = "${oS + dNote}";*/

      ustsTextControllers['${eachUST['productName']}']['textControllers'][3]
          .text = "${(oS + dNote - st)}";

      var cS = double.parse(ustsTextControllers['${eachUST['productName']}']
                      ['textControllers'][4]
                  .text ==
              ''
          ? '0.0'
          : ustsTextControllers['${eachUST['productName']}']['textControllers']
                  [4]
              .text);

      ustsTextControllers['${eachUST['productName']}']['textControllers'][5]
          .text = "${(oS + dNote - cS)}";

      calculateUSTtotalizers();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: TapToExpand(
        backgroundcolor: AppColors.meruWhite,
        iconSize: 18.0,
        titlePadding: EdgeInsets.all(15.0),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        iconColor: AppColors.meruBlack,
        title: Container(
          width: MediaQuery.of(context).size.width * .52,
          child: Text(
            '${eachUST['productName']}',
            style: _expandHeaderTextStyle,
          ),
        ),
        content: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text(
                          '(G)->OS',
                        ),
                        TextFormField(
                          controller:
                              ustsTextControllers['${eachUST['productName']}']
                                  ['textControllers'][0],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Opening Stock',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (val) {
                            ustsTextControllers['${eachUST['productName']}']
                                    ['textControllers'][0]
                                .text = val;
                            ustCalculation();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK UST Data';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text('(ΣH)->S of D-Note'),
                        TextFormField(
                          controller:
                              ustsTextControllers['${eachUST['productName']}']
                                  ['textControllers'][1],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Sum of D-Note',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          onChanged: (val) {
                            ustsTextControllers['${eachUST['productName']}']
                                    ['textControllers'][1]
                                .text = val;
                            ustCalculation();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK UST Data';
                            } else {
                              return null;
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
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text('ST'),
                        TextFormField(
                          controller:
                              ustsTextControllers['${eachUST['productName']}']
                                  ['textControllers'][2],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Stock Transfer',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (val) {
                            ustsTextControllers['${eachUST['productName']}']
                                    ['textControllers'][2]
                                .text = val;
                            ustCalculation();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK UST Data';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text('(J=G+ΣH-I) ->T '),
                        TextFormField(
                          controller:
                              ustsTextControllers['${eachUST['productName']}']
                                  ['textControllers'][3],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Total',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (val) {
                            ustsTextControllers['${eachUST['productName']}']
                                    ['textControllers'][3]
                                .text = val;
                            ustCalculation();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK UST Data';
                            } else {
                              return null;
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
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text('(K)->CS'),
                        TextFormField(
                          controller:
                              ustsTextControllers['${eachUST['productName']}']
                                  ['textControllers'][4],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Closing Stock',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (val) {
                            ustsTextControllers['${eachUST['productName']}']
                                    ['textControllers'][4]
                                .text = val;
                            ustCalculation();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK UST Data';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .33,
                    child: Column(
                      children: [
                        const Text('(L=J-K)->Sales/UST'),
                        TextFormField(
                          controller:
                              ustsTextControllers['${eachUST['productName']}']
                                  ['textControllers'][5],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Sales as per UST',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (val) {
                            ustsTextControllers['${eachUST['productName']}']
                                    ['textControllers'][5]
                                .text = val;
                            ustCalculation();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK UST Data';
                            } else {
                              return null;
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

  List<Widget> buildEachUSTTapToExpandSectionDKQualityQuantity(
      Map qnqTextControllers, List ustList) {
    if (ustList.length > 0 && qnqTextControllers.isNotEmpty) {
      return [
        ...ustList.map((eachUST) =>
            buildUSTTapToExpandSectionFuleQualityQuantity(
                qnqTextControllers, eachUST))
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

  Widget buildUSTTapToExpandSectionFuleQualityQuantity(
      Map qnqTextControllers, Map eachUST) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: TapToExpand(
        backgroundcolor: AppColors.meruWhite,
        iconSize: 18.0,
        titlePadding: EdgeInsets.all(15.0),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        iconColor: AppColors.meruBlack,
        title: Container(
          width: MediaQuery.of(context).size.width * .52,
          child: Text(
            '${eachUST['productName']}',
            style: _expandHeaderTextStyle,
          ),
        ),
        content: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.33,
                    child: Column(
                      children: [
                        Text("OD - Nor. Ambient"),
                        TextFormField(
                          controller:
                              qnqTextControllers["${eachUST['productName']}"]
                                  ['textControllers'][0],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'OD - Nor. Ambient',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK Quality & Quantity Data';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: Column(
                        children: [
                          const Text("Observed Temp."),
                          TextFormField(
                            controller:
                                qnqTextControllers["${eachUST['productName']}"]
                                    ['textControllers'][1],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Observed Temp.',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              isDense: true,
                            ),
                            style: TextStyle(fontSize: 12.0),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter DK Quality & Quantity Data';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.33,
                    child: Column(
                      children: [
                        const Text("OD at 20deg C"),
                        TextFormField(
                          controller:
                              qnqTextControllers["${eachUST['productName']}"]
                                  ['textControllers'][2],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'OD at 20deg C',
                            hintMaxLines: 3,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (value) {
                            var od_val =
                                qnqTextControllers["${eachUST['productName']}"]
                                        ['textControllers'][2]
                                    .text;

                            var rd_val =
                                qnqTextControllers["${eachUST['productName']}"]
                                        ['textControllers'][3]
                                    .text;

                            if (od_val == '') {
                              od_val = 0.0;
                            } else {
                              od_val = double.parse(od_val);
                            }
                            if (rd_val == '') {
                              rd_val = 0.0;
                            } else {
                              rd_val = double.parse(rd_val);
                            }
                            var result = rd_val - od_val;
                            qnqTextControllers["${eachUST['productName']}"]
                                    ['textControllers'][4]
                                .text = '${result.toStringAsFixed(2)}';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK Quality & Quantity Data';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.33,
                    child: Column(
                      children: [
                        const Text("RD at 20deg C"),
                        TextFormField(
                          controller:
                              qnqTextControllers["${eachUST['productName']}"]
                                  ['textControllers'][3],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'RD at 20deg C',
                            hintMaxLines: 4,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (value) {
                            var od_val =
                                qnqTextControllers["${eachUST['productName']}"]
                                        ['textControllers'][2]
                                    .text;
                            var rd_val =
                                qnqTextControllers["${eachUST['productName']}"]
                                        ['textControllers'][3]
                                    .text;

                            if (od_val == '') {
                              od_val = 0.0;
                            } else {
                              od_val = double.parse(od_val);
                            }
                            if (rd_val == '') {
                              rd_val = 0.0;
                            } else {
                              rd_val = double.parse(rd_val);
                            }
                            var result = rd_val - od_val;
                            qnqTextControllers["${eachUST['productName']}"]
                                    ['textControllers'][4]
                                .text = '${result.toStringAsFixed(2)}';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK Quality & Quantity Data';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.33,
                    child: Column(
                      children: [
                        const Text(
                          "Variation ( + / -)",
                        ),
                        TextFormField(
                          controller:
                              qnqTextControllers["${eachUST['productName']}"]
                                  ['textControllers'][4],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Variation ( + / -)',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK Quality & Quantity Data';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.33,
                    child: Column(
                      children: [
                        const Text(
                          "Approved Variation (+ / -)",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          controller:
                              qnqTextControllers["${eachUST['productName']}"]
                                  ['textControllers'][5],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Sales as per UST',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DK Quality & Quantity Data';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Variation With In Limit (Yes / No)",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.32,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1.0,
                    ),
                    child: DropdownButtonFormField<String>(
                      value: "Select",
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        border: const OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        qnqTextControllers["${eachUST['productName']}"]
                                ['textControllers'][6]
                            .text = newValue!;
                      },
                      validator: (String? value) {
                        if (value == null || value == 'Select') {
                          return 'Please select an option';
                        }
                        return null;
                      },
                      items: ['Select', 'Yes', 'No']
                          .map<DropdownMenuItem<String>>((String value) {
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildEachNozzleTapToExpandSectionDKDDRR(
      Map ddrrTextControllers, List ustList) {
    if (ustList.length > 0 && ddrrTextControllers.isNotEmpty) {
      return [
        ...ustList.map((eachNozzle) => buildNozzleTapToExpandSectionFuleDDRR(
            ddrrTextControllers, eachNozzle))
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

  Widget buildNozzleTapToExpandSectionFuleDDRR(
      Map ddrrTextControllers, Map eachNozzleDDRR) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: TapToExpand(
        backgroundcolor: AppColors.meruWhite,
        iconSize: 18.0,
        titlePadding: EdgeInsets.all(15.0),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        iconColor: AppColors.meruBlack,
        title: Container(
          width: MediaQuery.of(context).size.width * .52,
          child: Text(
            '${eachNozzleDDRR['productName']}',
            style: _expandHeaderTextStyle,
          ),
        ),
        content: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .33,
                    height: 45.0,
                    child: TextFormField(
                      controller: ddrrTextControllers[
                              "${eachNozzleDDRR['productName']}"]
                          ['textControllers'][0],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Test Result ',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        isDense: true,
                      ),
                      style: TextStyle(fontSize: 12.0),
                      onChanged: (val) async {
                        var final_result = 'Ok';

                        var new_value = val == '' ? 0.0 : double.parse(val);

                        if (new_value == 0.0) {
                          final_result = 'Ok';
                        } else if (new_value > 0.0) {
                          final_result = 'Excess';
                        } else if (new_value < 0) {
                          final_result = 'Short';
                        }
                        ddrrTextControllers["${eachNozzleDDRR['productName']}"]
                                ['textControllers'][1]
                            .text = final_result;
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter DDRR data';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .33,
                    height: 45.0,
                    child: TextFormField(
                      controller: ddrrTextControllers[
                              "${eachNozzleDDRR['productName']}"]
                          ['textControllers'][1],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Test Results',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        isDense: true,
                      ),
                      style: TextStyle(fontSize: 12.0),
                      textAlign: TextAlign.center,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter DDRR data';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .33,
                    height: 45.0,
                    child: TextFormField(
                      controller: ddrrTextControllers[
                              "${eachNozzleDDRR['productName']}"]
                          ['textControllers'][2],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Test Qty(lts)',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        isDense: true,
                      ),
                      style: TextStyle(fontSize: 12.0),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter DDRR data';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .33,
                    height: 45.0,
                    child: TextFormField(
                      controller: ddrrTextControllers[
                              "${eachNozzleDDRR['productName']}"]
                          ['textControllers'][3],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Remarks',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        isDense: true,
                      ),
                      style: TextStyle(fontSize: 12.0),
                      textAlign: TextAlign.center,
                      /*validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter DDRR data';
                        }
                        return null;
                      },*/
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
