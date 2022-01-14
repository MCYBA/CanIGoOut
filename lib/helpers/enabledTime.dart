
import 'package:intl/intl.dart';

import 'package:can_i_go_out/constant/Constant.dart';
import 'package:can_i_go_out/globals/main.dart';
import 'package:can_i_go_out/model/profile.dart';

getMostCloseTimeForJobless(DateTime now, ProfileModel profileModel) {
  if(now.weekday == 6 || now.weekday == 7) {
    if(now.weekday == 6) {
      DateTime enableDate = new DateTime(now.year, now.month, now.day + 2, 5);
      Duration difference = enableDate.difference(now);
      bool isClose =  difference.inMinutes <= 30;
      return [false, getFormatterCounter(difference), isClose];
    } else {
      DateTime enableDate = new DateTime(now.year, now.month, now.day + 1, 5);
      Duration difference = enableDate.difference(now);
      bool isClose =  difference.inMinutes <= 30;
      return [false, getFormatterCounter(difference), isClose];
    }
//    if(now.hour >= 10 && now.hour <= 20) {
//      DateTime disableDate = new DateTime(now.year, now.month, now.day, 20);
//      Duration difference = disableDate.difference(now);
//      bool isClose =  difference.inMinutes <= 30;
//      return [true, getFormatterCounter(difference), isClose];
//
//    } else {
//      if(now.hour < 10) {
//        DateTime enableDate = new DateTime(now.year, now.month, now.day, 10);
//        Duration difference = enableDate.difference(now);
//        bool isClose =  difference.inMinutes <= 30;
//        return [false, getFormatterCounter(difference), isClose];
//      } else {
//
//        if(now.weekday == 6) {
//          DateTime enableDate = new DateTime(now.year, now.month, now.day + 1, 10);
//          Duration difference = enableDate.difference(now);
//          bool isClose =  difference.inMinutes <= 30;
//          return [false, getFormatterCounter(difference), isClose];
//        } else {
//          if(profileModel.age >= 65) {
//            DateTime enableDate = new DateTime(now.year, now.month, now.day + 1, 10);
//            Duration difference = enableDate.difference(now);
//            bool isClose =  difference.inMinutes <= 30;
//            return [false, getFormatterCounter(difference), isClose];
//          } else if(profileModel.age <= 20) {
//            DateTime enableDate = new DateTime(now.year, now.month, now.day + 1, 13);
//            Duration difference = enableDate.difference(now);
//            bool isClose =  difference.inMinutes <= 30;
//            return [false, getFormatterCounter(difference), isClose];
//          } else {
//            DateTime enableDate = new DateTime(now.year, now.month, now.day + 1, 5);
//            Duration difference = enableDate.difference(now);
//            bool isClose =  difference.inMinutes <= 30;
//            return [false, getFormatterCounter(difference), isClose];
//          }
//        }
//      }
//    }
  } else {
    //in weekdays
    if(profileModel.age >= 65) {
      if(now.hour >= 10 && now.hour < 13) {
        DateTime disableDate = new DateTime(now.year, now.month, now.day, 13);
        Duration difference = disableDate.difference(now);
        bool isClose =  difference.inMinutes <= 30;
        return [true, getFormatterCounter(difference), isClose];
      } else {
        if(now.hour < 10) {
          DateTime enableDate = new DateTime(now.year, now.month, now.day , 10);
          Duration difference = enableDate.difference(now);
          bool isClose =  difference.inMinutes <= 30;
          return [false, getFormatterCounter(difference), isClose];
        } else {
          if(now.weekday != 5) {
            DateTime enableDate = new DateTime(now.year, now.month, now.day + 1, 10);
            Duration difference = enableDate.difference(now);
            bool isClose =  difference.inMinutes <= 30;
            return [false, getFormatterCounter(difference), isClose];
          } else {
            DateTime enableDate = new DateTime(now.year, now.month, now.day + (DateTime.sunday - now.weekday) + 1, 10);
            Duration difference = enableDate.difference(now);
            bool isClose =  difference.inMinutes <= 30;
            return [false, getFormatterCounter(difference), isClose];
          }
        }
      }
    } else if(profileModel.age <= 20) {
      if(now.hour >= 13 && now.hour <= 16) {
        DateTime disableDate = new DateTime(now.year, now.month, now.day, 16);
        Duration difference = disableDate.difference(now);
        bool isClose =  difference.inMinutes <= 30;
        return [true, getFormatterCounter(difference), isClose];
      } else {
        if(now.hour < 13) {
          DateTime enableDate = new DateTime(now.year, now.month, now.day, 13);
          Duration difference = enableDate.difference(now);
          bool isClose =  difference.inMinutes <= 30;
          return [false, getFormatterCounter(difference), isClose];
        } else {
          if(now.weekday != 5) {
            DateTime enableDate = new DateTime(now.year, now.month, now.day + 1, 10);
            Duration difference = enableDate.difference(now);
            bool isClose =  difference.inMinutes <= 30;
            return [false, getFormatterCounter(difference), isClose];
          } else {
            DateTime enableDate = new DateTime(now.year, now.month, now.day + (DateTime.sunday - now.weekday) + 1, 13);
            Duration difference = enableDate.difference(now);
            bool isClose =  difference.inMinutes <= 30;
            return [false, getFormatterCounter(difference), isClose];
          }
        }
      }
    } else {
      if(now.hour >= 5 && now.hour <= 21) {
        DateTime disableDate = new DateTime(now.year, now.month, now.day, 21);
        Duration difference = disableDate.difference(now);
        bool isClose =  difference.inMinutes <= 30;
        return [true, getFormatterCounter(difference), isClose];
      } else {
        if(now.hour < 5) {
          DateTime enableDate = new DateTime(now.year, now.month, now.day, 5);
          Duration difference = enableDate.difference(now);
          bool isClose =  difference.inMinutes <= 30;
          return [false, getFormatterCounter(difference), isClose];
        } else {
          if(now.weekday != 5) {
            DateTime enableDate = new DateTime(now.year, now.month, now.day + 1, 5);
            Duration difference = enableDate.difference(now);
            bool isClose =  difference.inMinutes <= 30;
            return [false, getFormatterCounter(difference), isClose];
          } else {
            DateTime enableDate = new DateTime(now.year, now.month, now.day + (DateTime.sunday - now.weekday) + 1, 5);
            Duration difference = enableDate.difference(now);
            bool isClose =  difference.inMinutes <= 30;
            return [false, getFormatterCounter(difference), isClose];
          }
        }
      }
    }
  }
}

