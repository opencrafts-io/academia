class MagnetFinancialTransaction {
  // Verisafe's user id
  final String userID;

  // The institution the student's profile is part of
  final int institutionID;

  final String transactionId;
  final double amount;
  final DateTime date;
  final String type; // e.g., "credit" or "debit"
  final String paymentMethod; // e.g., "mpesa", "card", "cash"
  final String studentId;
  final double balanceAfterTransaction;
  final String status; // e.g., "pending", "completed", "failed"
  final String currency;
  final String? description;
  final String? referenceNumber;
  final String? institutionId;

  MagnetFinancialTransaction({
    required this.institutionID,
    required this.userID,
    required this.transactionId,
    required this.amount,
    required this.date,
    required this.type,
    required this.paymentMethod,
    required this.studentId,
    required this.balanceAfterTransaction,
    required this.status,
    this.currency = "KES",
    this.description,
    this.referenceNumber,
    this.institutionId,
  });

  @override
  String toString() {
    return 'FinancialTransaction('
        'transactionId: $transactionId, '
        'amount: $amount, '
        'date: $date, '
        'type: $type, '
        'paymentMethod: $paymentMethod, '
        'studentId: $studentId, '
        'balanceAfterTransaction: $balanceAfterTransaction, '
        'status: $status, '
        'currency: $currency, '
        'description: $description, '
        'referenceNumber: $referenceNumber, '
        'institutionId: $institutionId'
        ')';
  }
}
