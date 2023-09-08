import 'package:flutter/material.dart';
import 'package:training_timer/core/view_models/training_vms/timer_training_vms/vm_time_timer.dart';

import '../../../../ui/views/non_training_views/view_time.dart';
import '../../../classes/models/timer_training.dart';

class VmEditTimer extends ChangeNotifier {
  int _seriesNumber = 1;
  int _execMin = 0;
  int _execSec = 0;
  int _restMin = 0;
  int _restSec = 0;

  int get getSeriesNumber => _seriesNumber;
  int get getExecMin => _execMin;
  int get getExecSec => _execSec;
  int get getRestMin => _restMin;
  int get getRestSec => _restSec;

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

  List<int> getGetterList() {
    return [
      getSeriesNumber,
      getExecMin,
      getExecSec,
      getRestMin,
      getRestSec,
    ];
  }

  List<void Function(int)> getSetterList() {
    return [
      (int serie) => setSeriesNumber = serie,
      (int execMin) => setExecMin = execMin,
      (int execSec) => setExecSec = execSec,
      (int restMin) => setRestMin = restMin,
      (int restSec) => setRestSec = restSec,
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

  Duration _createDuration(int min, int sec) =>
      Duration(minutes: min, seconds: sec);

  TimerTraining _createTrainingModel(
    int seriesNumber,
    Duration executionDuration,
    Duration restDuration,
  ) =>
      TimerTraining(
          seriesNumber: seriesNumber,
          executionDuration: executionDuration,
          restDuration: restDuration);

  VmTimerTime _createVmTimerView(
    int seriesNumber,
    Duration executionDuration,
    Duration restDuration,
  ) {
    final model =
        _createTrainingModel(seriesNumber, executionDuration, restDuration);

    return VmTimerTime(model: model);
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
        _createVmTimerView(_seriesNumber, executionDuration, restDuration);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ViewTime(viewModel: viewModel),
    ));
  }
}
