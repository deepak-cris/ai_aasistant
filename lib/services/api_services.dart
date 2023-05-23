import 'dart:convert';
import 'dart:io';
import 'package:ai_assistant/services/apiconstants.dart';
import 'package:http/http.dart' as http;
import 'package:ai_assistant/modals/models_model.dart';
import '../providers/modal_provider.dart';
import '../modals/chat_model.dart';

class ApiServices {
  String apikey = ModalProvider().getApiKey;
  Future<List<ModelsModel>> getModals() async {
    try {
      final response = await http.get(Uri.parse(BASEURI),
          headers: {'Authorization': 'Bearer $apikey'});
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
      final response = await http.post(Uri.parse(BASEURICompletion),
          body: jsonEncode(body),
          headers: {
            'Authorization': 'Bearer $apikey',
            'Content-Type': 'application/json'
          });

      print('esponse.statusCode ');
      print(response.statusCode);
      print('api key ------------------   $apikey');
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
