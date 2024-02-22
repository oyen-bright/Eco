part of verification_success;

class GeneratedPassword extends StatelessWidget {
  final String password;
  const GeneratedPassword({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.generatedPasswordIsText,
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingHorizontal,
              vertical: AppSizes.size4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              color: context.colorScheme.secondary),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  password,
                  style: context.textTheme.titleMedium,
                ),
              ),
              const SizedBox(
                width: AppSizes.size16,
              ),
              TextButton(
                  onPressed: () {
                    copyToClipboard(context, password);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Strings.copyText,
                        style: context.textTheme.titleSmall,
                      ),
                      const SizedBox(
                        width: AppSizes.size4,
                      ),
                      const Icon(Icons.copy)
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
