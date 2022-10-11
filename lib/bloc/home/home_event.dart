part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetHomeList extends HomeEvent {}

class ConvertCurrencyRequest extends HomeEvent {
  ConvertCurrencyRequest(this.currencyFromTo);

  final String currencyFromTo;
}

class HistoricalRequest extends HomeEvent {
  HistoricalRequest(this.currencyFromTo, this.dateFromTo);

  final String currencyFromTo;
  final String dateFromTo;
}