import 'package:flutter/material.dart';
import 'package:training_timer/core/classes/models/time_training.dart';
import 'package:training_timer/core/view_models/vm_timer_view.dart';
import 'package:training_timer/ui/views/timer_view.dart';

class VmInitialView extends ChangeNotifier {
  int _seriesNumber = 1;
  int _execHour = 0;
  int _execMin = 0;
  int _execSec = 0;
  int _restHour = 0;
  int _restMin = 0;
  int _restSec = 0;

  int get getSeriesNumber => _seriesNumber;
  int get getExecHour => _execHour;
  int get getExecMin => _execMin;
  int get getExecSec => _execSec;
  int get getRestHour => _restHour;
  int get getRestMin => _restMin;
  int get getRestSec => _restSec;

  set setSeriesNumber(int seriesNumber) {
    _seriesNumber = seriesNumber;
    notifyListeners();
  }

  set setExecHour(int execHour) {
    _execHour = execHour;
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

  set setRestHour(int restHour) {
    _restHour = restHour;
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

  Duration _createDuration(int hour, int min, int sec) =>
      Duration(hours: hour, minutes: min, seconds: sec);

  TimeTraining _createTrainingModel(
    int seriesNumber,
    Duration executionDuration,
    Duration restDuration,
  ) =>
      TimeTraining(
          seriesNumber: seriesNumber,
          executionDuration: executionDuration,
          restDuration: restDuration);

  VmTimerView _createVmTimerView(
    int seriesNumber,
    Duration executionDuration,
    Duration restDuration,
  ) {
    final model =
        _createTrainingModel(seriesNumber, executionDuration, restDuration);

    return VmTimerView(model: model);
  }

  void _invalidTimeFunction(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      duration: const Duration(milliseconds: 700),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void goToTimerView(BuildContext context) {
    if (_execHour == 0 && _execMin == 0 && _execSec == 0) {
      _invalidTimeFunction(context, 'Insira um tempo válido para a execução.');
      return;
    }
    if (_restHour == 0 && _restMin == 0 && _restSec == 0) {
      _invalidTimeFunction(context, 'Insira um tempo válido para o descanso.');
      return;
    }

    final executionDuration = _createDuration(_execHour, _execMin, _execSec);
    final restDuration = _createDuration(_restHour, _restMin, _restSec);
    final viewModel =
        _createVmTimerView(_seriesNumber, executionDuration, restDuration);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TimerView(viewModel: viewModel),
    ));
  }
}
