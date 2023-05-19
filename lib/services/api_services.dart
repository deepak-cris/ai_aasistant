import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:ai_assistant/services/apiconstants.dart';
import 'package:http/http.dart' as http;
import 'package:ai_assistant/modals/models_model.dart';

class ApiServices {
  static Future<List<ModelsModel>> getModals() async {
    try {
      final response = await http
          .get(Uri.parse(BASEURI), headers: {'Authorization': 'Bearer $KEY'});
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

  Future<String> getChatResopnse(String model, String prompt) async {
    final body = {
      "model": model,
      "prompt": prompt,
      "max_tokens": 100,
      "temperature": 0
    };
    try {
      final response = await http.post(Uri.parse(BASEURICompletion),
          body: jsonEncode(body),
          headers: {
            'Authorization': 'Bearer $KEY',
            'Content-Type': 'application/json'
          });
      if (response.statusCode == 200) {
        Map jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        print(
            '--------------------------------------------------------------------------------');
        print(jsonResponse['choices'][0]['text'].toString());
        print(
            '--------------------------------------------------------------------------------');
      } else {
        throw HttpException(jsonDecode(response.body)['error']['message']);
      }
    } catch (e) {
      rethrow;
    }
    return "ok";
  }
}
