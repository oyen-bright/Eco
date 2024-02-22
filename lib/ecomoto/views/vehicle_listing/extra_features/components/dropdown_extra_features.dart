part of '../extra_features_view.dart';

class DropdownExtraFeatures extends StatelessWidget {
  final void Function(String?)? onChanged;
  final List<String> optionsList;
  const DropdownExtraFeatures(
      {super.key, this.onChanged, required this.optionsList});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingHorizontal),
          labelText: Strings.addFeaturesText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          )),
      value: null,
      onChanged: onChanged,
      items: optionsList.map((option) {
        return DropdownMenuItem(
          value: option,
          child: Text(option),
        );
      }).toList(),
      isDense: true,
      isExpanded: true,
    );
  }
}
