part of "../trips_view.dart";

class History extends StatelessWidget {
  final ScrollController scrollController;
  const History({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    Future<void> refreshData() async {
      return context.read<TripsCubit>().getHistory();
    }

    return AppRefreshIndicator(
      onRefresh: refreshData,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.viewPaddingHorizontal),
        child: BlocConsumer<TripsCubit, TripsState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message, _, __, ___) {
                context.showSnackBar(message);
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => _buildShimmerList(),
              loaded: (_, history, __) {
                if (history.isEmpty) {
                  return const NoTrips(
                    title: Strings.noHistory,
                    subtitle: Strings.noHistorySubtitle,
                  );
                }

                return _buildHistoryList(history);
              },
            );
          },
        ),
      ),
    );
  }

  DateTime _getDateToBeDisplayed(Trip tripDetails) {
    final currentMessageDateFormatted =
        DateFormat(Constants.dateFormate).format(tripDetails.createdAt);
    final currentDateFormatted =
        DateFormat(Constants.dateFormate).format(DateTime.now());

    return currentMessageDateFormatted == currentDateFormatted
        ? DateTime.now()
        : tripDetails.createdAt;
  }

  Widget _buildDateHeader(DateTime dateToBeDisplayed) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppSizes.size20),
        child: Row(
          children: [
            Text(
              DateFormat(Constants.historySeparatorFormate)
                  .format(dateToBeDisplayed),
            ),
            const SizedBox(width: 10),
            const Expanded(child: Divider())
          ],
        ),
      ),
    );
  }

  ListView _buildHistoryList(List<Trip> history) {
    return ListView.separated(
        separatorBuilder: (_, index) {
          if (index != 0 &&
              _getDateToBeDisplayed(history[index]).day !=
                  _getDateToBeDisplayed(history[index - 1]).day) {
            return _buildDateHeader(_getDateToBeDisplayed(history[index]));
          } else {
            return const SizedBox(
              height: 10,
            );
          }
        },
        itemCount: history.length,
        itemBuilder: (context, index) {
          print(history[index].rentalStatus);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (index == 0)
                _buildDateHeader(_getDateToBeDisplayed(history[index])),
              TripDetailsTile(
                tripDetails: history[index],
                onTap: () => AppRouter.router.push(
                    EcomotoRoutes.tripsHistoryDetails,
                    extra: history[index]),
              ),
            ],
          );
        });
  }

  Widget _buildShimmerList() {
    return ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(
              height: 10,
            ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              if (index == 0)
                AppShimmer(child: _buildDateHeader(DateTime.now())),
              TripDetailsTile.shimmer,
            ],
          );
        });
  }
}
