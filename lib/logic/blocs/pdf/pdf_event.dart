part of 'pdf_bloc.dart';

abstract class PdfEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPdf extends PdfEvent {}
