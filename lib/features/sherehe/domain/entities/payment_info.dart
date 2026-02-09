import 'package:equatable/equatable.dart';

class PaymentInfo extends Equatable {
  final String id;
  final String paymentType;
  final String? paybillNumber;
  final String? paybillAccountNumber;
  final String? tillNumber;
  final String? phoneNumber;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  const PaymentInfo({
    required this.id,
    required this.paymentType,
    required this.paybillNumber,
    required this.paybillAccountNumber,
    required this.tillNumber,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  PaymentInfo copyWith({
    String? id,
    String? paymentType,
    String? paybillNumber,
    String? paybillAccountNumber,
    String? tillNumber,
    String? phoneNumber,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return PaymentInfo(
      id: id ?? this.id,
      paymentType: paymentType ?? this.paymentType,
      paybillNumber: paybillNumber ?? this.paybillNumber,
      paybillAccountNumber: paybillAccountNumber ?? this.paybillAccountNumber,
      tillNumber: tillNumber ?? this.tillNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    paymentType,
    paybillNumber,
    paybillAccountNumber,
    tillNumber,
    phoneNumber,
    createdAt,
    updatedAt,
    deletedAt,
  ];

  @override
  bool? get stringify => true;
}
