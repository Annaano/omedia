part of 'pdf_bloc.dart';

abstract class PdfState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PdfInitial extends PdfState {}

class PdfLoading extends PdfState {}

class PdfLoaded extends PdfState {
  final Uint8List pdfData;

  PdfLoaded(this.pdfData);

  @override
  List<Object?> get props => [pdfData];
}

class PdfError extends PdfState {
  final String message;

  PdfError(this.message);

  @override
  List<Object?> get props => [message];
}
