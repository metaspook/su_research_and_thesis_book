// Copyright (c) 2023, Metaspook.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

class Validator {
  // This constructor prevents instantiation and extension as this class meant be.
  const Validator._();

  /// * Doesn't have leading or trailing white space.
  /// * Only word characters, underscores, hyphens, and periods.
  /// * Characters limit: 3 to 50.
  /// * Word must be Capitalized or with Uppercase letters.
  /// * Single space allowed after every word.
//   static const _leadingOrTrailingSpace = 'Leading or trailing space found!';
//   static const _onlyAlphabetsHyphensPeriods =
//       'Supports only alphabets, hyphens and periods!';
//   static const _capitalizedOrUppercased =
//       'Word must be Capitalized or with Uppercase letters!';
//   static const _singleSpaceAllowed = 'Single space allowed after every word.';

// static const _tldlimit = 'TLD Characters limit: 2 to 7';
// static String _limit(int max, [int min = 1])=> 'Characters limit: $min to $max';
// Validator list
  static String? name(String? value, {String? errorText}) =>
      (value == null || value.isName)
          ? null
          : errorText ?? 'Invalid Name format!';

  static String? email(String? value, {String? errorText}) =>
      (value == null || value.isEmail)
          ? null
          : errorText ?? 'Invalid Email format!';
  static String? password(String? value, {String? errorText}) =>
      (value == null || value.isPassword)
          ? null
          : errorText ?? 'Invalid Password format!';
  static String? phone(String? value, {String? errorText}) =>
      (value == null || value.isPhone)
          ? null
          : errorText ?? 'Invalid Phone format!';
}

extension ValidationExt on String {
  bool get isName => RegExp(RegExpPattern.name).hasMatch(this);
  bool get isEmail => RegExp(RegExpPattern.email).hasMatch(this);
  bool get isPassword => RegExp(RegExpPattern.password).hasMatch(this);
  bool get isPhone => RegExp(RegExpPattern.phone).hasMatch(this);
}

class RegExpPattern {
  const RegExpPattern._();
  // Character ranges.
  static const _lower = 'a-z';
  static const _upper = 'A-Z';
  static const _alpha = _lower + _upper;
  static const _digit = r'\d';
  static const _alphaNum = _alpha + _digit;
  static const _special = '-+*/>=<_.,;:!?"^`\'@#%\$&( ){~}[\\]|';
  static const _alphaNumSpecial = _alphaNum + _special;

  //-- Public APIs
  // Basic Patterns.
  static const lower = '^[$_lower]+\$';
  static const upper = '^[$_upper]+\$';
  static const alpha = '^[$_alpha]+\$';
  static const digit = '^$_digit+\$';
  static const alphaNum = '^[$_alphaNum]+\$';
  static const special = '^[$_special]+\$';
  static const alphaNumSpecial = '^[$_alphaNumSpecial]+\$';

  // Advanced Patterns.
  static const alphaNum10 = '^[_$alphaNum]{10}\$';
  static const duplicate = r'(.).*\1';

  /// * Doesn't have leading or trailing white space.
  /// * Only word characters, underscores, hyphens, and periods.
  /// * Characters limit: 3 to 50.
  /// * Word must be Capitalized or with Uppercase letters.
  /// * Single space allowed after every word.
  static const name = r'^(?=.{3,50}$)[A-Z][\w\-.]*(?: [A-Z][\w\-.]*)*$';

  /// * Doesn't have leading or trailing white space.
  /// * Only word characters, underscores, hyphens, and periods.
  /// * Characters limit: 1 to 51.
  /// * TLD Characters limit: 2 to 7.
  static const email = r'^(?=.{1,51}$)[\w\.-]+@[\w\.-]+\.\w{2,7}$';

  /// * Doesn't have any white space.
  /// * Support Country extension `+` prefix.
  /// * Support `(xxx)` local area code .
  /// * Characters limit: 30.
  static const phone =
      r'^(?=.{1,30}$)(?:\+?(\d{1,3}))?([-.(]*(\d{3})[-.)]*)?((\d{3})[-.]*(\d{2,4})(?:[-.x]*(\d+))?)$';

  /// * Doesn't have vertical (new line) white space.
  /// * Require at least one uppercase letter.
  /// * Require at least one lowercase letter.
  /// * Require at least one digit.
  /// * Require at least one special character of following:
  /// * `-+*/>=<_.,;:!?"^`\'@#%\$&( ){~}[\\]|`\`
  /// * Characters limit: 8 to 30.
  static const password =
      '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$_special])[a-zA-Z\\d\\$_special]{8,30}\$';
}
