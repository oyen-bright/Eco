part of browse_vehicles;

class TopVehicleDealers extends StatelessWidget {
  TopVehicleDealers({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleState = context.watch<VehicleCubit>().state;

    final filterOptions = vehicleState.mapOrNull(
        loading: (state) => state.filterOptions,
        loaded: (state) => state.filterOptions,
        error: (state) => state.filterOptions);

    bool isLoading = filterOptions == null;
    const int rating = 3;
    return isLoading
        ? _buildShimmerGrid(context)
        : _buildGrid(context, rating, filterOptions.make);
  }

  final List<Map<String, String>> buildImageStrings = [
    {"name": "tesla", "image": AppImages.teslaFilter},
    {"name": "hyundai", "image": AppImages.hyundaiFilter},
    {"name": "chevrolet", "image": AppImages.chevroletImage},
  ];

  String _getBrandImage(String brandName) {
    final map = buildImageStrings.firstWhere(
        (element) => element['name']?.toLowerCase() == brandName.toLowerCase(),
        orElse: () => buildImageStrings.last);
    return map['image'] ?? AppImages.noVehicleImage;
  }

  void _onFilter(BuildContext context, String brandName) {
    context.read<VehicleCubit>().getFilteredVehicle((
      brand: [brandName],
      capacity: [],
      type: [],
      priceRange: (min: null, max: null)
    ));
    AppRouter.router.push(EcomotoRoutes.homeAllVehicles);
  }

  Column _buildGrid(BuildContext context, int rating, List<String> brands) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const GridListHeader(
        onPressed: null,
        textString: Strings.filterByBrandsText,
      ),
      const SizedBox(
        height: AppSizes.size10,
      ),
      SizedBox(
        height: context.viewSize.height * .19,
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingGrid),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: context.viewSize.height * .16,
              crossAxisCount: 1,
              mainAxisSpacing: 10.0),
          itemCount: brands.length > 3 ? 3 : brands.length,
          itemBuilder: (context, index) {
            return _item(context, rating, brands[index]);
          },
        ),
      )
    ]);
  }

  Widget _buildShimmerGrid(BuildContext context) {
    return AppShimmer(
      child: Column(children: [
        const GridListHeader(
          onPressed: null,
          textString: Strings.filterByBrandsText,
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        SizedBox(
          height: context.viewSize.height * .19,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.viewPaddingGrid),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: context.viewSize.height * .16,
                crossAxisCount: 1,
                mainAxisSpacing: 10.0),
            itemCount: 3,
            itemBuilder: (context, index) {
              return _item(context, null, null);
            },
          ),
        )
      ]),
    );
  }

  Widget _item(
    BuildContext context,
    int? rating,
    String? data,
  ) {
    return InkWell(
      onTap: () => data != null ? _onFilter(context, data) : null,
      child: Container(
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: context.colorScheme.tertiary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItemImages(
                brandImage: data == null
                    ? AppImages.chevroletImage
                    : _getBrandImage(data)),
            const SizedBox(
              height: AppSizes.size6,
            ),
            _buildItemTexts(context)
          ],
        ),
      ),
    );
  }

  Expanded _buildItemTexts(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: double.infinity,
            child: AutoSizeText(
              '120 Offers',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryLight, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: SizedBox(
                width: double.infinity,
                child: StarRating(
                  currentRating: 3,
                  color: context.colorScheme.primary,
                  size: 17,
                )),
          ),
        ],
      ),
    );
  }

  Expanded _buildItemImages({required String brandImage}) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Image.asset(
              brandImage,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(
            height: AppSizes.size4,
          ),
          Flexible(
            child: Image.asset(
              AppImages.topDealersImage,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}
