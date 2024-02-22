import 'dart:convert';

import 'community_feed_model.dart';
import 'members_model.dart';

class Community {
  final String? id;
  final String name;
  final List<Member>? members;
  final List<String> userIds;
  final String creatorUsername;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String> username;
  final String? description;
  final String? communityDp;
  final bool isJoined;
  final List<CommunityPost>? communityPost;

  Community({
    required this.creatorUsername,
    this.description,
    this.members,
    required this.userIds,
    this.isJoined = false,
    required this.id,
    required this.name,
    this.createdAt,
    this.communityPost,
    this.updatedAt,
    required this.username,
    required this.communityDp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'username': username,
      'creatorUsername' : creatorUsername,
      'description' : description,
      'communityHeaderImgUrl': communityDp,
    };
  }

  factory Community.fromMap(Map<String, dynamic> map) {


    List<Member>? members = _extractMembers(map['members']);
    List<CommunityPost>? posts = _extractPosts(map['communityFeeds']);

    String creatorUsername = '';

    if (map.containsKey('communityFeeds') && map['communityFeeds'] is List) {
      List<dynamic> feeds = map['communityFeeds'];
      for (var feed in feeds) {
        if (feed is Map<String, dynamic> &&
            feed.containsKey('creator') &&
            feed['creator'] is Map<String, dynamic> &&
            feed['creator'].containsKey('username')) {
          creatorUsername = feed['creator']['username'] as String;
          break;
        }
      }
    }


    List<String> usernames = [];
    List<String> userIds = [];
    if (map.containsKey('members') && map['members'] is List) {
      List<dynamic> membersList = map['members'];

      for (var member in membersList) {
        if (member is Map<String, dynamic> && member.containsKey('username')) {
          usernames.add(member['username'] as String);
        }
      }

      for (var member in membersList) {
        if (member is Map<String, dynamic> && member.containsKey('id')) {
          userIds.add(member['id'] as String);
        }
      }
    }

    return Community(
      id: map['id'] as String,
      creatorUsername: creatorUsername,
      description: map['description'] as String,
      name: map['name']as String,
      username: usernames,
      userIds: userIds,
      communityPost: posts,
      members: members,
      communityDp: map['communityHeaderImgUrl'] != null
          ? map['communityHeaderImgUrl'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
    );
  }

  static List<CommunityPost>? _extractPosts(List<dynamic>? postList) {
    if (postList == null) return null;

    final posts = <CommunityPost>[];
    for (final postObj in postList) {
      if (postObj is Map<String, dynamic>) {
        final post = CommunityPost.fromMap(postObj);
        posts.add(post);
      }
    }
    return posts;
  }

  static List<Member>? _extractMembers(List<dynamic>? memberList) {
    if (memberList == null) return null;

    final members = <Member>[];
    for (final memberObj in memberList) {
      if (memberObj is Map<String, dynamic>) {
        final member = Member.fromMap(memberObj);
        members.add(member);
      }
    }
    return members;
  }

  String toJson() => json.encode(toMap());

  factory Community.fromJson(String source) =>
      Community.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Community(id: $id, userIds : $userIds, creator : $creatorUsername, username : $username, createdAt: $createdAt, updatedAt: $updatedAt, image : $communityDp,  content : $name)';
  }

  factory Community.dummy() {
    return Community(
      id: 'id',
      userIds: ['userIds'],
      name: 'Community Name',
      username: ['username'],
      creatorUsername: 'creatorUsername',
      communityDp: 'QmStu4AZcMpbCKMamPB4hZfwMNMh7BztQBxhcWShP1U8RC',
    );
  }


  Community copyWith({
    String? id,
    String? name,
    List<String>? userIds,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? username,
    String? description,
    String? communityDp,
    String? creatorUserName,
    List<Member>? members,
    List<CommunityPost>? communityPost,
    bool? isJoined,

  }) {
    return Community(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      username: username ?? this.username,
      userIds: userIds ?? this.userIds,
      creatorUsername: creatorUserName ?? creatorUsername,
      description: description ?? this.description,
      communityDp: communityDp ?? this.communityDp,
      members: members ?? this.members,
      isJoined: isJoined ?? this.isJoined,
      communityPost: communityPost ?? this.communityPost
    );
  }
}