List getMostCloseTime(ProfileModel profileModel) {
  DateTime now = new DateTime.now();

  if(profileModel.hasWork) {
    bool isNowInWorkDays = false;
    for(int workDay in profileModel.workDays) {
      if(workDay == now.weekday) {
        isNowInWorkDays = true;
        int firstDisableDay;
        int nextDay = now.weekday + 1;
        if(now.weekday == 7) {
          nextDay = 1;
        }
        for(int i = 0; i < 6; i++) {

          if(!profileModel.workDays.contains(nextDay)) {
            firstDisableDay = nextDay;
            break;
          }

          nextDay++;
          if(nextDay > 7) {
            nextDay = 1;
          }

        }

        if(firstDisableDay != null) {
          int diff = firstDisableDay - now.weekday;
          if(now.weekday > firstDisableDay) {
            diff %= 7;
          }

          if(firstDisableDay == 6 || firstDisableDay == 7) {
            DateTime disableDate = new DateTime(now.year, now.month, now.day + diff, 5);
            Duration difference = disableDate.difference(now);
            bool isClose =  difference.inMinutes <= 30;
            return [true, getFormatterCounter(difference), isClose];
          } else {
            if(profileModel.age >= 65) {
              DateTime disableDate = new DateTime(now.year, now.month, now.day + diff, 5);
              Duration difference = disableDate.difference(now);
              bool isClose =  difference.inMinutes <= 30;
              return [true, getFormatterCounter(difference), isClose];
            } else if(profileModel.age <= 20) {
              DateTime disableDate = new DateTime(now.year, now.month, now.day + diff, 5);
              Duration difference = disableDate.difference(now);
              bool isClose =  difference.inMinutes <= 30;
              return [true, getFormatterCounter(difference), isClose];
            } else {
              DateTime disableDate = new DateTime(now.year, now.month, now.day + diff, 5);
              Duration difference = disableDate.difference(now);
              bool isClose =  difference.inMinutes <= 30;
              return [true, getFormatterCounter(difference), isClose];
            }
          }

        } else {
          //      DateTime disableDate = new DateTime(now.year, now.month, now.day);
          Duration difference = now.difference(now);
          bool isClose =  difference.inMinutes <= 30;
          return [true, getFormatterCounter(difference), isClose];
        }
      }

    }
    if(!isNowInWorkDays) {

      int firstEnableDay;
      int nextDay = now.weekday + 1;
      if(now.weekday == 7) {
        nextDay = 1;
      }
      for(int i = 0; i < 6; i++) {

        if(profileModel.workDays.contains(nextDay)) {
          firstEnableDay = nextDay;
          break;
        }

        nextDay++;
        if(nextDay > 7) {
          nextDay = 1;
        }

      }

      if(firstEnableDay != null) {
        int diff = firstEnableDay - now.weekday;
        if(now.weekday > firstEnableDay) {
          diff %= 7;
        }
        if(now.weekday == 6 || now.weekday == 7) {
          DateTime enableDate = new DateTime(now.year, now.month, now.day + diff, 5);
          Duration difference = enableDate.difference(now);
          bool isClose =  difference.inMinutes <= 30;
          return [false, getFormatterCounter(difference), isClose];
        } else if(now.weekday == 5) {
          if(profileModel.age >= 65) {
            if(now.hour >= 10 && now.hour < 13) {
              DateTime disableDate = new DateTime(now.year, now.month, now.day, 13);
              Duration difference = disableDate.difference(now);
              bool isClose =  difference.inMinutes <= 30;
              return [true, getFormatterCounter(difference), isClose];
            } else {
              if(now.hour < 10) {
                DateTime enableDate = new DateTime(now.year, now.month, now.day , 10);
                Duration difference = enableDate.difference(now);
                bool isClose =  difference.inMinutes <= 30;
                return [false, getFormatterCounter(difference), isClose];
              } else {
                if(diff > 3) {
                  DateTime enableDate = new DateTime(now.year, now.month, now.day + 3, 10);
                  Duration difference = enableDate.difference(now);
                  bool isClose =  difference.inMinutes <= 30;
                  return [false, getFormatterCounter(difference), isClose];
                } else {
                  DateTime enableDate = new DateTime(now.year, now.month, now.day + diff, 0);
                  Duration difference = enableDate.difference(now);
                  bool isClose =  difference.inMinutes <= 30;
                  return [false, getFormatterCounter(difference), isClose];
                }

              }
            }
          } else if(profileModel.age <= 20) {
            if(now.hour >= 13 && now.hour <= 16) {
              DateTime disableDate = new DateTime(now.year, now.month, now.day, 16);
              Duration difference = disableDate.difference(now);
              bool isClose =  difference.inMinutes <= 30;
              return [true, getFormatterCounter(difference), isClose];
            } else {
              if(now.hour < 13) {
                DateTime enableDate = new DateTime(now.year, now.month, now.day, 13);
                Duration difference = enableDate.difference(now);
                bool isClose =  difference.inMinutes <= 30;
                return [false, getFormatterCounter(difference), isClose];
              } else {
                if(diff > 3) {
                  DateTime enableDate = new DateTime(now.year, now.month, now.day + 3, 13);
                  Duration difference = enableDate.difference(now);
                  bool isClose =  difference.inMinutes <= 30;
                  return [false, getFormatterCounter(difference), isClose];
                } else {
                  DateTime enableDate = new DateTime(now.year, now.month, now.day + diff, 0);
                  Duration difference = enableDate.difference(now);
                  bool isClose =  difference.inMinutes <= 30;
                  return [false, getFormatterCounter(difference), isClose];
                }
              }
            }
          } else {
            if(now.hour >= 5 && now.hour <= 21) {
              DateTime disableDate = new DateTime(now.year, now.month, now.day, 21);
              Duration difference = disableDate.difference(now);
              bool isClose =  difference.inMinutes <= 30;
              return [true, getFormatterCounter(difference), isClose];
            } else {
              if(now.hour < 5) {
                DateTime enableDate = new DateTime(now.year, now.month, now.day, 5);
                Duration difference = enableDate.difference(now);
                bool isClose =  difference.inMinutes <= 30;
                return [false, getFormatterCounter(difference), isClose];
              } else {
                if(diff > 3) {
                  DateTime enableDate = new DateTime(now.year, now.month, now.day + 3, 5);
                  Duration difference = enableDate.difference(now);
                  bool isClose =  difference.inMinutes <= 30;
                  return [false, getFormatterCounter(difference), isClose];
                } else {
                  DateTime enableDate = new DateTime(now.year, now.month, now.day + diff, 0);
                  Duration difference = enableDate.difference(now);
                  bool isClose =  difference.inMinutes <= 30;
                  return [false, getFormatterCounter(difference), isClose];
                }
              }
            }
          }
        } else {
          if(profileModel.age >= 65) {
            DateTime enableDate = new DateTime(now.year, now.month, now.day + 1, 10);
            Duration difference = enableDate.difference(now);
            bool isClose =  difference.inMinutes <= 30;
            return [false, getFormatterCounter(difference), isClose];
          } else if(profileModel.age <= 20) {
            DateTime enableDate = new DateTime(now.year, now.month, now.day + 1, 13);
            Duration difference = enableDate.difference(now);
            bool isClose =  difference.inMinutes <= 30;
            return [false, getFormatterCounter(difference), isClose];
          } else {

            if(now.hour >= 5 && now.hour <= 21) {
              DateTime disableDate = new DateTime(now.year, now.month, now.day, 21);
              Duration difference = disableDate.difference(now);
              bool isClose =  difference.inMinutes <= 30;
              return [true, getFormatterCounter(difference), isClose];
            } else {
              if(now.hour < 5) {
                DateTime enableDate = new DateTime(now.year, now.month, now.day, 5);
                Duration difference = enableDate.difference(now);
                bool isClose =  difference.inMinutes <= 30;
                return [false, getFormatterCounter(difference), isClose];
              } else {
                DateTime enableDate = new DateTime(now.year, now.month, now.day + 1, 5);
                Duration difference = enableDate.difference(now);
                bool isClose =  difference.inMinutes <= 30;
                return [false, getFormatterCounter(difference), isClose];
              }
            }
          }
        }
      } else {
        return getMostCloseTimeForJobless(now, profileModel);
      }
    }

  } else {
    return getMostCloseTimeForJobless(now, profileModel);
  }
}


