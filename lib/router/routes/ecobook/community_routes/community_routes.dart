import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecobook/models/create_community.dart';
import 'package:emr_005/ecobook/views/community/community_view/community_view.dart';
import 'package:emr_005/ecobook/views/community/create_community/add_members/add_members_view.dart';
import 'package:emr_005/ecobook/views/community/create_community/general_details/general_details_view.dart';
import 'package:emr_005/ecobook/views/community/explore_communities/explore_communities_view.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:go_router/go_router.dart';
import '../../../../ecobook/bloc/community/community_model.dart';

class EcobookCommunity {
  static final routes = [
    GoRoute(
      path: EcoBookRoutes.community,
      parentNavigatorKey: AppRouter.ecoBookCommunityNavigatorKey,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const ExploreCommunitiesView(),
          state: state,
        );
      },
    ),

    GoRoute(
      path: EcoBookRoutes.ecobookCommunityView,
      parentNavigatorKey: AppRouter.ecoBookCommunityNavigatorKey,
      pageBuilder: (context, state) {
        final community = state.extra as Community;
        return AppRouter.setupPage(
          child:  CommunityView(community: community),
          state: state,
        );
      },
    ),

    GoRoute(
      path: EcoBookRoutes.createCommunityView,
      parentNavigatorKey: AppRouter.ecoBookCommunityNavigatorKey,
      pageBuilder: (context, state) {
        final communityInputData = state.extra as CommunityInput;
        return AppRouter.setupPage(
          child:   CommunityGeneralDetailsView(communityInputData: communityInputData),
          state: state,
        );
      },
    ),

    GoRoute(
      path: EcoBookRoutes.addCommunityMembers,
      parentNavigatorKey: AppRouter.ecoBookCommunityNavigatorKey,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child:  const AddMembersView(),
          state: state,
        );
      },
    ),
  ];
}




// class EcoBook {
//   static final routes = [
//     GoRoute(
//       parentNavigatorKey: AppRouter.ecoBookNavigatorKey,
//       path: EcoBookRoutes.ecoBook,
//       pageBuilder: (context, state) {
//         return AppRouter.setupPage(
//           child:  const EcobookFeedView(),
//           state: state,
//         );
//       },
//     ),

//     GoRoute(
//       parentNavigatorKey: AppRouter.ecoBookNavigatorKey,
//       path: EcoBookRoutes.ecoBookExploreCommunities,
//       pageBuilder: (context, state) {
//         return AppRouter.setupPage(
//           child: const ExploreCommunitiesView(),
//           state: state,
//         );
//       },
//     ),

//     GoRoute(
//       parentNavigatorKey: AppRouter.ecoBookNavigatorKey,
//       path: EcoBookRoutes.ecobookCommunityView,
//       pageBuilder: (context, state) {
//         final community = state.extra as Community;
//         return AppRouter.setupPage(
//           child:  CommunityView(community: community),
//           state: state,
//         );
//       },
//     ),
//   ];
// }
