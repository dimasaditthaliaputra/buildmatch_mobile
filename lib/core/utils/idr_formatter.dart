class IdrFormatter {
  IdrFormatter._();

  static String formatRupiah(double amount) {
    if (amount >= 1000000000) {
      return 'Rp ${(amount / 1000000000).toStringAsFixed(1)} M';
    } else if (amount >= 1000000) {
      return 'Rp ${(amount / 1000000).toStringAsFixed(0)} Jt';
    } else if (amount >= 1000) {
      return 'Rp ${(amount / 1000).toStringAsFixed(0)} Rb';
    }
    return 'Rp ${amount.toStringAsFixed(0)}';
  }

  static String formatRupiahShort(double amount) {
    if (amount >= 1000000000) {
      return 'Rp ${(amount / 1000000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000000) {
      return 'Rp ${(amount / 1000000).toStringAsFixed(0)}Jt';
    } else if (amount >= 1000) {
      return 'Rp ${(amount / 1000).toStringAsFixed(0)}Rb';
    }
    return 'Rp ${amount.toStringAsFixed(0)}';
  }

  static String formatRupiahRange(double min, double max) {
    return '${formatRupiahShort(min)} – ${formatRupiahShort(max)}';
  }

  static String formatFull(double amount) {
    final parts = amount.toStringAsFixed(0).split('');
    final result = <String>[];
    for (int i = 0; i < parts.length; i++) {
      if (i > 0 && (parts.length - i) % 3 == 0) {
        result.add('.');
      }
      result.add(parts[i]);
    }
    return 'Rp ${result.join()}';
  }
}