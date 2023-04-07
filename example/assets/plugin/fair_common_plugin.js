let FairCommonPlugin = function () {
    return {
        http: function (resp) {
            fairCommonPluginRequest(resp, 'http');
        }       
    }
}