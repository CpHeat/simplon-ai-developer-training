import 'dart:math';

// class to generate a random date
class RandomDate {
  int _startYear;
  int _endYear;

  RandomDate.withRange(this._startYear, this._endYear);

  // generate random date for given options
  DateTime random() {
    if (_endYear < _startYear) {
      throw ArgumentError('Start year cannot be less then End year');
    }
    // when start and end year are equal, add one to end year if not leapYear
    if (_startYear == _endYear) _endYear += 1;
    var _random = Random();
    // generate year
    var _randYear = _generateRandomYear();
    // generate random month
    var _randMonthInt = _random.nextInt(12) + 1;
    // generate random day
    var _randDay = _random.nextInt(_maxDays(_randYear, _randMonthInt));
    // this is a valid day, month and year.
    return DateTime(_randYear, _randMonthInt, _randDay);
  }

  // generate random year for given range and flag to include/exclude leap years
  int _generateRandomYear() {
    return _startYear + Random().nextInt(_endYear - _startYear);
  }

  // max number of days for given year and month
  int _maxDays(int year, int month) {
    var maxDaysMonthList = <int>[4, 6, 9, 11];
    if (month == 2) {
      return _isLeapYear(year) ? 29 : 28;
    } else {
      return maxDaysMonthList.contains(month) ? 30 : 31;
    }
  }

// is year a leap
  bool _isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
}

/// Date options
class RandomDateOptions {
  // by default include leap years
  bool excludeLeapYear = false;
  int addYearsToCurrent = 5;

  // named constructor modifying default value
  RandomDateOptions.withDefaultYearsToCurrent(this.addYearsToCurrent);

  // named constructor modifying default value
  RandomDateOptions.excludeLeapYears() {
    excludeLeapYear = true;
  }

  // default constructor
  RandomDateOptions.withValues(this.excludeLeapYear, this.addYearsToCurrent);

  RandomDateOptions();
}
