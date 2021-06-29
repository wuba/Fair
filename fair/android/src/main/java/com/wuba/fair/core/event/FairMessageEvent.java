package com.wuba.fair.core.event;

import com.wuba.fair.FairPlugin;
import com.wuba.fair.FairPlugin2;
import com.wuba.fair.constant.FairConstant;
import com.wuba.fair.jsexecutor.IJSExecutor;
import com.wuba.fair.thread.FairThread;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StringCodec;

/**
 * 用于native-flutter之间的消息传递
 */
public class FairMessageEvent {
    private MethodChannel methodChannel;
    private BasicMessageChannel<String> msgChannel;

    public FairMessageEvent() {
        setupMessageChannel();
    }

    private void setupMessageChannel() {
        methodChannel = new MethodChannel(FairPlugin.get().getBinaryMessenger(),
                FairConstant.FLUTTER_LOADER_MESSAGE_CHANNEL);
        methodChannel.setMethodCallHandler(methodHandler);

        msgChannel = new BasicMessageChannel<>(
                FairPlugin2.get().getBinaryMessenger(), FairConstant.FLUTTER_COMMON_MESSAGE_CHANNEL,
                StringCodec.INSTANCE);

        msgChannel.setMessageHandler(callHandler);
    }


    /**
     * 接收dart返回结果，执行js，获取js的结果返回给dart端，
     */
    private BasicMessageChannel.MessageHandler<String> callHandler = (message, reply) -> {
//        Object obj;
//        try {
//            IJSExecutor executor = FairPlugin2.get().getJsExecutor();
//            obj = executor.invokeJSChannel(message);
//            FairThread.runOnUI(() -> {
//                reply.reply(String.valueOf(obj));
//            });
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    };


    private MethodChannel.MethodCallHandler methodHandler = (call, result) -> {
        switch (call.method) {
            case FairConstant.LOAD_MAIN_JS:
//                loadMainJs(call.arguments, result::success);
                break;
            case FairConstant.RELEASE_MAIN_JS:
//                releaseJsObject(call.arguments);
                break;
            default:
                break;
        }
    };
}
