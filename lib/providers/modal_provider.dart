import 'package:ai_assistant/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:ai_assistant/modals/models_model.dart';

class ModalProvider with ChangeNotifier {
  String currentModel = 'text-davinci-003';
  String apiKey = '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';
  List<ModelsModel> modelList = [];

  void setCurrentModel(String currModel) {
    currentModel = currModel;
    notifyListeners();
  }

  String get getCurrentModel {
    return currentModel;
  }

  void setApiKey(String apiKey) {
    apiKey = apiKey;
    notifyListeners();
  }

  String get getApiKey {
    return apiKey;
  }

  Future<List<ModelsModel>> get getModelList async {
    modelList = await ApiServices().getModals();
    return modelList;
  }
}
