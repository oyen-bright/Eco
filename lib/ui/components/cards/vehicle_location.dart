import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/services/ecomoto/location_service.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleLocation extends StatefulWidget {
  final bool withBorder;
  final ({double? long, double? lat}) geoLocation;

  const VehicleLocation(
      {super.key, this.withBorder = true, required this.geoLocation});

  @override
  State<VehicleLocation> createState() => _VehicleDistanceFromLocationState();
}

class _VehicleDistanceFromLocationState extends State<VehicleLocation> {
  bool isLoading = true;
  String locationText = '';

  @override
  void initState() {
    super.initState();
    _getLocation(context);
  }

  void _getLocation(BuildContext context) async {
    if (widget.geoLocation.lat != null && widget.geoLocation.long != null) {
      final response =
          await context.read<LocationService>().distanceBetweenGeoLocations(
              haversine: (use: false, convertToFeet: true),
              useCache: true,
              userSavedLocation: true,
              destination: (
                long: widget.geoLocation.long!.toString(),
                lat: widget.geoLocation.lat!.toString()
              ));
      if (mounted) {
        isLoading = false;
        setState(() {
          if (response.error != null) {
            locationText = response.error!;
          } else {
            locationText = "${response.data?.distance} away";
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        decoration: BoxDecoration(
          border: widget.withBorder
              ? Border.all(color: context.colorScheme.primary)
              : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isLoading)
              Icon(
                Icons.location_on_outlined,
                color: AppColors.primaryLight,
                size: widget.withBorder ? 13 : 14,
              )
            else
              Padding(
                padding: const EdgeInsets.only(right: AppSizes.size4),
                child: SizedBox(
                    height: widget.withBorder ? 10 : 11,
                    width: widget.withBorder ? 10 : 11,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                    )),
              ),
            Flexible(
              child: AutoSizeText(
                locationText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                minFontSize: 10,
                style: context.textTheme.labelSmall!.copyWith(
                  letterSpacing: -0.3,
                  fontSize: widget.withBorder ? 10 : 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryLight,
                ),
              ),
            )
          ],
        ));
  }
}
