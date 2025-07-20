import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormatterWidget {
  static String toGeorgianUppercase(String text) {
    const offset = 0x1C90 - 0x10D0;
    return String.fromCharCodes(
      text.runes.map((r) {
        if (r >= 0x10D0 && r <= 0x10F6) {
          return r + offset;
        }
        return r;
      }),
    );
  }

  static String convertDateFormatWithZeroPad(String dateString) {
    try {
      final date = DateTime.parse(dateString);

      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      final year = date.year.toString();

      return '$day/$month/$year';
    } catch (e) {
      return dateString;
    }
  }

  static String formatNumberWithCommas(dynamic number) {
    try {
      num numericValue;
      if (number is String) {
        numericValue = double.parse(number);
      } else if (number is num) {
        numericValue = number;
      } else {
        return number.toString();
      }

      final formatter = NumberFormat('#,##0.00', 'en_US');
      return formatter.format(numericValue);
    } catch (e) {
      return number.toString();
    }
  }
}
