import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum DonationType { TRANSFER, CRYPTO, PAYPAL, CASH, SMS }

extension DonationTypeFields on DonationType {

  // ignore: missing_return
  IconData get iconData {
    switch (this) {
      case DonationType.TRANSFER:
        return FontAwesomeIcons.moneyCheckAlt;
      case DonationType.CRYPTO:
        return FontAwesomeIcons.bitcoin;
      case DonationType.PAYPAL:
        return FontAwesomeIcons.paypal;
      case DonationType.CASH:
        return FontAwesomeIcons.moneyBillAlt;
      case DonationType.SMS:
        return FontAwesomeIcons.sms;
    }
  }

  // ignore: missing_return
  String get title {
    switch (this) {
      case DonationType.TRANSFER:
        return 'transfer_title';
      case DonationType.CRYPTO:
        return 'crypto_title';
      case DonationType.PAYPAL:
        return 'paypal_title';
      case DonationType.CASH:
        return 'cash_title';
      case DonationType.SMS:
        return 'sms_title';
    }
  }

  // ignore: missing_return
  String get body {
    switch (this) {
      case DonationType.TRANSFER:
        return 'transfer_description';
      case DonationType.CRYPTO:
        return 'crypto_description';
      case DonationType.PAYPAL:
        return 'paypal_description';
      case DonationType.CASH:
        return 'cash_description';
      case DonationType.SMS:
        return 'sms_description';
    }
  }
}
