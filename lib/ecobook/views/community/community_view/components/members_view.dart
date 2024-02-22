part of community_view;

class MembersView extends StatefulWidget {
  final Community community;
  const MembersView({
    super.key,
    required this.community,
  });

  @override
  MembersViewState createState() => MembersViewState();
}

class MembersViewState extends State<MembersView> {
  late final bool isUserInCommunity;
  late final TextEditingController _searchController;

  List<CommunityPost> communityPosts = [];


  @override
  void initState() {
    super.initState();
    isUserInCommunity = widget.community.userIds.contains(LocalStorage.userId);
    context.read<CommunityBloc>().add(CommunityEvent.loadMembers(communityId: widget.community.id!));
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        // TextButton(onPressed: (){
        //   print(widget.community.members);
        //   context.read<CommunityBloc>().add(CommunityEvent.loadMembers(communityId: widget.community.id!));
        // }, child: Text('Hello')),
        // if (isUserInCommunity)
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        //         return _userInfo(
        //           username: state.when<String>(
        //             details: (user) => user.username,
        //           ),
        //         );
        //       }),
        //       TextButton(
        //           onPressed: () {},
        //           child: Text(
        //             'Leave',
        //             style: context.textTheme.bodySmall!.copyWith(
        //                 color: context.colorScheme.error,
        //                 fontWeight: FontWeight.bold),
        //           ))
        //     ],
        //   ).withHorViewPadding,
        // if (isUserInCommunity)
        //   const Divider(
        //     color: AppColors.lowOpacityTextColor,
        //   ).withHorViewPadding,
        Expanded(
            child: BlocConsumer<CommunityBloc, CommunityState>(
              listener: (context, state) {
                state.maybeWhen(
                  loading: (_, __, members) => _buildShimmerList(context),
                  error: (message, _, __, members) {
                    context.showSnackBar(message);
                    _;
                    __;
                    members;
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  loading: (_, __, members) => _buildShimmerList(context),
                  orElse: () => _buildMembersList(context, state.members!),
                );
              },
            ))
      ],
    );
  }

  Row _userInfo({required String username}) {
    return Row(
      children: [
        NameAvatar(data: AppConstants.getUsernameInitials(username)),
        const SizedBox(
          width: AppSizes.size6,
        ),
        Text(
          username,
          style: context.textTheme.titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }


  Widget _buildMembersList(BuildContext context, members){
    return
    ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: members.length,
      itemBuilder: (buildContext, int index) {
        return MemberCard(
            member: members[index]);
      },
    );
  }

  Widget _buildShimmerList(BuildContext context,){
    return AppShimmer(child:  ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4 ,
      itemBuilder: (buildContext, int index) {
        return MemberCard.shimmer;
      },
    ));
  }

  EcobookSearchBar _buildSearchBar() {
    return EcobookSearchBar(
      hint: Strings.searchMembersText,
      controller: _searchController,
      // Todo : add on tap callback
    );
  }
}
