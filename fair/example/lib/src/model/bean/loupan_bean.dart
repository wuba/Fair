/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

class LouPanDetail {
  int? id;
  int? number;
  int? goodsId;
  int? type;
  String? imgUrl;
  List<GoodsDesc?>? goodsDesc;
  bool? isSelected;

  LouPanDetail({this.id, this.number, this.type, this.goodsId, this.imgUrl, this.goodsDesc, this.isSelected = true});

  factory LouPanDetail.fromJson(Map<String, dynamic> json) => LouPanDetail(
    goodsDesc: (json['goodsDesc'] as List)
        ?.map((e) =>
    e == null ? null : GoodsDesc.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as int,
    number: json['number'] as int,
    goodsId: json['goodsId'] as int,
    type: json['type'] as int,
    imgUrl: json['imgUrl'] as String,
    isSelected: json['isSelected'] as bool,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'goodsDesc': goodsDesc,
    'id': id,
    'number': number,
    'goodsId': goodsId,
    'type': type,
    'imgUrl': imgUrl,
    'isSelected': isSelected
  };

}

class GoodsDesc {
  String? boldText;
  String? normalText;

  GoodsDesc({this.boldText, this.normalText});


  factory GoodsDesc.fromJson(Map<String, dynamic> json) => GoodsDesc(
    boldText: json['boldText'] as String,
    normalText: json['normalText'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'boldText': boldText,
    'normalText': normalText,
  };
}
