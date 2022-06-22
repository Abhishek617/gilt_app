import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum CardType {
  visa,
  amex,
  discover,
  mastercard,
  dinersclub,
  jcb,
  unionpay,
  maestro,
  elo,
  mir,
  hiper,
  hipercard,
  unknown, // We'll use this when the card is invalid
}

/// CC prefix patterns as of March 2019
/// A [List<String>] represents a range.
/// i.e. ['51', '55'] represents the range of cards starting with '51' to those starting with '55'
const Map<CardType, Set<List<String>>> cardNumPatterns = {
  CardType.visa: {
    ['4'],
  },
  CardType.amex: {
    ['34'],
    ['37'],
  },
  CardType.discover: {
    ['6011'],
    ['644', '649'],
    ['65'],
  },
  CardType.mastercard: {
    ['51', '55'],
    ['2221', '2229'],
    ['223', '229'],
    ['23', '26'],
    ['270', '271'],
    ['2720'],
  },
  CardType.dinersclub: {
    ['300', '305'],
    ['36'],
    ['38'],
    ['39'],
  },
  CardType.jcb: {
    ['3528', '3589'],
    ['2131'],
    ['1800'],
  },
  CardType.unionpay: {
    ['620'],
    ['624', '626'],
    ['62100', '62182'],
    ['62184', '62187'],
    ['62185', '62197'],
    ['62200', '62205'],
    ['622010', '622999'],
    ['622018'],
    ['622019', '622999'],
    ['62207', '62209'],
    ['622126', '622925'],
    ['623', '626'],
    ['6270'],
    ['6272'],
    ['6276'],
    ['627700', '627779'],
    ['627781', '627799'],
    ['6282', '6289'],
    ['6291'],
    ['6292'],
    ['810'],
    ['8110', '8131'],
    ['8132', '8151'],
    ['8152', '8163'],
    ['8164', '8171'],
  },
  CardType.maestro: {
    ['493698'],
    ['500000', '506698'],
    ['506779', '508999'],
    ['56', '59'],
    ['63'],
    ['67'],
  },
  CardType.elo: {
    ['401178'],
    ['401179'],
    ['438935'],
    ['457631'],
    ['457632'],
    ['431274'],
    ['451416'],
    ['457393'],
    ['504175'],
    ['506699', '506778'],
    ['509000', '509999'],
    ['627780'],
    ['636297'],
    ['636368'],
    ['650031', '650033'],
    ['650035', '650051'],
    ['650405', '650439'],
    ['650485', '650538'],
    ['650541', '650598'],
    ['650700', '650718'],
    ['650720', '650727'],
    ['650901', '650978'],
    ['651652', '651679'],
    ['655000', '655019'],
    ['655021', '655058'],
  },
  CardType.mir: {
    ['2200', '2204'],
  },
  CardType.hiper: {
    ['637095'],
    ['637568'],
    ['637599'],
    ['637609'],
    ['637612'],
    ['63743358'],
    ['63737423'],
  },
  CardType.hipercard: {
    ['606282'],
  }
};

/// Finds non numeric characters
RegExp _nonNumeric = RegExp(r'\D+');

/// Finds whitespace in any form
RegExp _whiteSpace = RegExp(r'\s+\b|\b\s');

class CardUtils {
  /// This function determines the CC type based on the cardPatterns
  static CardType detectCCType(String ccNumStr) {
    CardType cardType = CardType.unknown;
    ccNumStr = ccNumStr.replaceAll(_whiteSpace, '');

    if (ccNumStr.isEmpty) {
      return cardType;
    }

    // Check that only numerics are in the string
    if (_nonNumeric.hasMatch(ccNumStr)) {
      return cardType;
    }

    cardNumPatterns.forEach(
      (CardType type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          // Remove any spaces
          String ccPatternStr = ccNumStr;
          int rangeLen = patternRange[0].length;
          // Trim the CC number str to match the pattern prefix length
          if (rangeLen < ccNumStr.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }

          if (patternRange.length > 1) {
            // Convert the prefix range into numbers then make sure the
            // CC num is in the pattern range.
            // Because Strings don't have '>=' type operators
            int ccPrefixAsInt = int.parse(ccPatternStr);
            int startPatternPrefixAsInt = int.parse(patternRange[0]);
            int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt &&
                ccPrefixAsInt <= endPatternPrefixAsInt) {
              // Found a match
              cardType = type;
              break;
            }
          } else {
            // Just compare the single pattern prefix with the CC prefix
            if (ccPatternStr == patternRange[0]) {
              // Found a match
              cardType = type;
              break;
            }
          }
        }
      },
    );

    return cardType;
  }

  static String getBrandName(CardType type) {
    switch (type) {
      case CardType.visa:
        return "visa";
      case CardType.amex:
        return "amex";
      case CardType.discover:
        return "discover";
      case CardType.mastercard:
        return "mastercard";
      case CardType.dinersclub:
        return "dinersclub";
      case CardType.jcb:
        return "jcb";
      case CardType.unionpay:
        return "unionpay";
      case CardType.maestro:
        return "maestro";
      case CardType.elo:
        return "elo";
      case CardType.mir:
        return "mir";
      case CardType.hiper:
        return "hiper";
      case CardType.hipercard:
        return "hipercard";
      default:
        return "unknown";
    }
  }

  /*static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(new RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.mastercard;
    } else if (input.startsWith(new RegExp(r'[4]'))) {
      cardType = CardType.visa;
    } else if (input
        .startsWith(new RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = CardType.verve;
    } else if (input.length <= 8) {
      cardType = CardType.others;
    } else {
      cardType = CardType.invalid;
    }
    return cardType;
  }*/

  static String? validateCardNumWithLuhnAlgorithm(String input) {
    if (input.isEmpty) {
      return "Invalid card";
    }

    input = getCleanedNumber(input);

    if (input.length < 8) {
      // No need to even proceed with the validation if it's less than 8 characters
      return "Invalid card";
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }

    return "Invalid card";
  }

  static String getCleanedNumber(String input) {
    String num = input.replaceAll(" ", "");
    return num;
  }

  static List<String> getExpiryDate(String value) {
    var split = value.split(new RegExp(r'(\/)'));
    return [split[0], split[1]];
  }

  static String getFormattedExpiryDate(String value) {
    if (value == null || value.length == 0) return "";
    if (value.length != 4) return value;
    return "${value[0]}${value[1]}/${value[2]}${value[3]}";
  }

  static String? validateDate(String value) {
    if (value.isEmpty) {
      return "Enter expiry date";
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(new RegExp(r'(\/)'))) {
      var split = value.split(new RegExp(r'(\/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return 'Expiry month is invalid';
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid year should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Expiry year is invalid';
    }

    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return !(month == null || year == null) && isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is less than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently, is greater than card's
    // year
    return fourDigitsYear < now.year;
  }

  static String getCardImage(int cardType) {
    if (cardType == CardType.mastercard.index) {
      return "assets/images/ic_master_card.png";
    } else if (cardType == CardType.visa.index) {
      return "assets/images/ic_visa_card.png";
    } else {
      return "assets/images/ic_card.png";
    }
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
