/// The plan or product to add to an existing order.
class CreateOrderItemRequest {
  const CreateOrderItemRequest({
    required this.orderId,
    required this.planId,
    required this.quantity,
    required this.unitPrice,
    this.discount = 0,
    this.tax = 0,
    this.addedBy,
  });

  final String orderId;
  final int planId;
  final int quantity;
  final int unitPrice;
  final int discount;
  final int tax;
  final String? addedBy;
}
