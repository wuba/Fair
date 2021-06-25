GLOBAL['fair_cell'] =(function() {
    var __global__ = this;

    class LouPanDetail {
        constructor(id, number, type, goodsId, imgUrl, goodsDesc, isSelected = true) {
          this.id = id;
          this.number = number;
          this.goodsId = goodsId;
          this.type = type;
          this.imgUrl = imgUrl;
          this.goodsDesc = goodsDesc;
          this.isSelected = isSelected;
        }
    }

    class GoodsDesc {
      constructor(boldText, normalText) {
        this.boldText = boldText;
        this.normalText = normalText;
      }
    }

    return {
                data: {
//                    _louPanDetail: (JSON.parse('#(FairProps)'))._louPanDetail
                      _louPanDetail: {          id: 1,
                                                number: 100 * 20,
                                                type: 0,
                                                goodsId: 111,
                                                imgUrl:
                                                    "http://pic1.ajkimg.com/display/anjuke/d6e675-%E5%8E%A6%E9%97%A8%E6%B5%8B%E8%AF%95%E5%85%AC%E5%8F%B8/3ed05d79ec1de21e4fbbaf146573985a-800x570.jpg",
                                                goodsDesc: [{boldText: "汤臣一品", normalText: ""}, {boldText: "", normalText: "上海浦东新区陆家嘴"}, {boldText: "3000", normalText: "万"}],
                                      },

                },

                onLaunch: function onLaunch()  {
                    Console.log("onLaunch");
                },

                onDispose: function onDispose()  {
                    Console.log("onDispose");
                },

                _iconLoupan: function _iconLoupan() {
                    return this.data._louPanDetail.imgUrl;
                },

                _generateTitle: function _generateTitle() {
                    return this.data._louPanDetail.goodsDesc[0].boldText +
                                this.data._louPanDetail.goodsDesc[0].normalText;
                },

                _generateSubtitle: function _generateSubtitle() {
                    return this.data._louPanDetail.goodsDesc[1].normalText;
                },

                _generatePrice: function _generatePrice() {
                    return this.data._louPanDetail.goodsDesc[2].boldText;
                },

                _generateUnit: function _generateUnit() {
                    return this.data._louPanDetail.goodsDesc[2].normalText;
                },
                _onImageTap: function _onImageTap() {
                    this.data._louPanDetail.goodsDesc[0].normalText = ' ##';
                    setData("fair_cell", {_louPanDetail: this.data._louPanDetail});
                },
                _onItemTap: function _onItemTap() {
                    this.data._louPanDetail.goodsDesc[0].normalText = ' ++';
                    setData("fair_cell", {_louPanDetail: this.data._louPanDetail});
                }
   }})()
