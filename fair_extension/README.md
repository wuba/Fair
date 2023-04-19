# 背景
关于Fair 的动态化能力支持，涉及到如下几个方面：
- 平台相关能力，如打电话、定位、权限申请、相机等
- 业务逻辑相关，路由、埋点等
  需要提前内置逻辑，否则开发阶段需要使用这些能力时，需要发版内置，丧失了Fair 动态化能力的优势。

为了避免出现上述问题，我们希望在Fair 接入阶段，就内置常用的业务逻辑。并且我们把通用的业务逻辑以扩展包的形式提供给开发者。开发者在Fair 接入阶段，通过依赖扩展包，经过简单的配置，就可以实现常用业务逻辑的支持。

## 接入说明
#### 添加fair_extension 依赖

```
fair_extension: 1.0.0
```

#### fair_extension 初始化
fair 初始化中，设置plugins 及 jsPlugins。

```
FairApp.runApplication(
      FairApp(
        child: const MyApp(),
      ),
      plugins: FairExtension.plugins,
      jsPlugins: FairExtension.jsPlugins);
```

#### fair_extension 使用
详见[example](./example)  
