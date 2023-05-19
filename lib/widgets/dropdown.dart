import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../modals/models_model.dart';
import '../services/api_services.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String currentModel = 'gpt-3.5-turbo';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ModelsModel>>(
      future: ApiServices.getModals(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : FittedBox(
                child: DropdownButton(
                    value: currentModel,
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
                    }),
              );
      },
    );
  }
}
