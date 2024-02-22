part of verification_success;

class CompleteRegistrationButton extends StatelessWidget {
  const CompleteRegistrationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      title: Strings.completeYourRegistration,
      onPressed: () => AppRouter.router.pop(true),
    );
  }
}
