import 'dart:convert';

import 'package:flutter/foundation.dart';

class FeedReponse {
  const FeedReponse({
    this.isHistory,
    this.counts,
    this.feedlist,
    this.message,
    this.more,
    this.result,
  });

  factory FeedReponse.fromJson(Map<String, dynamic> json) {
    final List<Feedlist>? feedlist =
        json['feedList'] is List ? <Feedlist>[] : null;
    if (feedlist != null) {
      for (final dynamic item in json['feedList']!) {
        if (item != null) {
          tryCatch(() {
            feedlist.add(Feedlist.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return FeedReponse(
      isHistory: asT<bool?>(json['is_history']),
      counts: asT<int?>(json['counts']),
      feedlist: feedlist,
      message: asT<String?>(json['message']),
      more: asT<bool?>(json['more']),
      result: asT<String?>(json['result']),
    );
  }

  final bool? isHistory;
  final int? counts;
  final List<Feedlist>? feedlist;
  final String? message;
  final bool? more;
  final String? result;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'is_history': isHistory,
        'counts': counts,
        'feedList': feedlist,
        'message': message,
        'more': more,
        'result': result,
      };
}

class Feedlist {
  const Feedlist({
    this.postId,
    this.type,
    this.url,
    this.siteId,
    this.authorId,
    this.publishedAt,
    this.passedTime,
    this.excerpt,
    this.favorites,
    this.comments,
    this.rewardable,
    this.parentComments,
    this.rewards,
    this.views,
    this.collected,
    this.shares,
    this.recommend,
    this.delete,
    this.update,
    this.content,
    this.title,
    this.imageCount,
    this.images,
    this.titleImage,
    this.tags,
    this.eventTags,
    this.favoriteListPrefix,
    this.rewardListPrefix,
    this.commentListPrefix,
    this.dataType,
    this.createdAt,
    this.sites,
    this.site,
    this.recomType,
    this.rqtId,
    this.isFavorite,
    this.poiData,
    this.lastRead,
  });

  factory Feedlist.fromJson(Map<String, dynamic> json) {
    final List<Images>? images = json['images'] is List ? <Images>[] : null;
    if (images != null) {
      for (final dynamic item in json['images']!) {
        if (item != null) {
          tryCatch(() {
            images.add(Images.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<String>? tags = json['tags'] is List ? <String>[] : null;
    if (tags != null) {
      for (final dynamic item in json['tags']!) {
        if (item != null) {
          tryCatch(() {
            tags.add(asT<String>(item)!);
          });
        }
      }
    }

    final List<String>? eventTags =
        json['event_tags'] is List ? <String>[] : null;
    if (eventTags != null) {
      for (final dynamic item in json['event_tags']!) {
        if (item != null) {
          tryCatch(() {
            eventTags.add(asT<String>(item)!);
          });
        }
      }
    }

    final List<Object>? favoriteListPrefix =
        json['favorite_list_prefix'] is List ? <Object>[] : null;
    if (favoriteListPrefix != null) {
      for (final dynamic item in json['favorite_list_prefix']!) {
        if (item != null) {
          tryCatch(() {
            favoriteListPrefix.add(asT<Object>(item)!);
          });
        }
      }
    }

    final List<Object>? rewardListPrefix =
        json['reward_list_prefix'] is List ? <Object>[] : null;
    if (rewardListPrefix != null) {
      for (final dynamic item in json['reward_list_prefix']!) {
        if (item != null) {
          tryCatch(() {
            rewardListPrefix.add(asT<Object>(item)!);
          });
        }
      }
    }

    final List<Object>? commentListPrefix =
        json['comment_list_prefix'] is List ? <Object>[] : null;
    if (commentListPrefix != null) {
      for (final dynamic item in json['comment_list_prefix']!) {
        if (item != null) {
          tryCatch(() {
            commentListPrefix.add(asT<Object>(item)!);
          });
        }
      }
    }

    final List<Object>? sites = json['sites'] is List ? <Object>[] : null;
    if (sites != null) {
      for (final dynamic item in json['sites']!) {
        if (item != null) {
          tryCatch(() {
            sites.add(asT<Object>(item)!);
          });
        }
      }
    }
    return Feedlist(
      postId: asT<int?>(json['post_id']),
      type: asT<String?>(json['type']),
      url: asT<String?>(json['url']),
      siteId: asT<String?>(json['site_id']),
      authorId: asT<String?>(json['author_id']),
      publishedAt: asT<String?>(json['published_at']),
      passedTime: asT<String?>(json['passed_time']),
      excerpt: asT<String?>(json['excerpt']),
      favorites: asT<int?>(json['favorites']),
      comments: asT<int?>(json['comments']),
      rewardable: asT<bool?>(json['rewardable']),
      parentComments: asT<String?>(json['parent_comments']),
      rewards: asT<String?>(json['rewards']),
      views: asT<int?>(json['views']),
      collected: asT<bool?>(json['collected']),
      shares: asT<int?>(json['shares']),
      recommend: asT<bool?>(json['recommend']),
      delete: asT<bool?>(json['delete']),
      update: asT<bool?>(json['update']),
      content: asT<String?>(json['content']),
      title: asT<String?>(json['title']),
      imageCount: asT<int?>(json['image_count']),
      images: images,
      titleImage: asT<Object?>(json['title_image']),
      tags: tags,
      eventTags: eventTags,
      favoriteListPrefix: favoriteListPrefix,
      rewardListPrefix: rewardListPrefix,
      commentListPrefix: commentListPrefix,
      dataType: asT<String?>(json['data_type']),
      createdAt: asT<String?>(json['created_at']),
      sites: sites,
      site: json['site'] == null
          ? null
          : Site.fromJson(asT<Map<String, dynamic>>(json['site'])!),
      recomType: asT<String?>(json['recom_type']),
      rqtId: asT<String?>(json['rqt_id']),
      isFavorite: asT<bool?>(json['is_favorite']),
      poiData: json['poi_data'] == null
          ? null
          : PoiData.fromJson(asT<Map<String, dynamic>>(json['poi_data'])!),
      lastRead: asT<bool?>(json['last_read']),
    );
  }

  final int? postId;
  final String? type;
  final String? url;
  final String? siteId;
  final String? authorId;
  final String? publishedAt;
  final String? passedTime;
  final String? excerpt;
  final int? favorites;
  final int? comments;
  final bool? rewardable;
  final String? parentComments;
  final String? rewards;
  final int? views;
  final bool? collected;
  final int? shares;
  final bool? recommend;
  final bool? delete;
  final bool? update;
  final String? content;
  final String? title;
  final int? imageCount;
  final List<Images>? images;
  final Object? titleImage;
  final List<String>? tags;
  final List<String>? eventTags;
  final List<Object>? favoriteListPrefix;
  final List<Object>? rewardListPrefix;
  final List<Object>? commentListPrefix;
  final String? dataType;
  final String? createdAt;
  final List<Object>? sites;
  final Site? site;
  final String? recomType;
  final String? rqtId;
  final bool? isFavorite;
  final PoiData? poiData;
  final bool? lastRead;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'post_id': postId,
        'type': type,
        'url': url,
        'site_id': siteId,
        'author_id': authorId,
        'published_at': publishedAt,
        'passed_time': passedTime,
        'excerpt': excerpt,
        'favorites': favorites,
        'comments': comments,
        'rewardable': rewardable,
        'parent_comments': parentComments,
        'rewards': rewards,
        'views': views,
        'collected': collected,
        'shares': shares,
        'recommend': recommend,
        'delete': delete,
        'update': update,
        'content': content,
        'title': title,
        'image_count': imageCount,
        'images': images,
        'title_image': titleImage,
        'tags': tags,
        'event_tags': eventTags,
        'favorite_list_prefix': favoriteListPrefix,
        'reward_list_prefix': rewardListPrefix,
        'comment_list_prefix': commentListPrefix,
        'data_type': dataType,
        'created_at': createdAt,
        'sites': sites,
        'site': site,
        'recom_type': recomType,
        'rqt_id': rqtId,
        'is_favorite': isFavorite,
        'poi_data': poiData,
        'last_read': lastRead,
      };
}

class Images {
  const Images({
    this.imgId,
    this.imgIdStr,
    this.userId,
    this.title,
    this.excerpt,
    this.width,
    this.height,
    this.description,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        imgId: asT<int?>(json['img_id']),
        imgIdStr: asT<String?>(json['img_id_str']),
        userId: asT<int?>(json['user_id']),
        title: asT<String?>(json['title']),
        excerpt: asT<String?>(json['excerpt']),
        width: asT<int?>(json['width']),
        height: asT<int?>(json['height']),
        description: asT<String?>(json['description']),
      );

  final int? imgId;
  final String? imgIdStr;
  final int? userId;
  final String? title;
  final String? excerpt;
  final int? width;
  final int? height;
  final String? description;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'img_id': imgId,
        'img_id_str': imgIdStr,
        'user_id': userId,
        'title': title,
        'excerpt': excerpt,
        'width': width,
        'height': height,
        'description': description,
      };
}

class Site {
  const Site({
    this.siteId,
    this.type,
    this.name,
    this.domain,
    this.description,
    this.followers,
    this.url,
    this.icon,
    this.isBindEverphoto,
    this.hasEverphotoNote,
    this.videos,
    this.verified,
    this.verifications,
    this.verificationList,
    this.isFollowing,
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    final List<VerificationList>? verificationList =
        json['verification_list'] is List ? <VerificationList>[] : null;
    if (verificationList != null) {
      for (final dynamic item in json['verification_list']!) {
        if (item != null) {
          tryCatch(() {
            verificationList.add(
                VerificationList.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Site(
      siteId: asT<String?>(json['site_id']),
      type: asT<String?>(json['type']),
      name: asT<String?>(json['name']),
      domain: asT<String?>(json['domain']),
      description: asT<String?>(json['description']),
      followers: asT<int?>(json['followers']),
      url: asT<String?>(json['url']),
      icon: asT<String?>(json['icon']),
      isBindEverphoto: asT<bool?>(json['is_bind_everphoto']),
      hasEverphotoNote: asT<bool?>(json['has_everphoto_note']),
      videos: asT<int?>(json['videos']),
      verified: asT<bool?>(json['verified']),
      verifications: asT<int?>(json['verifications']),
      verificationList: verificationList,
      isFollowing: asT<bool?>(json['is_following']),
    );
  }

  final String? siteId;
  final String? type;
  final String? name;
  final String? domain;
  final String? description;
  final int? followers;
  final String? url;
  final String? icon;
  final bool? isBindEverphoto;
  final bool? hasEverphotoNote;
  final int? videos;
  final bool? verified;
  final int? verifications;
  final List<VerificationList>? verificationList;
  final bool? isFollowing;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'site_id': siteId,
        'type': type,
        'name': name,
        'domain': domain,
        'description': description,
        'followers': followers,
        'url': url,
        'icon': icon,
        'is_bind_everphoto': isBindEverphoto,
        'has_everphoto_note': hasEverphotoNote,
        'videos': videos,
        'verified': verified,
        'verifications': verifications,
        'verification_list': verificationList,
        'is_following': isFollowing,
      };
}

class VerificationList {
  const VerificationList({
    this.verificationType,
    this.verificationReason,
  });

  factory VerificationList.fromJson(Map<String, dynamic> json) =>
      VerificationList(
        verificationType: asT<int?>(json['verification_type']),
        verificationReason: asT<String?>(json['verification_reason']),
      );

  final int? verificationType;
  final String? verificationReason;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'verification_type': verificationType,
        'verification_reason': verificationReason,
      };
}

class PoiData {
  const PoiData({
    this.id,
    this.name,
  });

  factory PoiData.fromJson(Map<String, dynamic> json) => PoiData(
        id: asT<String?>(json['id']),
        name: asT<String?>(json['name']),
      );

  final String? id;
  final String? name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
      };
}

void tryCatch(Function f) {
  try {
    f.call();
  } catch (e, stack) {
    debugPrint('$e');
    debugPrint('$stack');
  }
}

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  if (value != null) {
    final String valueS = value.toString();
    if (0 is T) {
      return int.tryParse(valueS) as T?;
    } else if (0.0 is T) {
      return double.tryParse(valueS) as T?;
    } else if ('' is T) {
      return valueS as T;
    } else if (false is T) {
      if (valueS == '0' || valueS == '1') {
        return (valueS == '1') as T;
      }
      return (valueS == 'true') as T;
    }
  }
  return null;
}
