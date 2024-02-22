import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/ecomoto/views/home/home_onboarding/components/company_aim.dart';
import 'package:emr_005/ecomoto/views/home/home_onboarding/components/ev_rental_view.dart';
import 'package:emr_005/ecomoto/views/home/home_onboarding/components/how_it_works.dart';
import 'package:emr_005/ecomoto/views/home/home_onboarding/components/register_your_vehicle.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';

import 'components/search_bar.dart';

class HomeOnboardingView extends StatelessWidget {
  const HomeOnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const RentalSearchBar().withHorViewPadding,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: AppSizes.size20,
                  ),
                  const EvRentalFormView().withHorViewPadding,
                  const SizedBox(height: AppSizes.size20),
                  const CompanyAimView(),
                  const SizedBox(height: AppSizes.size20),
                  const HowItWorksHomeView().withHorViewPadding,
                  const SizedBox(height: AppSizes.size20),
                  const RegisterYourEVHomeView(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
