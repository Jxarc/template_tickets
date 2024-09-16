part of '../clg_date.dart';

class _CalendarValue {
  ValueNotifier<DateTime> lastDate = ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<DateTime> firstDate = ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<bool> monthModeActive = ValueNotifier<bool>(true);

  ValueNotifier<int> yearDisplayed = ValueNotifier<int>(0);
  ValueNotifier<int> monthDisplayed = ValueNotifier<int>(0);

  ValueNotifier<List<DateTime>> datesSelected = ValueNotifier<List<DateTime>>([]);

  toggleDate(DateTime date) {
    final newData = datesSelected.value;
    final index = contains(date);

    (index == -1) ? newData.add(date) : newData.removeAt(index);
    datesSelected.value = [...newData];
  }

  int contains(DateTime date) {
    final newData = datesSelected.value;

    for (int i = 0; i < newData.length; i++) {
      final selectDate = newData[i];
      if (selectDate.year == date.year && //
          selectDate.month == date.month &&
          selectDate.day == date.day) return i;
    }
    return -1;
  }

  bool containsYear(int year) {
    final newData = datesSelected.value;

    for (int i = 0; i < newData.length; i++) {
      final selectDate = newData[i];
      if (selectDate.year == year) return true;
    }
    return false;
  }

  bool containsMonth(DateTime date, int month) {
    final newData = datesSelected.value;

    for (int i = 0; i < newData.length; i++) {
      final selectDate = newData[i];
      if (selectDate.year == date.year && //
          selectDate.month == month) return true;
    }
    return false;
  }

  clearDates() {
    datesSelected.value = [];
  }
}
