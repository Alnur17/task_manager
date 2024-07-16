import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/summary_count_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class SummaryCountController extends GetxController{
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  bool _getSummaryCountInProgress = false;

  bool get getSummaryCountInProgress => _getSummaryCountInProgress;
  SummaryCountModel get summaryCountModel => _summaryCountModel;

  Future<bool> getSummaryCount() async {
    _getSummaryCountInProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.taskStatusCount);
    _getSummaryCountInProgress = false;
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}