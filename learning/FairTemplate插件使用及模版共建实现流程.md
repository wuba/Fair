![pluginimage2.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/1eb0843f-56ec-4cf7-8dc3-96b7228acb7dplugin-image2.png)

## ⚙️前言

### Fair目前存在的问题

*   fair存在部分语法不支持，如if、map等语法需要使用特定语法糖
*   fair中部分业务逻辑需要plugin去实现，如网络请求、打电话等功能
*   对不熟悉fair语法的开发者解决上述问题还是有点难度的
*   fair项目中提供了example供开发者参考和使用，但没有可供开发者直接使用的颗粒度小的模版
*   fair开发者希望能够进行代码共建
    ![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/9e310f16-c398-4f3c-95ec-718f5c8b6648image.png)

### FairTemplate解决的痛点问题

1.  将58fair技术团队使用fair开发并实现基础能力如网络请求、数据加载及展示等能力的Widget、Component和Page模版代码抽取成一个模版集合，存放在github仓库作为FairTemplate插件在线模版的源仓库，前端通过IDEA插件的方式加载代码模版供开发者选择使用，用户能够挑选自己需要的模版进行快速创建和开发，同时开发者也可以贡献自己的模版。
2.  FairTemplate插件提供了模版的快速创建以及一键编译打包的能力，用户只需要对文件名或类名进行修改，就能快速编译预览，通过替换数据源就能实现开发者需求的开发，这不仅能够大大地降低开发者因为代码编写导致编译或者运行时报错的情况发生，也能有效地降低了开发者上手fair的难度。
3.  FairTemplate插件很好地简化fair的开发流程，并提供开发者一个良好的fair在线模版环境。

## 📖前置知识

