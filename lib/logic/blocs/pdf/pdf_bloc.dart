import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/obligation_repository.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  final ObligationRepository repository;

  PdfBloc(this.repository) : super(PdfInitial()) {
    on<LoadPdf>((event, emit) async {
      emit(PdfLoading());
      try {
        final pdfData = await repository.fetchTransactionsPdf();
        emit(PdfLoaded(pdfData));
      } catch (e) {
        emit(PdfError("Failed to load PDF: $e"));
      }
    });
  }
}
