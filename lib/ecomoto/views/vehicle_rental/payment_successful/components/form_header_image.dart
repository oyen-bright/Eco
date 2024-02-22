part of rental_payment_successful;

class FormHeaderImage extends StatelessWidget {
  const FormHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        AppImages.paymentSuccessfulImage,
      ),
    );
  }
}