1.Fair在线模版存放在[wuba/FairTemplate](https://github.com/wuba/FairTemplate)仓库，此仓库采用git-submodule的方式与[wuba/fair](https://github.com/wuba/Fair)仓库建立的关联。[了解更多](https://git-scm.com/docs/git-submodule)

2.建立关联后，会在主仓库生成一个submodule\_name\@commit\_id的超链接，点击可以直接跳转到子仓库并切到对应commit\_id分支。如下图所示：
![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/9ed0d69a-96f4-405e-8710-076950f1046dimage.png)

3.采用git-submodule的好处是可以与fair建立直接的关联，但又不会耦合fair仓库代码。简而言之就是submodule是一个独立的仓库，正常clone主仓库的代码是不会把submodule仓库的代码一同clone下来，如果需要请参考[git-submodule](https://git-scm.com/docs/git-submodule)

## 💡FairTemplate IDEA插件

FairTemplate插件目前提供以下能力：

*   Fair Build：一键编译打包，生成fair产物
*   Faircli install/server：扩展faircli脚本工具，可以通过命令行创建模版项目
*   Bundle Upload：对接FairPushy热更新平台，支持将fair编译产物上传至热更新平台
*   Fair模版创建：用户可以快速选择并创建模版，支持模版共建

用户操作流程:
![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/052e5d9d-1dfb-4e42-ae62-74bce4838c81image.png)

#### 一、FairTemplate插件安装

如果您是在Android Studio上进行fair开发

1.可以在preferences-plugins-Marketplace搜索FairTemplate并安装
![installfairtemplate.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/b7781b01-60d3-4116-b231-84b5d4ec2cafinstall-fairtemplate.png)

2.可以去[jetbrains marketplace](https://plugins.jetbrains.com/plugin/20323-fairtemplate) 搜索FairTemplate并进行安装
![fairtemplatemarketplace.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/a0b76a67-20df-40bf-8bf2-2cbf28765371fairtemplate-marketplace.png)

#### 二、FairTemplate插件使用

*   快速创建模版

> 在目标目录下右键，选择FairTemplate即可唤起模版画廊页面，操作如下图所示:
> ![fairtemplateuseinfo.gif](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/9840ada1-8e0b-4509-8e65-97ece7dc4db2fairtemplate-use-info.gif)

*   一键编译打包

> 在顶部栏选择Fair Plugin，点击Fair Build即可进行编译生成产物。此处需要注意的是，Fair项目需要是顶层目录，否则可能会造成此功能失效。

*   对接热更新平台

> 填写对应参数即可把fair产物上传至热更新平台，前提需要执行完Fair Build生成fair产物。如有不懂，可以访问[FairPushy](https://github.com/wuba/FairPushy)了解更多
> ![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/47b18062-784b-464a-be27-b7c09dba0f54image.png)

#### 三、FairTemplate插件常见问题

*   创建完模版但目录中没有对应文件？

> 刷新一下项目即可 -> Reload from disk

*   打开插件一直在loading？

> 如果长时间loading建议先访问github.com，看是否能够打开，如不能请科学上网。如果能正常访问GitHub，请检查一下event log有没有报错信息，如果有报错信息可以在[FairTemplate](https://github.com/wuba/FairTemplate)上提issue并附上相关异常信息

*   模版更新间隔是多长时间？

> 模版自动更新的时间是12个小时，后续会考虑增加手动触发更新在线模版的入口

*   如果遇到FairTemplate插件相关的问题，如何反馈呢？

> 目前插件代码还没开源，相关问题可以反馈至 [FairTemplate](https://github.com/wuba/FairTemplate)

## 🔧模版共建

### 什么是模版共建？

模版共建是基于FairTemplate IDEA插件模版画廊实现加载和选择自己或他人贡献的fair模版代码的功能。每个fair开发者都可以贡献自己的模版，旨在打造良好的fair生态。

### 模版共建流程

![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/bf17c29c-6fd1-4b53-86a9-50473103ecc3image.png)

*   开发者将**wuba/FairTemplate**仓库拉取下来，如果分支不是main请切换至main，后续代码也需要提交到main分支
*   使用fair进行编写颗粒度为Widget/Component/Page的模版代码并存放在指定的目录下
*   将编写好的模版按指定格式进行提交并创建pr
*   管理员会对提交的代码进行审核和测试，审核测试通过后会对**wuba/FairTemplate**仓库进行打tag并发布
*   FairTemplate插件在一定的时间间隔内（12小时）对模版进行更新，更新完成后开发者重新打开FairTemplate插件就可以看到所提交的模版了

### 模版共建提交格式要求

开发者需要按照指定的格式对文件进行存放和命名，否则会导致模版代码无法被加载，代码审核也不会被通过。

提交模版需要包含两个部分，一部分是模版代码本身，另一部分是模版封面图。

*   模版代码
    模版代码按照颗粒度分为3种类型，分别是widget、component和page，都管理在templates目录下

    其中widget和page对应提交的格式都是**模版目录名/模版文件名**，示例: **circle\_avatar/circle\_avatar.dart**

    component相对特殊，的目录结构对应的是**模版目录/standard/模版文件名**和**模版目录/extra/额外文件名**，如果只包含dart文件只需要提交standard即可，如果包含非dart文件，则需要放在extra一并提交。示例如: **circle\_avatar/standard/circle\_avatar.dart(如果包含非dart文件\:circle\_avatar/extra/circle\_avatar.js)**

*   模版封面图

1.  封面图统一放置在images目录下，封面图目前支持png、webp和gif等格式，目前兼容性最好的是png，建议提交时采用png格式

2.  封面图与模版关联方式->使用图片名称模糊匹配模版目录名称，为避免高度重合，建议给模版起名时慎重且细致化一点。如 **xxx\_circle\_avatar.png -> circle\_avatar**

3.  封面图与模版关联方式后续可能会进行修改，考虑使用映射表的方式

### 模版共建核心实现

*   git-submodule
    wuba/FairTemplate为独立仓库，通过git-submodule建立与wuba/fair仓库主子仓库的绑定关系，不影响wuba/fair仓库代码的拉取与提交
*   github restful api
    借助restful api中的tags api，拉取在线模版最新的tag url和版本号，进行版本比对、下载、解压并加载在线模版

## 🏷总结

感谢大家对fair的喜爱与支持，欢迎大家在fair开发过程中使用FairTemplate插件，也希望大家能够提供自己的模版代码，一起打造良好的在线模版生态～
