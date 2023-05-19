import 'package:ai_assistant/providers/modal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../modals/models_model.dart';
import '../services/api_services.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? currentModel;
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final ModalsProvider = Provider.of<ModalProvider>(context, listen: false);

    return FutureBuilder<List<ModelsModel>>(
      // future: ApiServices.getModals(),
      future: ModalsProvider.getModelList,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : FittedBox(
                child: DropdownButton(
                    value: ModalsProvider.currentModel,
                    dropdownColor: cardColor,
                    items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                        value: snapshot.data![index].id,
                        child: Text(
                          snapshot.data![index].id,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        currentModel = value.toString();
                      });
                      ModalsProvider.setCurrentModel(value.toString());
                    }),
              );
      },
    );
  }
}
