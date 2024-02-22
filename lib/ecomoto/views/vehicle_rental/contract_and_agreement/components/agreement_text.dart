// ignore_for_file: public_member_api_docs, sort_constructors_first
part of rental_agreement;

class RentalAgreementDescription extends StatelessWidget {
  final Vehicle vehicle;
  final ScrollController scrollController;

  const RentalAgreementDescription({
    Key? key,
    required this.vehicle,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSizes.size20),
          const _TextRow(
            number: 1,
            text: 'NEVA Vehicle Rental Contract Agreement',
          ),
          const _TextRow(
            number: 2,
            text:
                'The Vehicle Rental Agreement is entered into between Alice Doe (“Owner”) and Bob Jones (“Renter”) (collectively the “Parties”) and outlines the respective rights and obligations of the Parties relating to the rental of a vehicle.',
          ),
          _TextRow(
            number: 3,
            text: 'Identification of rental vehicle\n'
                'Make : ${vehicle.make}\n'
                'Model : ${vehicle.model}\n'
                'Vin : ${vehicle.vin}\n'
                'Color : ${vehicle.color}\n'
                'Year : ${vehicle.year}',
          ),
          const _TextRow(
            number: 4,
            text: 'Rental term\n'
                'The term of this Vehicle Rental Agreement from the date and hour of vehicle pickup as indicated just above the signature line at the bottom of this agreement until the return of the vehicle to the Owner and completion of all the terms of this agreement by both parties. The estimated rental term is as follows:'
                'Estimated Start Date : '
                'Estimated Stop Date : '
                'The Parties may shorten or extend the estimated rental term by mutual consent.',
          ),
          const _TextRow(
            number: 4,
            text: 'Rental term\n'
                'The term of this Vehicle Rental Agreement from the date and hour of vehicle pickup as indicated just above the signature line at the bottom of this agreement until the return of the vehicle to the Owner and completion of all the terms of this agreement by both parties. The estimated rental term is as follows:'
                'Estimated Start Date : '
                'Estimated Stop Date : '
                'The Parties may shorten or extend the estimated rental term by mutual consent.',
          ),
        ],
      ),
    );
  }
}

class _TextRow extends StatelessWidget {
  final int number;
  final String text;

  const _TextRow({
    Key? key,
    required this.number,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number. ',
              style: context.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                text,
                style: context.textTheme.bodyMedium!,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.size6),
      ],
    );
  }
}
