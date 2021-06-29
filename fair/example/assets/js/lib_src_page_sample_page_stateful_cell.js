GLOBAL['#FairPageName#'] = (function() {
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

    _fairProps = (JSON.parse('#FairProps#'));

    return {
                data: {
                    _louPanDetail:_fairProps,
                },

                onLaunch: function onLaunch()  {
                    console.log("onLaunch");
                },

                onDispose: function onDispose()  {
                    console.log("onDispose");
                },

                _loupanIcon: function _loupanIcon() {
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
                    setData('#FairPageName#', {_louPanDetail: this.data._louPanDetail});
                },
                _onItemTap: function _onItemTap() {
                    this.data._louPanDetail.goodsDesc[0].normalText = ' ++';
                    setData('#FairPageName#', {_louPanDetail: this.data._louPanDetail});
                }
   }})()
