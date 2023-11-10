const String currencySymbol = '৳';

abstract final class OrderStatus {
  static const pending = 'Pending';
  static const delivered = 'Delivered';
  static const processing = 'Processing';
  static const cancelled = 'Cancelled';
}