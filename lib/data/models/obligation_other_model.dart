class ObligationOtherModel {
  final String customerName;
  final String transitGEL;
  final int transitBalance;
  final int expense;
  final List<dynamic> expenseDetail;
  final double taxAmount;
  final List<Loan> loans;
  final Upcoming upcoming;

  ObligationOtherModel({
    required this.customerName,
    required this.transitGEL,
    required this.transitBalance,
    required this.expense,
    required this.expenseDetail,
    required this.taxAmount,
    required this.loans,
    required this.upcoming,
  });

  factory ObligationOtherModel.fromJson(Map<String, dynamic> json) {
    final loansData = json['loans'];

    List<Loan> loansList = [];
    if (loansData != null) {
      if (loansData is List<dynamic>) {
        loansList = loansData.map((loan) => Loan.fromJson(loan)).toList();
      } else {
        print('Warning: loans data is not a list: $loansData');
      }
    } else {
      print('Warning: loans data is null');
    }

    return ObligationOtherModel(
      customerName: json['customerName'] ?? '',
      transitGEL: json['transit_GEL'] ?? '',
      transitBalance: json['transit_balance'] ?? 0,
      expense: json['expense'] ?? 0,
      expenseDetail: json['expense_detail'] ?? [],
      taxAmount: (json['tax_amount'] ?? 0).toDouble(),
      loans: loansList,
      upcoming: Upcoming.fromJson(json['upcoming'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'transit_GEL': transitGEL,
      'transit_balance': transitBalance,
      'expense': expense,
      'expense_detail': expenseDetail,
      'tax_amount': taxAmount,
      'loans': loans.map((loan) => loan.toJson()).toList(),
      'upcoming': upcoming.toJson(),
    };
  }
}

class Loan {
  final String accountNumber;
  final double principalDue;
  final double interestDue;
  final double penalty;
  final double sumAmount;
  final String description;
  final String repaymentDate;
  final String currency;
  final int openingBalance;
  final int arrearsDays;
  final String issueDate;
  final int issueAmount;
  final double? effectiveIntRate;
  final int issueFeeAmount;

  Loan({
    required this.accountNumber,
    required this.principalDue,
    required this.interestDue,
    required this.penalty,
    required this.sumAmount,
    required this.description,
    required this.repaymentDate,
    required this.currency,
    required this.openingBalance,
    required this.arrearsDays,
    required this.issueDate,
    required this.issueAmount,
    this.effectiveIntRate,
    required this.issueFeeAmount,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      accountNumber: json['account_number'] ?? '',
      principalDue: (json['principalDue'] ?? 0).toDouble(),
      interestDue: (json['interestDue'] ?? 0).toDouble(),
      penalty: (json['penalty'] ?? 0).toDouble(),
      sumAmount: (json['sum_amount'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      repaymentDate: json['repayment_date'] ?? '',
      currency: json['currency'] ?? '',
      openingBalance: json['openingBalance'] ?? 0,
      arrearsDays: json['arrearsDays'] ?? 0,
      issueDate: json['IssueDate'] ?? '',
      issueAmount: json['IssueAmount'] ?? 0,
      effectiveIntRate: json['effective_int_Rate']?.toDouble(),
      issueFeeAmount: json['issue_fee_amount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_number': accountNumber,
      'principalDue': principalDue,
      'interestDue': interestDue,
      'penalty': penalty,
      'sum_amount': sumAmount,
      'description': description,
      'repayment_date': repaymentDate,
      'currency': currency,
      'openingBalance': openingBalance,
      'arrearsDays': arrearsDays,
      'IssueDate': issueDate,
      'IssueAmount': issueAmount,
      'effective_int_Rate': effectiveIntRate,
      'issue_fee_amount': issueFeeAmount,
    };
  }
}

class Upcoming {
  final int remainingDays;
  final bool today;
  final bool expired;
  final double paymentAmount;
  final List<UpcomingItem> items;
  final String paymentDate;

  Upcoming({
    required this.remainingDays,
    required this.today,
    required this.expired,
    required this.paymentAmount,
    required this.items,
    required this.paymentDate,
  });

  factory Upcoming.fromJson(Map<String, dynamic> json) {
    return Upcoming(
      remainingDays: json['remaining_days'] ?? 0,
      today: json['today'] ?? false,
      expired: json['expired'] ?? false,
      paymentAmount: (json['payment_amount'] ?? 0).toDouble(),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((item) => UpcomingItem.fromJson(item))
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

class UpcomingItem {
  final String accountNumber;
  final int remainingDays;
  final bool expired;
  final bool today;
  final String paymentDate;
  final double paymentAmount;
  final double principalAmount;
  final double percentageAmount;
  final double fineAmount;

  UpcomingItem({
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

  factory UpcomingItem.fromJson(Map<String, dynamic> json) {
    return UpcomingItem(
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
