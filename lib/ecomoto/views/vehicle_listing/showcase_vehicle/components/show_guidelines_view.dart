part of '../showcase_vehicle_view.dart';

class ShowImageGuidelines extends StatelessWidget {
  const ShowImageGuidelines({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        alignment: Alignment.centerLeft,
        visualDensity: VisualDensity.compact,
      ),
      onPressed: () => imageGuidelineView(context),
      child: Text(
        Strings.imageGuidelinesButtonText,
        style: context.textTheme.bodyMedium
            ?.copyWith(color: context.colorScheme.primary, fontSize: 14),
      ),
    );
  }

  static Future<void> imageGuidelineView(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            alignment: Alignment.centerLeft,
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  Strings.imageGuidelinesText,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  Strings.imageGuidelinesText2,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildGuidelineRow(
                  context,
                  Strings.imageGuideText2,
                ),
                _buildGuidelineRow(
                  context,
                  Strings.imageGuideText3,
                ),
                _buildGuidelineRow(
                  context,
                  Strings.imageGuideText4,
                ),
                _buildGuidelineRow(
                  context,
                  Strings.imageGuideText5,
                ),
                const SizedBox(height: AppSizes.size20)
              ],
            ));
      },
    );
  }

  static Widget _buildGuidelineRow(
    BuildContext context,
    String text,
  ) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 7),
              child: Icon(
                Icons.circle,
                size: 7,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                text,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onBackground,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        )
      ],
    );
  }
}
