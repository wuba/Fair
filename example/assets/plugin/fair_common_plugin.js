let FairCommonPlugin = function () {
    return {
        http: function (resp) {
             fairCommonPluginRequest(resp, 'http');
        },
        phoneCall: function (resp) {
             fairCommonPluginRequest(resp, 'phoneCall');
        },
    }
}
