          
     
Object.defineProperties(Number.prototype, {
    // bitLength: {

    // },
    isEven: {
        get: function(){
            return this%2 == 0 ? true:false
        }
    },
    isOdd: {
        get: function(){
            return this%2 == 0 ? false:true
        }
    },
    sign: {
        get: function(){
            // 符号 正数1、负数-1和0
            return this!=0 ? Math.abs(this) != this ? -1 : 1 : 0
        }
    },
    // hashCode: {
    //     get: function(){
            
    //     }
    // },
    isFinite: {
        get: function(){
            // 是否有限
            return isFinite(this)
        }
    },
    isInfinite: {
        get: function(){
            // 是否无穷
            return !isFinite(this)
        }
    },
    isNaN: {
        get: function(){
            // 是否NaN
            return isNaN(this)
        }
    },
    isNegative: {
        get: function(){
            // 是否为负数
            return this<0 ? true:false
        }
    },
    runtimeType: {
        get: function(){
            // 运行时的类型 ？？ 待定
            return typeof this
        }
    }
})

Number.prototype.abs = function() {
    return Math.abs(this)
}
Number.prototype.ceil = function() {
    return Math.ceil(this)
}
Number.prototype.ceilToDouble = function() {
    return (Math.ceil(this)).toFixed(1)
}
Number.prototype.clamp = function(lowerLimit, upperLimit) {     
    return this < lowerLimit ? lowerLimit : this > upperLimit ? upperLimit : Number(this);
}
Number.prototype.compareTo = function(other) {     
    return this < other ? -1 : 1
}
Number.prototype.floor = function() {   
    // 向下取整  
    return Math.floor(this)
}
Number.prototype.floorToDouble = function() {   
    // 向下取整转浮点  
    return (Math.floor(this)).toFixed(1)
}
Number.prototype.remainder = function(other) {   
    // 取余
    return this%other
}
Number.prototype.round = function() {   
    // 四舍五入
    return Math.round(this)
}
Number.prototype.roundToDouble = function() {   
    // 四舍五入转浮点
    return (Math.round(this)).toFixed(1)
}
Number.prototype.toDouble = function() {   
    // 转浮点
    return this != Math.floor(this) ? Number(this) : this.toFixed(1)
}
Number.prototype.toInt = function() {   
    // 取整数部分
    return parseInt(this)
}
Number.prototype.toStringAsExponential = function(n) {   
    // 返回几次幂值的字符串(科学记数法)
    return this.toExponential(n)
}
Number.prototype.toStringAsFixed = function(n) {   
    // 保留n位小数
    return this.toFixed(n)
}
Number.prototype.toStringAsPrecision = function(n) {   
    // 保留几位小数后精确结果的字符串
    return this.toPrecision(n)
}
Number.prototype.truncate = function() {   
    // 取整
    return  parseInt(this)
}
Number.prototype.truncateToDouble = function() {   
    // 取整返回浮点型
    return parseInt(this).toFixed(1)
}

// 定义原始类型方法
Number.parse = function(source){
    // 只转整数，小数报错
    if( parseInt(source) == source ){
        return parseInt(source);
    }
    else{
        throw 'FormatException: Invalid radix-10 number';
    }
}
Number.tryParse = function(source){
    if( parseInt(source) == source ){
        return parseInt(source);
    }
    else{
        return null;
    }
}
global.Number = Number;
