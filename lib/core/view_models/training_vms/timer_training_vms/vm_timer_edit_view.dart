import 'package:flutter/material.dart';
import 'package:workout_timers/core/enums/countdown_alarms.dart';
import 'package:workout_timers/ui/components/others/our_dialog.dart';

import '../../../../ui/views/training_views/timer_views/timer_play_view.dart';
import '../../../enums/countdown_voices.dart';
import '../../../models/time_training.dart';
import 'vm_timer_play_view.dart';

class VmTimerEditView extends ChangeNotifier {
  // NON-FINAL PROPRIETIES
  int _seriesNumber = 1;
  int _execMin = 0;
  int _execSec = 0;
  int _restMin = 0;
  int _restSec = 0;
  int _countdown = 5;
  String _voiceFileName = CountdownVoices.values[0].fileName;
  String _alarmFileName = CountdownAlarms.values[0].fileName;

  // GETTERS
  int get getSeriesNumber => _seriesNumber;
  int get getExecMin => _execMin;
  int get getExecSec => _execSec;
  int get getRestMin => _restMin;
  int get getRestSec => _restSec;
  int get getCountdown => _countdown;

  List<String> get getListVoiceFiles {
    final List<String> list = [];

    for (CountdownVoices voice in CountdownVoices.values) {
      list.add(voice.fileName);
    }

    return list;
  }

  List<String> get getListVoiceTitles {
    final List<String> list = [];

    for (CountdownVoices voice in CountdownVoices.values) {
      list.add(voice.title);
    }

    return list;
  }

  List<bool> get getListVoiceSelec {
    final List<bool> list = [];

    for (CountdownVoices voice in CountdownVoices.values) {
      final bool isTheVoiceSelected = voice.fileName == _voiceFileName;
      if (isTheVoiceSelected) {
        list.add(true);
      } else {
        list.add(false);
      }
    }

    return list;
  }

  List<String> get getListAlarmFiles {
    final List<String> list = [];

    for (CountdownAlarms alarm in CountdownAlarms.values) {
      list.add(alarm.fileName);
    }

    return list;
  }

  List<String> get getListAlarmTitles {
    final List<String> list = [];

    for (CountdownAlarms alarm in CountdownAlarms.values) {
      list.add(alarm.title);
    }

    return list;
  }

  List<bool> get getListAlarmSelec {
    final List<bool> list = [];

    for (CountdownAlarms alarm in CountdownAlarms.values) {
      final bool isTheAlarmSelected = alarm.fileName == _alarmFileName;
      if (isTheAlarmSelected) {
        list.add(true);
      } else {
        list.add(false);
      }
    }

    return list;
  }

  List<int> getGetterList() {
    return [
      getSeriesNumber,
      getExecMin,
      getExecSec,
      getRestMin,
      getRestSec,
      getCountdown,
    ];
  }

  List<void Function(int)> getSetterList() {
    return [
      (int serie) => setSeriesNumber = serie,
      (int execMin) => setExecMin = execMin,
      (int execSec) => setExecSec = execSec,
      (int restMin) => setRestMin = restMin,
      (int restSec) => setRestSec = restSec,
      (int countdown) => setCountdown = countdown,
    ];
  }

  List<VoidCallback> getAddNumberList() {
    return [
      () {
        if (_seriesNumber + 1 < 99) {
          _seriesNumber = _seriesNumber + 1;
        }
        notifyListeners();
      },
      () {
        if (_execMin + 1 < 60) {
          _execMin = _execMin + 1;
        }
        notifyListeners();
      },
      () {
        if (_execSec + 10 < 60) {
          _execSec = _execSec + 10;
        } else {
          _execSec = 59;
        }
        notifyListeners();
      },
      () {
        if (_restMin + 1 < 60) {
          _restMin = _restMin + 1;
        }
        notifyListeners();
      },
      () {
        if (_restSec + 10 < 60) {
          _restSec = _restSec + 10;
        } else {
          _restSec = 59;
        }
        notifyListeners();
      },
    ];
  }

  // SETTERS
  set setSeriesNumber(int seriesNumber) {
    _seriesNumber = seriesNumber;
    notifyListeners();
  }

  set setExecMin(int execMin) {
    _execMin = execMin;
    notifyListeners();
  }

  set setExecSec(int execSec) {
    _execSec = execSec;
    notifyListeners();
  }

  set setRestMin(int restMin) {
    _restMin = restMin;
    notifyListeners();
  }

  set setRestSec(int restSec) {
    _restSec = restSec;
    notifyListeners();
  }

  set setCountdown(int countdown) {
    _countdown = countdown;
    notifyListeners();
  }

  // METHODS
  void selectVoice(int voiceIndex) {
    _voiceFileName = CountdownVoices.values[voiceIndex].fileName;
    notifyListeners();
  }

  void selectAlarm(int alarmIndex) {
    _alarmFileName = CountdownAlarms.values[alarmIndex].fileName;
    notifyListeners();
  }

  Duration _createDuration(int min, int sec) =>
      Duration(minutes: min, seconds: sec);

  TimerTraining _createModel(
    int seriesNumber,
    Duration executionDuration,
    Duration restDuration,
  ) =>
      TimerTraining(
          seriesNumber: seriesNumber,
          executionDuration: executionDuration,
          restDuration: restDuration,
          countdownTimer: _countdown,
          voiceFileName: _voiceFileName,
          alarmFileName: _alarmFileName);

  VmTimerTimeView _createViewModel(
    int seriesNumber,
    Duration executionDuration,
    Duration restDuration,
  ) {
    final model = _createModel(seriesNumber, executionDuration, restDuration);

    return VmTimerTimeView(model: model);
  }

  void _invalidTimeWarning(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      duration: const Duration(milliseconds: 700),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void goToTimerView(BuildContext context) {
    if (_execMin == 0 && _execSec == 0) {
      _invalidTimeWarning(context, 'Insira um tempo válido para a execução.');
      return;
    }
    if (_restMin == 0 && _restSec == 0) {
      _invalidTimeWarning(context, 'Insira um tempo válido para o descanso.');
      return;
    }

    final executionDuration = _createDuration(_execMin, _execSec);
    final restDuration = _createDuration(_restMin, _restSec);
    final viewModel =
        _createViewModel(_seriesNumber, executionDuration, restDuration);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TimerPlayView(viewModel: viewModel),
    ));
  }

  void goToConfig(
      bool darkMode, BuildContext context, VmTimerEditView viewModel) {
    showDialog(
      context: context,
      builder: (context) => OurDialog(viewModel: viewModel, darkMode: darkMode),
    );
  }
}
