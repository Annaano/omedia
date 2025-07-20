class ObligationGoldModel {
  final String customerName;
  final String phone;
  final double totalPayment;
  final List<LoanItem> loans;
  final UpcomingPayments upcoming;

  ObligationGoldModel({
    required this.customerName,
    required this.phone,
    required this.totalPayment,
    required this.loans,
    required this.upcoming,
  });

  factory ObligationGoldModel.fromJson(Map<String, dynamic> json) {
    final loansData = json['loans'];

    List<LoanItem> loansList = [];
    if (loansData != null) {
      if (loansData is List<dynamic>) {
        loansList = loansData.map((item) => LoanItem.fromJson(item)).toList();
      } else {
        print('Warning: loans data is not a list: $loansData');
      }
    } else {
      print('Warning: loans data is null');
    }

    return ObligationGoldModel(
      customerName: json['customerName'] ?? '',
      phone: json['phone'] ?? '',
      totalPayment: (json['total_payment'] ?? 0).toDouble(),
      loans: loansList,
      upcoming: UpcomingPayments.fromJson(json['upcoming'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'phone': phone,
      'total_payment': totalPayment,
      'loans': loans.map((item) => item.toJson()).toList(),
      'upcoming': upcoming.toJson(),
    };
  }
}

class LoanItem {
  final String accountNumber;
  final double issueAmount;
  final double principalAmount;
  final String issueDate;
  final double paymentAmount;
  final String paymentDate;
  final String currency;
  final double percRate;
  final double effectiveIntRate;
  final double monthPay30;
  final double monthPay31;
  final double monthPay;
  final int fineDay;
  final double fineAmount;
  final bool hasGraphic;
  final double finePerc;
  final int duration;
  final double? percRatePromotion;
  final double? secondMonthPay30;
  final double? secondMonthPay31;
  final double percAmount;
  final double fineAmount2;

  LoanItem({
    required this.accountNumber,
    required this.issueAmount,
    required this.principalAmount,
    required this.issueDate,
    required this.paymentAmount,
    required this.paymentDate,
    required this.currency,
    required this.percRate,
    required this.effectiveIntRate,
    required this.monthPay30,
    required this.monthPay31,
    required this.monthPay,
    required this.fineDay,
    required this.fineAmount,
    required this.hasGraphic,
    required this.finePerc,
    required this.duration,
    this.percRatePromotion,
    this.secondMonthPay30,
    this.secondMonthPay31,
    required this.percAmount,
    required this.fineAmount2,
  });

  factory LoanItem.fromJson(Map<String, dynamic> json) {
    return LoanItem(
      accountNumber: json['account_number'] ?? '',
      issueAmount: (json['issue_amount'] ?? 0).toDouble(),
      principalAmount: (json['principal_amount'] ?? 0).toDouble(),
      issueDate: json['issue_date'] ?? '',
      paymentAmount: (json['payment_amount'] ?? 0).toDouble(),
      paymentDate: json['payment_date'] ?? '',
      currency: json['currency'] ?? 'GEL',
      percRate: (json['perc_rate'] ?? 0).toDouble(),
      effectiveIntRate: (json['effective_int_Rate'] ?? 0).toDouble(),
      monthPay30: (json['month_pay_30'] ?? 0).toDouble(),
      monthPay31: (json['month_pay_31'] ?? 0).toDouble(),
      monthPay: (json['month_pay'] ?? 0).toDouble(),
      fineDay: json['fineDay'] ?? 0,
      fineAmount: (json['fineAmount'] ?? 0).toDouble(),
      hasGraphic: json['has_graphic'] ?? false,
      finePerc: (json['fine_perc'] ?? 0).toDouble(),
      duration: json['duration'] ?? 0,
      percRatePromotion: json['perc_rate_promotion']?.toDouble(),
      secondMonthPay30: json['second_month_pay30']?.toDouble(),
      secondMonthPay31: json['second_month_pay31']?.toDouble(),
      percAmount: (json['perc_amount'] ?? 0).toDouble(),
      fineAmount2: (json['fine_amount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_number': accountNumber,
      'issue_amount': issueAmount,
      'principal_amount': principalAmount,
      'issue_date': issueDate,
      'payment_amount': paymentAmount,
      'payment_date': paymentDate,
      'currency': currency,
      'perc_rate': percRate,
      'effective_int_Rate': effectiveIntRate,
      'month_pay_30': monthPay30,
      'month_pay_31': monthPay31,
      'month_pay': monthPay,
      'fineDay': fineDay,
      'fineAmount': fineAmount,
      'has_graphic': hasGraphic,
      'fine_perc': finePerc,
      'duration': duration,
      'perc_rate_promotion': percRatePromotion,
      'second_month_pay30': secondMonthPay30,
      'second_month_pay31': secondMonthPay31,
      'perc_amount': percAmount,
      'fine_amount': fineAmount2,
    };
  }
}

class UpcomingPayments {
  final int remainingDays;
  final bool today;
  final bool expired;
  final double paymentAmount;
  final List<UpcomingPaymentItem> items;
  final String paymentDate;

  UpcomingPayments({
    required this.remainingDays,
    required this.today,
    required this.expired,
    required this.paymentAmount,
    required this.items,
    required this.paymentDate,
  });

  factory UpcomingPayments.fromJson(Map<String, dynamic> json) {
    return UpcomingPayments(
      remainingDays: json['remaining_days'] ?? 0,
      today: json['today'] ?? false,
      expired: json['expired'] ?? false,
      paymentAmount: (json['payment_amount'] ?? 0).toDouble(),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((item) => UpcomingPaymentItem.fromJson(item))
              .toList() ??
          [],
      paymentDate: json['payment_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'remaining_days': remainingDays,
      'today': today,
      'expired': expired,
      'payment_amount': paymentAmount,
      'items': items.map((item) => item.toJson()).toList(),
      'payment_date': paymentDate,
    };
  }
}

class UpcomingPaymentItem {
  final String accountNumber;
  final int remainingDays;
  final bool expired;
  final bool today;
  final String paymentDate;
  final double paymentAmount;
  final double principalAmount;
  final double percentageAmount;
  final double fineAmount;

  UpcomingPaymentItem({
    required this.accountNumber,
    required this.remainingDays,
    required this.expired,
    required this.today,
    required this.paymentDate,
    required this.paymentAmount,
    required this.principalAmount,
    required this.percentageAmount,
    required this.fineAmount,
  });

  factory UpcomingPaymentItem.fromJson(Map<String, dynamic> json) {
    return UpcomingPaymentItem(
      accountNumber: json['account_number'] ?? '',
      remainingDays: json['remaining_days'] ?? 0,
      expired: json['expired'] ?? false,
      today: json['today'] ?? false,
      paymentDate: json['payment_date'] ?? '',
      paymentAmount: (json['payment_amount'] ?? 0).toDouble(),
      principalAmount: (json['principal_amount'] ?? 0).toDouble(),
      percentageAmount: (json['percentage_amount'] ?? 0).toDouble(),
      fineAmount: (json['fine_amount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_number': accountNumber,
      'remaining_days': remainingDays,
      'expired': expired,
      'today': today,
      'payment_date': paymentDate,
      'payment_amount': paymentAmount,
      'principal_amount': principalAmount,
      'percentage_amount': percentageAmount,
      'fine_amount': fineAmount,
    };
  }
}
