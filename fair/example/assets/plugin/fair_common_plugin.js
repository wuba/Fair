let FairCommonPlugin = function () {
    return {
        http: function (resp) {
            fairCommonPluginRequest(resp, 'http');
        },
        requestPermission: function (resp) {
            fairCommonPluginRequest(resp, 'requestPermission');
        },
        selectPhoto: function (resp) {
            fairCommonPluginRequest(resp, 'selectPhoto');
        }                  
    }
}