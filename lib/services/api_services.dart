import 'dart:convert';
import 'dart:io';
import 'package:ai_assistant/services/apiconstants.dart';
import 'package:http/http.dart' as http;
import 'package:ai_assistant/modals/models_model.dart';
import '../modals/chat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  Future<List<ModelsModel>> getModals() async {
    try {
      //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? apiKey = _prefs.getString('apiKey') ?? KEY;
      print(
          'API KEY--------------------------------------------------------------->$apiKey');
      final response = await http.get(Uri.parse(BASEURI),
          headers: {'Authorization': 'Bearer $apiKey'});
      if (response.statusCode == 200) {
        Map jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        List tempList = [];
        for (var i in jsonResponse['data']) {
          tempList.add(i); // list of data in jsonResponse
        }
        return ModelsModel.fromJsonSnapShot(tempList);
      } else {
        throw HttpException(jsonDecode(response.body)['error']['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ChatModal>> getChatResopnse(String model, String prompt) async {
    final body = {
      "model": model,
      "prompt": prompt,
      "max_tokens": 300,
      "temperature": 0
    };
    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? apiKey = _prefs.getString('apiKey') ?? KEY;
      final response = await http.post(Uri.parse(BASEURICompletion),
          body: jsonEncode(body),
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json'
          });
      print(
          'API KEY--------------------------------------------------------------->$apiKey');
      print(
          'esponse.statusCode----------------------------------------------------> ${response.statusCode}');
      if (response.statusCode == 200) {
        Map jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        List<ChatModal> aiChatList = [];
        if (jsonResponse['choices'].length > 0) {
          aiChatList = List.generate(
              jsonResponse['choices'].length,
              (index) => ChatModal(
                  msg: jsonResponse['choices'][index]['text']
                      .toString()
                      .trimLeft(),
                  chatInext: 1)).toList();
        }

        return aiChatList;
      } else {
        throw HttpException(jsonDecode(response.body)['error']['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
