import 'package:ai_assistant/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:ai_assistant/modals/models_model.dart';

class ModalProvider with ChangeNotifier {
  String currentModel = 'text-davinci-003';
  List<ModelsModel> modelList = [];

  void setCurrentModel(String currModel) {
    currentModel = currModel;
    notifyListeners();
  }

  String get getCurrentModel {
    return currentModel;
  }

  Future<List<ModelsModel>> get getModelList async {
    modelList = await ApiServices.getModals();
    return modelList;
  }
}
