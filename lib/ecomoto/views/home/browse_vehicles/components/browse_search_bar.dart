part of browse_vehicles;

class BrowseSearchBox extends StatelessWidget {
  const BrowseSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.searchBarColor,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: GestureDetector(
        onTap: () {
          AppRouter.router.push(
            EcomotoRoutes.homeMapSearch,
          );
        },
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  AppRouter.router.push(
                    EcomotoRoutes.homeMapSearch,
                  );
                },
                icon: const Icon(Icons.search)),
            const Text(Strings.searchBoxText)
          ],
        ),
      ),
    );
  }
}
