part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSuccess extends HomeState {
  HomeSuccess();

  @override
  List<Object?> get props => [];
}

class CurrencyListSuccess extends HomeState {
  final List<CountryData> currencyList;

  CurrencyListSuccess(this.currencyList);

  @override
  List<Object?> get props => [currencyList];
}

class CurrencyConvertSuccess extends HomeState {
  final ConvertResponse response;

  CurrencyConvertSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class HistoricalDataSuccess extends HomeState {
  final HistoricalResponse response;

  HistoricalDataSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class HomeFailure extends HomeState {
  final String errorMsg;

  HomeFailure(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}
