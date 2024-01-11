import 'package:domain/converters/binary_converter.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/custom_button/custom_button.dart';
import 'package:presentation/components/custom_icon_button/custom_icon_button.dart';
import 'package:presentation/components/custom_text_field/custom_text_field.dart';
import 'package:presentation/components/manual_sign_box.dart/manual_sign_box.viewmodel.dart';
import 'package:stacked/stacked.dart';

class ManualSignBox extends StatelessWidget {
  final Function onSave;
  final StoredIdentity identity;
  const ManualSignBox({
    super.key,
    required this.identity,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ManualSignBoxViewModel(context, identity, onSave),
      builder: (context, viewModel, child) => Container(
        color: ThemeStyles.theme.background200,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Visibility(
            visible: viewModel.signature == null,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
                  width: double.infinity,
                  height: 5,
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.accent200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                CustomTextField(
                  floatingLabel: "Message",
                  onChange: viewModel.onMessageChanged,
                  height: 50,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  floatingLabel: "Data",
                  onChange: viewModel.onDataChanged,
                  height: 50,
                ),
                const SizedBox(height: 8),
                CustomIconButton(
                  label: "Sign",
                  callback: viewModel.onSave,
                  height: 50,
                ),
                const SizedBox(height: 8),
              ],
            ),
            replacement: Column(
              children: [
                Text(
                  "Input",
                  style: ThemeStyles.regularHeading,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(6),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.primary300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    viewModel.message,
                    style: ThemeStyles.regularParagraphOv(
                      size: 16,
                      color: ThemeStyles.theme.text300,
                      weight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Produced hex",
                  style: ThemeStyles.regularHeading,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(6),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.primary300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    BianaryConverter.toHex(viewModel.message.codeUnits),
                    style: ThemeStyles.regularParagraphOv(
                      size: 16,
                      color: ThemeStyles.theme.text300,
                      weight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Generated Signature",
                  style: ThemeStyles.regularHeading,
                ),
                const SizedBox(height: 8),
                CustomButton(
                  callback: viewModel.onCopySignature,
                  widget: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: ThemeStyles.theme.primary300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        Icon(
                          Icons.fingerprint,
                          color: ThemeStyles.theme.text300,
                          size: 35,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                "*********************************",
                                style: ThemeStyles.regularParagraphOv(
                                  size: 14,
                                  color: ThemeStyles.theme.text300,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.copy,
                          color: ThemeStyles.theme.text300,
                          size: 35,
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                CustomButton(
                  callback: viewModel.onCopyPublic,
                  widget: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: ThemeStyles.theme.primary300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        Icon(
                          Icons.public,
                          color: ThemeStyles.theme.text300,
                          size: 35,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                identity.publicKey,
                                style: ThemeStyles.regularParagraphOv(
                                  size: 14,
                                  color: ThemeStyles.theme.text300,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.copy,
                          color: ThemeStyles.theme.text300,
                          size: 35,
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  floatingLabel: "url",
                  onChange: viewModel.onUrlChanged,
                  height: 50,
                  innerButon: Icon(
                    Icons.wb_cloudy_outlined,
                    color: ThemeStyles.theme.accent100,
                  ),
                ),
                if (!viewModel.advanced)
                  CustomButton(
                    widget: Text(
                      "advanced",
                      style: ThemeStyles.regularParagraphOv(
                        size: 13,
                        color: ThemeStyles.theme.primary300,
                        decoration: TextDecoration.underline,
                        weight: FontWeight.bold,
                      ),
                    ),
                    callback: viewModel.onAdvancedPressed,
                  ),
                if (viewModel.advanced)
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: CustomTextField(
                      floatingLabel: "Bearer",
                      onChange: viewModel.onBearerChanged,
                      height: 50,
                      innerButon: Icon(
                        Icons.lock,
                        color: ThemeStyles.theme.accent100,
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CustomIconButton(
                      expand: true,
                      label: "Close",
                      callback: viewModel.onClose,
                      buttonColor: ThemeStyles.theme.primary300,
                      height: 50,
                    ),
                    const SizedBox(width: 8),
                    CustomIconButton(
                      expand: true,
                      label: "Send",
                      callback: viewModel.onSend,
                      height: 50,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
