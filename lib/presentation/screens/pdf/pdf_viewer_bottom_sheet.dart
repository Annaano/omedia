import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/constants/app_text_styles.dart';
import 'package:omedia_payment_app/logic/blocs/pdf/pdf_bloc.dart';

class PdfViewerBottomSheet extends StatelessWidget {
  const PdfViewerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorConstants.grayLight, width: 1),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'ამონაწერი',
                  style: TextStyle(
                    color: ColorConstants.black,
                    fontFamily: AppTextStyles.fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  color: ColorConstants.grayDark,
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocBuilder<PdfBloc, PdfState>(
              builder: (context, state) {
                if (state is PdfLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PdfLoaded) {
                  return SfPdfViewer.memory(
                    state.pdfData,
                    canShowPaginationDialog: false,
                    canShowScrollHead: false,
                    canShowScrollStatus: false,
                  );
                } else if (state is PdfError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: ColorConstants.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'შეცდომა',
                          style: TextStyle(
                            color: ColorConstants.error,
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: TextStyle(
                            color: ColorConstants.grayDark,
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text('PDF not loaded'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
