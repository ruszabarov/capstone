class Transaction {
  final String type;
  final String fromAddress;
  final String toAddress;
  final int nonce;
  final double amount;
  final int gasLimit;
  final int gasUsed;
  final double baseFee;
  final double priorityFee;
  final double totalGasFee;
  final double maxFeePerGas;
  final double total;
  final String date;

  Transaction(
      this.type,
      this.fromAddress,
      this.toAddress,
      this.nonce,
      this.amount,
      this.gasLimit,
      this.gasUsed,
      this.baseFee,
      this.priorityFee,
      this.maxFeePerGas,
      this.totalGasFee,
      this.total,
      this.date);
}

Transaction one = Transaction(
    'incoming',
    '0x1541ljkfas523',
    '0xaalfkj3398u1',
    0,
    0.02,
    2100,
    2100,
    0.00000015,
    1.5,
    0.00000031,
    0.0000000002,
    0.0200315,
    '14 December 2022');

Transaction two = Transaction(
    'outgoing',
    '0xaalfkj3398u1',
    '0x1541ljkfas523',
    0,
    0.02,
    2100,
    2100,
    0.00000015,
    1.5,
    0.00000031,
    0.0000000002,
    0.0200315,
    '14 December 2022');

List<Transaction> transactions = [one, two, one, one, one];
