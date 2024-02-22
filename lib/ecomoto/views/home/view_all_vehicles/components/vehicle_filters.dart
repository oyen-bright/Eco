part of view_all_vehicles;

class BrowseWithFilters extends StatefulWidget {
  const BrowseWithFilters({
    Key? key,
  }) : super(key: key);

  @override
  BrowseWithFiltersState createState() => BrowseWithFiltersState();
}

class BrowseWithFiltersState extends State<BrowseWithFilters> {
  List<String> vehicleMake = [];
  List<String> vehicleType = [];
  List<String> vehicleCapacity = [];
  (String? min, String? max) _priceRange = (null, null);

  @override
  void initState() {
    _onFilterChange(context.read<VehicleCubit>().state);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool get _hasFilterChanged {
    final currentFilter = !(vehicleMake.isEmpty &&
        vehicleCapacity.isEmpty &&
        vehicleCapacity.isEmpty &&
        _priceRange.$1 == null &&
        _priceRange.$2 == null);

    final queryOptions = context.read<VehicleCubit>().state.mapOrNull(
          loaded: (state) => state.queryOptions,
          error: (state) => state.queryOptions,
          loading: (state) => state.queryOptions,
        );

    if (queryOptions != null) {
      return currentFilter ||
          (queryOptions.type != vehicleType ||
              queryOptions.brand != vehicleMake ||
              queryOptions.capacity != vehicleCapacity ||
              queryOptions.max != _priceRange.$2 ||
              queryOptions.min != _priceRange.$1);
    } else {
      return currentFilter;
    }
  }

  void _clearFilters() {
    context.read<VehicleCubit>().clearVehicleFilters();
    setState(() {
      vehicleMake = [];
      vehicleType = [];
      vehicleCapacity = [];
      _priceRange = (null, null);
    });
  }

  void _onFilterChange(VehicleState state) {
    state.mapOrNull(
      loaded: (state) {
        final currentQuery = state.queryOptions;
        print(currentQuery.toString());
        setState(() {
          vehicleMake.addAll(currentQuery?.brand ?? []);
          vehicleType.addAll(currentQuery?.type ?? []);
          vehicleCapacity.addAll(currentQuery?.capacity
                  ?.map<String>((e) => "$e person")
                  .toList() ??
              []);
          _priceRange = (currentQuery?.min, currentQuery?.max);
        });
      },
    );
  }

  void _onApplyFilter() {
    context.read<VehicleCubit>().getFilteredVehicle((
      brand: vehicleMake,
      capacity: vehicleCapacity
          .map((e) => e.replaceAll("person", "").trim())
          .toList(),
      type: vehicleType,
      priceRange: (min: _priceRange.$1, max: _priceRange.$2)
    ));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleCubit, VehicleState>(
      builder: (context, state) {
        final filterValues = state.maybeMap<
            ({List<String> capacity, List<String> make, List<String> type})?>(
          orElse: () => null,
          loaded: (loaded) => loaded.filterOptions,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppConstants.viewPaddingVertical,
            horizontal: AppConstants.viewPaddingHorizontal,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: ModalScrollController.of(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildClearButton(),
                    _buildPriceRange(context, (p0) {}, (p0) {}),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildFilterRow(filterValues),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildFilterRow2(filterValues),
                    const SizedBox(
                      height: 55,
                    ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                  ],
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AppElevatedButton(
                    title: "Apply",
                    onPressed: !_hasFilterChanged ? null : _onApplyFilter,
                  ))
            ],
          ),
        );
      },
    );
  }

  Row _buildFilterRow2(
      ({
        List<String> capacity,
        List<String> make,
        List<String> type
      })? filterValues) {
    return Row(
      children: [
        Expanded(
            child: _buildFilterColumn("Capacity",
                filterValues?.capacity.map((e) => "$e person").toList() ?? [],
                (item) {
          setState(() {
            if (vehicleCapacity.contains(item)) {
              vehicleCapacity.remove(item);
            } else {
              vehicleCapacity.add(item);
            }
          });
        }, vehicleCapacity)),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  Row _buildFilterRow(
      ({
        List<String> capacity,
        List<String> make,
        List<String> type
      })? filterValues) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child:
                _buildFilterColumn("Brands", filterValues?.make ?? [], (item) {
          setState(() {
            if (vehicleMake.contains(item)) {
              vehicleMake.remove(item);
            } else {
              vehicleMake.add(item);
            }
          });
        }, vehicleMake)),
        Expanded(
            child:
                _buildFilterColumn("Types", filterValues?.type ?? [], (item) {
          setState(() {
            if (vehicleType.contains(item)) {
              vehicleType.remove(item);
            } else {
              vehicleType.add(item);
            }
          });
        }, vehicleType))
      ],
    );
  }

  Align _buildClearButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact),
        onPressed: () => _clearFilters(),
        child: const Text("Clear"),
      ),
    );
  }

  Widget _buildPriceRange(BuildContext context,
      void Function(String) onMinChange, void Function(String) onMaxChange) {
    //TODO: make this a statefull widget thant maintians its state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'PRICE RANGE',
          style: context.textTheme.titleSmall!.copyWith(
            color: const Color(0xFF90A3BF),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: AppSizes.size2,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: AppTextField.withLabel(
                prefixText: '${AppConstants.appCurrency} ',
                keyboardType: TextInputType.number,
                initialValue: _priceRange.$1,
                onChanged: (value) => setState(() {
                  _priceRange =
                      (value.isNotEmpty ? value : null, _priceRange.$2);
                }),
                fieldTitle: 'Min',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: AppTextField.withLabel(
                prefixText: '${AppConstants.appCurrency} ',
                keyboardType: TextInputType.number,
                initialValue: _priceRange.$2,
                onChanged: (value) => setState(() {
                  _priceRange = (
                    _priceRange.$1,
                    value.isNotEmpty ? value : null,
                  );
                }),
                fieldTitle: 'Max',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterColumn(String title, List<String> itemList,
      void Function(String)? onItemPressed, List<String> selectedItems) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.filterColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: AppSizes.size2,
        ),
        ...itemList.map((item) {
          return TextButton.icon(
            style: TextButton.styleFrom(
              minimumSize: const Size(double.infinity, 28),
              alignment: Alignment.centerLeft,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
              visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
            ),
            onPressed: () {
              onItemPressed?.call(item);
            },
            icon: AppCheckButton(
              isChecked: selectedItems.contains(item),
              onChanged: (_) {
                onItemPressed?.call(item);
              },
            ),
            label: AutoSizeText(
              item.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      ],
    );
  }
}
