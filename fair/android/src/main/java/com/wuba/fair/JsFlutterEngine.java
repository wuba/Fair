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

    /**
     * 接收dart返回结果，执行js，获取js的结果返回给dart端，
     */
    private BasicMessageChannel.MessageHandler<String> callHandler = (message, reply) -> {
        Object obj;
        try {
            IJSExecutor executor = FairPlugin.get().getJsExecutor();
            obj = executor.invokeJSChannel(message);
            reply.reply(String.valueOf(obj));
        } catch (Exception e) {
            e.printStackTrace();
        }
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
