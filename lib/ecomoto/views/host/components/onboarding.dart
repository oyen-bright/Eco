part of '../host_view.dart';

class HostOnboarding extends StatelessWidget {
  const HostOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              AppImages.dashboardImage,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.white
                  ],
                ),
              ),
            ),
          )
        ]),
        const SizedBox(
          height: 60,
        ),
        AutoSizeText(
          Strings.onboardingText,
          textAlign: TextAlign.center,
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).withHorViewPadding,
      ],
    );
  }
}
