(function() {
    var __global__ = this;
    class DemoItem {
        constructor(a, b) {
           this.id = a;
           this.name = b;
        }
    }

    class DemoList {
        constructor() {
            this.list =  new Array();
            this.list.push(new DemoItem(5 * 2, "58"));
            this.list.push(new DemoItem(5 * 4, "fair"));
            this.total = 2;
        }
    }

     return HelloLogicPage = {
          props: "#(FairProps)",
         data: {
           _response: new DemoList(),
         },
         _isCanMod2: function _isCanMod2()  { 
         return this.data._response.total%2==1;
   
   },_onTapText: function _onTapText()  { 
     this.data._response.total = this.data._response.total+1;
   this.setState('#FairKey#',{_response: this.data._response});
   
   },_initData: function _initData(id)  {
   
   },onLoad: function onLoad()  {

       },
         onUnload: function onUnload()  {
                      Console.log("onUnload");
                 }
       
   }})
