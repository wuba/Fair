package com.wuba.fair;

import com.wuba.fair.constant.FairConstant;
import com.wuba.fair.jsexecutor.IJSExecutor;

import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StringCodec;

/**
 * 负责处理dart端发来的请求
 */
public class JsFlutterEngine {

    public JsFlutterEngine() {
        setupChannel();
    }

    private BasicMessageChannel<String> msgChannel;

    private void setupChannel() {
        msgChannel = new BasicMessageChannel<>(
                FairPlugin.get().getBinaryMessenger(), FairConstant.FLUTTER_COMMON_MESSAGE_CHANNEL,
                StringCodec.INSTANCE);

        msgChannel.setMessageHandler(callHandler);
    }

    private BasicMessageChannel.MessageHandler<String> callHandler = (message, reply) -> {
        //todo 处理来在dart的请求，准备走同一个js中的方法
        IJSExecutor executor = FairPlugin.get().getJsExecutor();
        executor.invokeJSChannel(message);


//            JSONObject jsonObject = new JSONObject(message);
//            String type = jsonObject.getString("type");
//            String pageName = jsonObject.getString("pageName");
//            String data = jsonObject.getString("data");
//            JSONObject dataObject = new JSONObject(data);
//
//            IJSExecutor executor = FairPlugin.get().getJsExecutor();
//            switch (type) {
//                //获取js中的变量
//                case "variable":
//                    FairThread.get().run(() -> {
//                        JSONObject dataObj = new JSONObject();
//                        Iterator<String> keys = dataObj.keys();
//
//                        JSONArray jsNames = new JSONArray();
//
//                        while (keys.hasNext()) {
//                            jsNames.put(keys.next());
//                        }
//                        //如果未传入要获取的变量值，那么返回全部的变量值，否则只返回传入的指定的变量
//                        Object result2 = executor.invokeVariables(pageName, jsNames.toString());
//                        FairThread.runOnUI(() -> reply.reply(result2.toString()));
//                    });
//                    break;
//                //调用js中的方法
//                case "method":
//                    FairThread.get().run(() -> {
//                        try {
//                            String funcName = dataObject.getString("funcName");
//                            JSONArray args = dataObject.getJSONArray("args");
//                            Object[] par = new Object[args.length()];
//                            for (int i = 0; i < args.length(); i++) {
//                                par[i] = args.get(i);
//                            }
//                            Object invokeR = executor.invokeMethod(pageName, funcName, par);
//                            FairThread.runOnUI(() -> reply.reply(wrapperResult(invokeR.toString())));
//                        } catch (JSONException e) {
//                            e.printStackTrace();
//                        }
//                    });
//                    break;
//                //通知js计算某个脚本
//                case "evaluate":
//                    FairThread.get().run(() -> {
//                        String js = null;
//                        try {
//                            js = dataObject.getString("js");
//                        } catch (JSONException e) {
//                            e.printStackTrace();
//                        }
//                        Object result = executor.evaluateJS(pageName, js);
//                        FairThread.runOnUI(() -> reply.reply(wrapperResult(result.toString())));
//                    });
//                    break;
//                default:
//                    break;
//
//            }
    };

    private String wrapperResult(String src) {
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("result", src);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return jsonObject.toString();
    }

    /**
     * 发送信息到dart端，并接收dart返回的结果
     */
    public void invokeFlutterChannel(String msg, BasicMessageChannel.Reply<String> reply) {
        msgChannel.send(msg, reply);
    }

}
