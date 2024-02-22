part of email_verification;

class EditEmailButton extends StatelessWidget {
  const EditEmailButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Text(
          Strings.editEmailText,
          style: context.textTheme.titleSmall,
        ));
  }
}
