import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:currency_application/data/model/response/convert_response.dart';
import 'package:currency_application/data/model/response/historical_response.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/dbmodel/country_data.dart';
import '../../data/providers/app_exceptions.dart';
import '../../data/repositories/home_repository.dart';
import '../../global.dart';
import '../../utils/utils.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<GetHomeList>(_fetchHomeData);
    on<ConvertCurrencyRequest>(_fetchCurrencyConvert);
    on<HistoricalRequest>(_fetchHistoricalData);
  }

  FutureOr<void> _fetchHomeData(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final homeResponse = await homeRepository.fetchHomeData();

      for (var key in  homeResponse.data!.keys) {
        var data = homeResponse.data![key];
        var image = await networkImageToBase64(
            'https://flagcdn.com/36x27/${key.toLowerCase()}.png');
        CountryData dataModel = CountryData(
            currencyId: data['currencyId'],
            currencyName: data['currencyName'],
            image: image,
            currencySymbol: data['currencySymbol'],
            id: data['id'],
            name: data['name']);
        await countryList.put(key, dataModel);
      }
      emit(HomeSuccess());
      if (homeResponse.data == null && homeResponse.data == {}) {
        emit(HomeFailure("Something Want Wrong!"));
        return;
      }
      if (homeResponse.error != null) {
        emit(HomeFailure(homeResponse.error!));
        return;
      }
    } catch (e) {
      AppException exception = e as AppException;
      emit(HomeFailure(exception.message.toString()));
    }
  }

  FutureOr<void> _fetchCurrencyConvert(
    ConvertCurrencyRequest event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final convertResponse =
          await homeRepository.fetchCurrencyConvert(event.currencyFromTo);
      emit(CurrencyConvertSuccess(
          ConvertResponse.fromJson(convertResponse.data!)));

      if (convertResponse.data == null && convertResponse.data == {}) {
        emit(HomeFailure("Something Want Wrong!"));
        return;
      }
      if (convertResponse.error != null) {
        emit(HomeFailure(convertResponse.error!));
        return;
      }
    } catch (e) {
      AppException exception = e as AppException;
      emit(HomeFailure(exception.message.toString()));
    }
  }

  FutureOr<void> _fetchHistoricalData(
    HistoricalRequest event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final historicalResponse = await homeRepository.fetchHistoricalData(
          event.currencyFromTo, event.dateFromTo);
      emit(HistoricalDataSuccess(
          HistoricalResponse.fromJson(historicalResponse.data!)));

      if (historicalResponse.data == null && historicalResponse.data == {}) {
        emit(HomeFailure("Something Want Wrong!"));
        return;
      }
      if (historicalResponse.error != null) {
        emit(HomeFailure(historicalResponse.error!));
        return;
      }
    } catch (e) {
      AppException exception = e as AppException;
      emit(HomeFailure(exception.message.toString()));
    }
  }
}
