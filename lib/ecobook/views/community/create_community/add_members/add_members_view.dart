import 'package:emr_005/ecobook/views/community/create_community/add_members/components/members_list.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:flutter/material.dart';
import '../../../../../config/app_constants.dart';
import '../../../../../ui/components/delegates/sticky_app_bar_delegate.dart';
import 'constants/strings.dart';
import '../../../../../ui/components/headers_footers/ecobook_search_bar.dart';

class AddMembersView extends StatefulWidget {
  const AddMembersView({super.key});

  @override
  AddMembersViewState createState() => AddMembersViewState();
}

class AddMembersViewState extends State<AddMembersView> {
  late final TextEditingController _searchController;
  final ScrollController scrollController = ScrollController();


  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title:  const Text(Strings.addMembers),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: CustomScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),




              slivers: [

                SliverPersistentHeader(
                  pinned: true,
                  delegate: PersistentHeader(
                    AppConstants.scrollUnderElevation,
                        (double shrinkOffset, double elevation) =>
                        _buildSearchBar(context, shrinkOffset, elevation),
                  ),
                ),

                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                      horizontal: AppConstants.viewPaddingHorizontal),
                  sliver: MemberList(),
                ),

              ],
            )),
            
            AppElevatedButton(title: Strings.proceedText,
            onPressed: (){},).withHorViewPadding
          ],
        ),
      ),
    );
  }

  EcobookSearchBar _buildSearchBar(
      BuildContext context, double shrinkOffset, double elevation) {
    return EcobookSearchBar(
      elevation: shrinkOffset > 0 ? elevation : 0.0,
      hint: Strings.searchMembers,
      controller: _searchController,
      // Todo : add on tap callback
    );
  }
}
