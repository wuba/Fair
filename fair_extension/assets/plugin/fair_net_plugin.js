let FairNetCallBack = {};
let callBackId = 0;

class FairNet {

	static GET = 'GET';
	static POST = 'POST';

	static requestData(req) {
		let respMap = {};
		let id = 'FairNet$' + (callBackId++);
		// 设置回调
		let reqFunc = {};
		if (req.complete) {
			reqFunc['complete'] = req.complete;
		}
		if (req.success) {
			reqFunc['success'] = req.success;
		}
		if (req.failure) {
			reqFunc['failure'] = req.failure;
		}
		FairNetCallBack[id] = reqFunc;
		// 处理参数
		let method = '';
		if (req.method) {
			method = req.method;
		}
		let url = '';
		if (req.url) {
			url = req.url;
		}
		let data = {};
		if (req.data) {
		    data = mapOrSetToObject(req.data);
		}
		let reqMap = {
			pageName: '#FairKey#',
			funcName: 'invokePlugin',
			'className': 'FairNet#requestData',
			args: {
				callId: id,
				method: method,
				url: url,
				data: data
			}
		};
		invokeFlutterCommonChannel(JSON.stringify(reqMap), (resultStr) =>{
			let responseMap = JSON.parse(resultStr);
			let data = responseMap['data'];
			responseMap['data'] = data.data;
			let id = responseMap['callId'];
			//处理需要返回的结果值
			let callback = FairNetCallBack[id];
			if (callback == null) {
				return
			}
			let complete = callback['complete'];
			let failure = callback['failure'];
			let success = callback['success'];
			if (responseMap['statusCode'] === 200) {
				if (complete != null) {
					complete();
				}
				if (success != null) {
					success(convertObjectLiteralToSetOrMap(responseMap));
				}
			} else {
				if (complete != null) {
					complete();
				}
				if (failure != null) {
					failure(responseMap['statusMessage']);
				}
			}
		})
	}
}