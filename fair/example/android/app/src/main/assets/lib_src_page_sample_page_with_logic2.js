GLOBAL['hello_world2'] = (function () {
    var __global__ = this;

    class DemoItem {
        constructor(a, b) {
            this.id = a;
            this.name = b;
        }
    }

    class DemoList {
        constructor() {
            this.list = new Array();
            this.list.push(new DemoItem(5 * 2, "58"));
            this.list.push(new DemoItem(5 * 4, "fair"));
            this.total = 2;
        }
    }

    return HelloLogicPage = {
        props: "#(FairProps)",
        data: {
            _count: 10,
            _response: new DemoList(),
        },
        _isCanMod2: function _isCanMod2() {
            return this.data._response.total % 2 == 1;

        },
        onTapText: function onTapText() {
            this.data._count++;
            this.data._response.total = this.data._response.total + 1;
            let map = {
                _count: this.data._count
            }
            setData("hello_world2",map);

        },
        _initData: function _initData(id) {
//         FairNet.request({url:"http://op.juhe.cn/onebox/weather/query",header: {"Content-Type" : "application/x-www-form-urlencoded"},method:"POST",data: {"cityname" : "上海", "key" : "1430ec127e097e1113259c5e1be1ba70"},complete:function dummy(value)  {
//     _data.count = value['count'];
//   this.setData({count: that.data._data._count});
//
//   }});

        }, onLaunch: function onLaunch() {

        },
        onDispose: function onDispose() {
            Console.log("onDispose");
        }

    }
})()
