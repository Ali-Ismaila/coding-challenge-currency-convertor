import 'package:currency_application/data/model/response/convert_response.dart';
import 'package:currency_application/data/model/response/currency_list_response.dart';

import '../model/response/historical_response.dart';
import '../providers/end_points.dart';
import '../providers/http_client.dart';

class HomeRepository {
  ///Fetch Country & Currency List
  Future<CurrencyListResponse> fetchHomeData() async {
    var reqAuth = await HttpClient().getWithPath(apiCountryCurrencyList);
    CurrencyListResponse response = CurrencyListResponse.fromJson(reqAuth);
    if (response.data != null) {
      return response;
    } else {
      throw Exception('Something Want Wrong');
    }
  }

  ///Fetch CurrencyConvert Data
  Future<ConvertResponse> fetchCurrencyConvert(String currencyData) async {
    var reqAuth = await HttpClient()
        .getWithPath(apiHistoricalDataA + currencyData + apiCurrencyConvert);
    ConvertResponse response = ConvertResponse.fromJson(reqAuth);
    return response;
  }

  ///Fetch Historical Data
  Future<HistoricalResponse> fetchHistoricalData(
      String currencyData, String dateDate) async {
    var reqAuth = await HttpClient().getWithPath(apiHistoricalDataA +
        currencyData +
        apiHistoricalDataB +
        dateDate +
        '&' +
        apiKey);
    HistoricalResponse response = HistoricalResponse.fromJson(reqAuth);
    return response;
  }
}