String getFormatterCounter(Duration difference) {

  String time = "";

  int hours = difference.inHours;

  if(hours < 10) {
    time += "0$hours:";
  } else {
    time += "$hours:";
  }

  int minutes = difference.inMinutes % 60;

  if(minutes < 10) {
    time += "0$minutes:";
  } else {
    time += "$minutes:";
  }

  int seconds = difference.inSeconds % 60;

  if(seconds < 10) {
    time += "0$seconds";
  } else {
    time += "$seconds";
  }

  return time;
}

List<List<int>> getCalender(ProfileModel profileModel) {
  // 0 mean enabled day, 1 mean disabled day.

  List<int> monHourSignList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> tueHourSignList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> wedHourSignList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> thuHourSignList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> friHourSignList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> satHourSignList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> sunHourSignList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  if(!profileModel.workDays.contains(1)) {
    if(profileModel.age >= 65) {
      for(int i = 0; i< monHourSignList.length; i++) {
        if(i != 9 && i != 10 && i != 11) {
          monHourSignList[i] = 1;
        }
      }
    } else if(profileModel.age <= 20) {
      for(int i = 0; i< monHourSignList.length; i++) {
        if(i != 12 && i != 13 && i != 14) {
          monHourSignList[i] = 1;
        }
      }
    }

    monHourSignList[0] = 1; monHourSignList[1] = 1; monHourSignList[2] = 1;
    monHourSignList[3] = 1; monHourSignList[4] = 1; monHourSignList[21] = 1;
    monHourSignList[22] = 1; monHourSignList[23] = 1;
  }

  if(!profileModel.workDays.contains(2)) {
    if(profileModel.age >= 65) {
      for(int i = 0; i< tueHourSignList.length; i++) {
        if(i != 9 && i != 10 && i != 11) {
          tueHourSignList[i] = 1;
        }
      }
    } else if(profileModel.age <= 20) {
      for(int i = 0; i< tueHourSignList.length; i++) {
        if(i != 12 && i != 13 && i != 14) {
          tueHourSignList[i] = 1;
        }
      }
    }
    tueHourSignList[0] = 1; tueHourSignList[1] = 1; tueHourSignList[2] = 1;
    tueHourSignList[3] = 1; tueHourSignList[4] = 1; tueHourSignList[21] = 1;
    tueHourSignList[22] = 1; tueHourSignList[23] = 1;
  }

  if(!profileModel.workDays.contains(3)) {
    if(profileModel.age >= 65) {
      for(int i = 0; i< wedHourSignList.length; i++) {
        if(i != 9 && i != 10 && i != 11) {
          wedHourSignList[i] = 1;
        }
      }
    } else if(profileModel.age <= 20) {
      for(int i = 0; i< wedHourSignList.length; i++) {
        if(i != 12 && i != 13 && i != 14) {
          wedHourSignList[i] = 1;
        }
      }
    }
    wedHourSignList[0] = 1; wedHourSignList[1] = 1; wedHourSignList[2] = 1;
    wedHourSignList[3] = 1; wedHourSignList[4] = 1; wedHourSignList[21] = 1;
    wedHourSignList[22] = 1; wedHourSignList[23] = 1;
  }

  if(!profileModel.workDays.contains(4)) {
    if(profileModel.age >= 65) {
      for(int i = 0; i< thuHourSignList.length; i++) {
        if(i != 9 && i != 10 && i != 11) {
          thuHourSignList[i] = 1;
        }
      }
    } else if(profileModel.age <= 20) {
      for(int i = 0; i< thuHourSignList.length; i++) {
        if(i != 12 && i != 13 && i != 14) {
          thuHourSignList[i] = 1;
        }
      }
    }
    thuHourSignList[0] = 1; thuHourSignList[1] = 1; thuHourSignList[2] = 1;
    thuHourSignList[3] = 1; thuHourSignList[4] = 1; thuHourSignList[21] = 1;
    thuHourSignList[22] = 1; thuHourSignList[23] = 1;
  }

  if(!profileModel.workDays.contains(5)) {
//    if(profileModel.age >= 65) {
//      for(int i = 0; i< friHourSignList.length; i++) {
//        if(i != 9 && i != 10 && i != 11) {
//          friHourSignList[i] = 1;
//        }
//      }
//    } else if(profileModel.age <= 20) {
//      for(int i = 0; i< friHourSignList.length; i++) {
//        if(i != 12 && i != 13 && i != 14) {
//          friHourSignList[i] = 1;
//        }
//      }
//    }
    friHourSignList[0] = 1; friHourSignList[1] = 1; friHourSignList[2] = 1;
    friHourSignList[3] = 1; friHourSignList[4] = 1; friHourSignList[21] = 1;
    friHourSignList[22] = 1; friHourSignList[23] = 1;
  }

  if(!profileModel.workDays.contains(6)) {
//    satHourSignList[0] = 1; satHourSignList[1] = 1; satHourSignList[2] = 1;
//    satHourSignList[3] = 1; satHourSignList[4] = 1; satHourSignList[5] = 1;
//    satHourSignList[6] = 1; satHourSignList[7] = 1; satHourSignList[8] = 1;
//    satHourSignList[20] = 1; satHourSignList[21] = 1; satHourSignList[22] = 1;
//    satHourSignList[23] = 1;

    satHourSignList = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

  }

  if(!profileModel.workDays.contains(7)) {
//    sunHourSignList[0] = 1; sunHourSignList[1] = 1; sunHourSignList[2] = 1;
//    sunHourSignList[3] = 1; sunHourSignList[4] = 1; sunHourSignList[5] = 1;
//    sunHourSignList[6] = 1; sunHourSignList[7] = 1; sunHourSignList[8] = 1;
//    sunHourSignList[20] = 1; sunHourSignList[21] = 1; sunHourSignList[22] = 1;
//    sunHourSignList[23] = 1;

    sunHourSignList = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
  }

  return [monHourSignList, tueHourSignList, wedHourSignList, thuHourSignList, friHourSignList, satHourSignList, sunHourSignList];
}