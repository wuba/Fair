    GLOBAL['#FairPageName#'] = (function(__initProps__) {
      const __global__ = this;
              function LouPanDetail() {
                    const inner = LouPanDetail.__inner__;
          if (this == __global__) {
            return new LouPanDetail({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            LouPanDetail.prototype.ctor.apply(this, args);
            return this;
          }

        }
        LouPanDetail.__inner__ = function inner() {

          this.id = null;this.number = null;this.goodsId = null;this.type = null;this.imgUrl = null;this.goodsDesc = null;this.isSelected = null;
        };
        LouPanDetail.prototype = {
          ctor: function ctor({id,number,type,goodsId,imgUrl,goodsDesc,isSelected=true}={}) {
            const __thiz__ = this;
      const __arg_ctx__ = {id,number,type,goodsId,imgUrl,goodsDesc,isSelected,};

            with (__thiz__) {
            with (__arg_ctx__) {
      Object.prototype.ctor.call(__thiz__);
this.id = id;
this.number = number;
this.type = type;
this.goodsId = goodsId;
this.imgUrl = imgUrl;
this.goodsDesc = goodsDesc;
this.isSelected = isSelected;
    }

      }



    },
                    toJson: function() {
            let res = {};
            res.id = this.id;
res.number = this.number;
res.goodsId = this.goodsId;
res.type = this.type;
res.imgUrl = this.imgUrl;
res.goodsDesc = this.goodsDesc;
res.isSelected = this.isSelected;
            return JSON.stringify(res);
          },

        };



                LouPanDetail.fromJson = function(json) {
            if (typeof json == 'string') {
              json = JSON.parse(json);
            }
            var res = new LouPanDetail();
            res.id = json.id;
res.number = json.number;
res.goodsId = json.goodsId;
res.type = json.type;
res.imgUrl = json.imgUrl;
res.goodsDesc = json.goodsDesc;
res.isSelected = json.isSelected;
            return res;
          };



        function GoodsDesc() {
                    const inner = GoodsDesc.__inner__;
          if (this == __global__) {
            return new GoodsDesc({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            GoodsDesc.prototype.ctor.apply(this, args);
            return this;
          }

        }
        GoodsDesc.__inner__ = function inner() {

          this.boldText = null;this.normalText = null;
        };
        GoodsDesc.prototype = {
          ctor: function ctor({boldText,normalText}={}) {
            const __thiz__ = this;
      const __arg_ctx__ = {boldText,normalText,};

            with (__thiz__) {
            with (__arg_ctx__) {
      Object.prototype.ctor.call(__thiz__);
this.boldText = boldText;
this.normalText = normalText;
    }

      }



    },
                    toJson: function() {
            let res = {};
            res.boldText = this.boldText;
res.normalText = this.normalText;
            return JSON.stringify(res);
          },

        };



                GoodsDesc.fromJson = function(json) {
            if (typeof json == 'string') {
              json = JSON.parse(json);
            }
            var res = new GoodsDesc();
            res.boldText = json.boldText;
res.normalText = json.normalText;
            return res;
          };



      return         {
          data: {
            _louPanDetail: __initProps__,
          },
          _loupanIcon: function _loupanIcon() {
            const __thiz__ = this.data;


            with (__thiz__) {
            return _louPanDetail.imgUrl;

      }



    },_generateTitle: function _generateTitle() {
            const __thiz__ = this.data;


            with (__thiz__) {
            return _louPanDetail.goodsDesc.__op_idx__(0).boldText+_louPanDetail.goodsDesc.__op_idx__(0).normalText;

      }



    },_generateSubtitle: function _generateSubtitle() {
            const __thiz__ = this.data;


            with (__thiz__) {
            return _louPanDetail.goodsDesc.__op_idx__(1).normalText;

      }



    },_generatePrice: function _generatePrice() {
            const __thiz__ = this.data;


            with (__thiz__) {
            return _louPanDetail.goodsDesc.__op_idx__(2).boldText;

      }



    },_generateUnit: function _generateUnit() {
            const __thiz__ = this.data;


            with (__thiz__) {
            return _louPanDetail.goodsDesc.__op_idx__(2).normalText;

      }



    },_onImageTap: function _onImageTap() {
            const __thiz__ = this.data;


            with (__thiz__) {
        _louPanDetail.goodsDesc.__op_idx__(0).normalText = ' ##';
      }



    },_onItemTap: function _onItemTap() {
            const __thiz__ = this.data;


            with (__thiz__) {
        _louPanDetail.goodsDesc.__op_idx__(0).normalText = ' ++';
      }



    },
        }
        ;
    })(JSON.parse('#FairProps#'));

