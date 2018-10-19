import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';

@deprecated
class PhoneNumberField extends StatelessWidget {

  final TextEditingController maskedTextFieldController;

  PhoneNumberField({this.maskedTextFieldController});

  @override
  Widget build(BuildContext context) {
    return MaskedTextField(
      maskedTextFieldController: maskedTextFieldController,
      mask: '(xx) xxxxx-xxxx',
      maxLength: 15,
      keyboardType: TextInputType.number,
      inputDecoration: InputDecoration(
        hintText: "Digite o número do chip do veículo",
        labelText: "Número"
      )
    );
  }

}