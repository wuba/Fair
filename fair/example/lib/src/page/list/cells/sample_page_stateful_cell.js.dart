part of 'sample_page_stateful_cell.dart';  

  // FairProps 注解标记为接受父组件传入数据的接受变量，每个文件只能有一个
  @FairProps()
  LouPanDetail _louPanDetail;

  String _loupanIcon() {
    return _louPanDetail.imgUrl;
  }

  String _generateTitle() {
    return _louPanDetail.goodsDesc[0].boldText +
        _louPanDetail.goodsDesc[0].normalText;
  }

  String _generateSubtitle() {
    return _louPanDetail.goodsDesc[1].normalText;
  }

  String _generatePrice() {
    return _louPanDetail.goodsDesc[2].boldText;
  }

  String _generateUnit() {
    return _louPanDetail.goodsDesc[2].normalText;
  }

  void _onImageTap() {
    _louPanDetail.goodsDesc[0].normalText = ' ##';
    // setState(() {});
  }

  void _onItemTap() {
    _louPanDetail.goodsDesc[0].normalText = ' ++';
    // setState(() {});
  }