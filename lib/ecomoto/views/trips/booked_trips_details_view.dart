import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trip_model.dart';
import 'package:emr_005/ecomoto/views/trips/trips_view.dart';
import 'package:emr_005/ui/components/headers_footers/app_bar.dart';
import 'package:flutter/material.dart';

class BookedTripDetailsView extends StatelessWidget {
  final Trip tripDetails;
  const BookedTripDetailsView({super.key, required this.tripDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppViewBar.small(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Strings.bookedDetailsViewTitle,
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.viewPaddingHorizontal),
        height: double.infinity,
        width: double.infinity,
        child: TripDetails(
          showDividers: false,
          showLockUnlock: false,
          showEndTrip: false,
          onChat: () {},
          tripDetails: tripDetails,
          isBooked: true,
        ),
      ),
    );
  }
}
