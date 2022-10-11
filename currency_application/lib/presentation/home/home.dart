import 'dart:convert';

import 'package:currency_application/bloc/home/home_bloc.dart';
import 'package:currency_application/data/repositories/home_repository.dart';
import 'package:currency_application/presentation/home/widget/chart_view.dart';
import 'package:currency_application/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/model/dbmodel/country_data.dart';
import '../../global.dart';
import '../../values/values.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  List<CountryData> inventoryList = [];
  TextEditingController amountController = TextEditingController();
  List<ChartData> chartData = [];
  double? convertAmount = 0.0;
  CountryData? fromValue, toValue;

  @override
  void initState() {
    readDataFromDatabase();
    super.initState();
  }

  readDataFromDatabase() {
    inventoryList.clear();
    inventoryList = countryList.values
        .map((e) => CountryData(
            currencyId: e.currencyId,
            currencyName: e.currencyName,
            currencySymbol: e.currencySymbol,
            id: e.id,
            name: e.name,
            image: e.image))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HomeRepository(),
      child: BlocProvider<HomeBloc>(
        create: (contextProvider) {
          if (inventoryList.isEmpty) {
            return HomeBloc(
                RepositoryProvider.of<HomeRepository>(contextProvider))
              ..add(GetHomeList());
          }
          return HomeBloc(
              RepositoryProvider.of<HomeRepository>(contextProvider));
        },
        child: BlocConsumer<HomeBloc, HomeState>(
          buildWhen: (pState, cState) {
            return cState is HomeSuccess ||
                cState is HomeFailure ||
                cState is HomeLoading ||
                cState is CurrencyConvertSuccess ||
                cState is HistoricalDataSuccess;
          },
          listener: (context, state) {
            if (state is HomeSuccess) {
              readDataFromDatabase();
            }
            if (state is HomeFailure) {
              chartData.clear();
              convertAmount == 0.0;
              snackBar(context, "Failure", state.errorMsg, Colors.red);
            }
            if (state is HistoricalDataSuccess) {
              chartData.clear();
              for (var elementData
                  in state.response.data!.entries.first.value.entries) {
                if (elementData.key ==
                    DateFormat('yyyy-MM-dd').format(DateTime.now())) {
                  convertAmount =
                      double.parse(amountController.text) * elementData.value;
                }
                chartData.add(ChartData(
                    DateFormat('dd MMM yy').format(
                        DateFormat('yyyy-MM-dd').parse(elementData.key)),
                    elementData.value));
              }
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Scaffold(
                    appBar: AppBar(
                      title: const Text('Currency Converter'),
                    ),
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(spacingStandard),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(spacingStandard),
                                  child: TextField(
                                      controller: amountController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: const InputDecoration(
                                          focusColor: Colors.black,
                                          hintText: 'Enter Amount',
                                          contentPadding:
                                              EdgeInsets.all(spacingStandard),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)))),
                                      style: mediumLargeTextStyle),
                                ),
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: spacingStandard,
                                          left: spacingContainer,
                                          top: spacingStandard,
                                          bottom: spacingStandard),
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: spacingStandard,
                                              right: spacingStandard),
                                          child: DropdownButton<CountryData>(
                                            value: fromValue,
                                            elevation: 16,
                                            underline: Container(),
                                            hint: Text("From Currency",
                                                style: smallNormalTextStyle),
                                            onChanged: (CountryData? newValue) {
                                              if (toValue == null) {
                                                setState(() {
                                                  fromValue = newValue;
                                                });
                                                return;
                                              }
                                              if (toValue != null &&
                                                  toValue!.currencyId !=
                                                      newValue!.currencyId) {
                                                setState(() {
                                                  fromValue = newValue;
                                                });
                                              }
                                            },
                                            style: smallNormalTextStyle,
                                            isExpanded: true,
                                            items: inventoryList.map<
                                                    DropdownMenuItem<
                                                        CountryData>>(
                                                (CountryData value) {
                                              return DropdownMenuItem<
                                                  CountryData>(
                                                value: value,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              spacingControl),
                                                      child: Image.memory(
                                                        const Base64Decoder()
                                                            .convert(
                                                                value.image),
                                                        height: 25,
                                                        width: 40,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .only(
                                                          left: spacingControl),
                                                      child: Text(
                                                          '${value.currencyId} (${value.id})',
                                                          style:
                                                              mediumTextStyle),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: spacingContainer,
                                          left: spacingStandard,
                                          top: spacingStandard,
                                          bottom: spacingStandard),
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: spacingStandard,
                                              right: spacingStandard),
                                          child: DropdownButton<CountryData>(
                                            value: toValue,
                                            elevation: 16,
                                            underline: Container(),
                                            isExpanded: true,
                                            hint: Text("To Currency",
                                                style: smallNormalTextStyle),
                                            onChanged: (CountryData? newValue) {
                                              if (fromValue == null) {
                                                setState(() {
                                                  toValue = newValue;
                                                });
                                                return;
                                              }
                                              if (fromValue != null &&
                                                  fromValue!.currencyId !=
                                                      newValue!.currencyId) {
                                                setState(() {
                                                  toValue = newValue;
                                                });
                                              }
                                            },
                                            style: smallNormalTextStyle,
                                            items: inventoryList.map<
                                                    DropdownMenuItem<
                                                        CountryData>>(
                                                (CountryData value) {
                                              return DropdownMenuItem<
                                                  CountryData>(
                                                value: value,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              spacingControl),
                                                      child: Image.memory(
                                                        const Base64Decoder()
                                                            .convert(
                                                                value.image),
                                                        height: 25,
                                                        width: 40,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .only(
                                                          left: spacingControl),
                                                      child: Text(
                                                          '${value.currencyId} (${value.id})',
                                                          style:
                                                              mediumTextStyle),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                            const SizedBox(height: spacingStandard),
                            MaterialButton(
                                height: 70,
                                minWidth: 70,
                                color: Colors.blue,
                                shape: const CircleBorder(),
                                child: Text('GO',
                                    style: boldTextStyle.copyWith(
                                        color: Colors.white)),
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  chartData.clear();
                                  convertAmount == 0.0;
                                  if (amountController.text.isEmpty) {
                                    snackBar(context, "Failure",
                                        "Please Enter Amount", Colors.red);
                                    return;
                                  }

                                  if (fromValue != null &&
                                      fromValue!.currencyId.isNotEmpty &&
                                      toValue != null &&
                                      toValue!.currencyId.isNotEmpty &&
                                      fromValue!.currencyId ==
                                          toValue!.currencyId) {
                                    snackBar(
                                        context,
                                        "Failure",
                                        "Please Change To Currency",
                                        Colors.red);
                                    return;
                                  }

                                  if (fromValue != null &&
                                      fromValue!.currencyId.isNotEmpty &&
                                      toValue != null &&
                                      toValue!.currencyId.isNotEmpty) {
                                    BlocProvider.of<HomeBloc>(context).add(
                                        HistoricalRequest(
                                            fromValue!.currencyId +
                                                '_' +
                                                toValue!.currencyId +
                                                ',' +
                                                toValue!.currencyId +
                                                '_' +
                                                fromValue!.currencyId,
                                            'date=${DateFormat("yyyy-MM-dd").format((DateTime.now().subtract(const Duration(days: 7))))}&endDate=${DateFormat("yyyy-MM-dd").format(DateTime.now())}'));
                                  } else {
                                    snackBar(context, "Failure",
                                        "Please Select Currency", Colors.red);
                                  }
                                }),
                            const SizedBox(
                              height: spacingContainer,
                            ),
                            Text(
                                '$convertAmount ${toValue != null && toValue!.currencyId.isNotEmpty ? toValue!.currencyId : ''}',
                                style: boldLargeTextStyle.copyWith(
                                    fontSize: textSizeXLarge)),
                            const SizedBox(height: spacingContainer),
                            chartData.isNotEmpty
                                ? ChartView(chartData: chartData)
                                : Container(),
                          ],
                        ),
                      ),
                    )),
                (state is HomeLoading)
                    ? Stack(
                        children: [
                          Container(
                            color: Colors.black.withAlpha(100),
                          ),
                          Center(
                              child: Container(
                            width: 80,
                            height: 80,
                            padding: const EdgeInsets.all(spacingStandard),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: const CircularProgressIndicator(
                                color: primaryColor),
                          ))
                        ],
                      )
                    : Container()
              ],
            );
          },
        ),
      ),
    );
  }
}
