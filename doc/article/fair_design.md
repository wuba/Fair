# Flutter Fair: A new package used to update widget tree dynamically

![fair logo](https://cdn-images-1.medium.com/max/1600/1*uzMOc9unz1cAuMh0ZwWCVQ.png)

> Original published on medium.com [Flutter Fair: A new package used to update widget tree dynamically](https://medium.com/p/98f6f94cb2bf)

## Why create Flutter Fair?

Dynamic feature is almost mentioned in every cross-platform framework. From traditional Web/H5 to React Native, many mobile products depend on dynamic ability to dispatch new features or bug fix. And some team use RN rather than Native, just because RN pages can be updated through remote bundle files.

However this case is not possible for Flutter as it can violate the [AppStore’s review guidelines](https://developer.apple.com/app-store/review/guidelines/#software-requirements). And the Flutter team has removed code push from its roadmap for 2019: [Code Push / Hot Update / out of band updates #14330](https://github.com/flutter/flutter/issues/14330#issuecomment-485565194)

Flutter Fair is aimed to update widget tree without code push. This bring us the ability to dispatch new UI widgets/pages. We take control of how to generate widget tree with bundle files. After widgets are constructed, they will be rendered by Flutter engine. These dynamic widgets/pages can also work with predefined BLOC component inside Flutter App.

## Prototype exploration

In order to design the Fair package, we did some prototype exploration to make sure we can handle this. Including community research to find valuable resources.

If you have already read the Flutter documents, you may known that Flutter pipeline has several stages. There are three trees related to UI:

- Widget tree
- Element tree
- RenderObject tree

All we need to do is generate the widget tree in a proper way, then leave it to Flutter itself.

To make a dynamic widget, we use json structure to describe the widget configuration. In Flutter, we declare UI with nested widgets layer, this make json reasonable and quite simple.

Here is a ListView constructed by json description.

![img](https://cdn-images-1.medium.com/max/1600/0*K66AmAmhBJEprgj6.png)

JSON description:

```dart
{
  "className": "ListView.builder",
  "na": {
    "itemBuilder": "#(bizColorLabelBuilder)",
    "itemCount": 50
  }
}
```

Dart source code:

```dart
ListView.builder(
  itemBuilder: bizColorLabelBuilder,
  itemCount: 50,
);
```

In this demo, we’ve finally figure out three things:

1. JSON based definition of DSL bundle
2. Variable reference in Widget parameters
3. Widget convertor used to construct a Widget from JSON

## Fair — Flutter over the air

Our demo is still far away from stable package. So we need to think more about what feature is required if we wish to make a useable flutter package.

> I/O definition

Our main purpose is to deliver widgets description as bundle file, so it can be update through local assets or URI resource.

![IO direction](https://cdn-images-1.medium.com/max/1600/0*AdLD-ste2U49vvJm.png)

From the developer’s point of view, we hope that the developer will be aware of the development changes as little as possible. The use of Fair should be transparent in details as much as possible. This requires that we provide a middleware (compiler) to implement this “transparent action”.

In the perspective of Flutter, we need to correctly identify the products of the convention format. This requires that we provide a DartVM capable parser (runtime) that does “run” the artifacts.

From the App perspective, we need to manage artifacts, such as loading, persistence, version control, etc. This requires us to provide a set of back-end product management system and mobile loading system.

According to the I/O relationship from different perspectives, we can plan several modules coarse-grained：

- The Fair Plugin: responsible for loading, parsing, and finally displaying the bundle in the form of flutter.
- Fair Binding Tool: assists with build tools that provide automated transformation capabilities.
- Fair Manager Server: simple Resource management service.
- Fair Manager API: Android/iOS side and services used with it

![img](https://cdn-images-1.medium.com/max/1600/0*GodzIJ7k7t4M3ZFl.png)

> Hands on Fair SDK

Before moving on to the technical details of Fair, let’s take a look at how to use the SDK. The recommended access posture is as follows: wrap the App in a FairApp component, and you can have fun with all the other widgets:

![img](https://cdn-images-1.medium.com/max/1600/0*TjPFF6GBgKWjWDkn.png)

In FairApp, each dynamic page is a FairWidget that can provide a “bundle” with input:

```dart
FairWidget(
  path: 'assets/bundle/lib_page_dynamic_widget.fair.bin',
  data: {'content': 'Red Box'},
)
```

Where did this bin come from? The bin resource is a product that Fair can identify, which can be understood as a bundle. It can be written by hand or generated automatically through Fair. To turn a ready-made Flutter page into a bundle, you need to add an annotation:

1. Add the @FairPatch annotation to the target page
2. Add the @FairWell annotation to the data object

![img](https://cdn-images-1.medium.com/max/1600/0*fECj-wrEciq1qY7F.png)
Red box sample

Currently, not all Flutter widgets can be converted painlessly with one click. Fair supports transformation of layout classes by default, which requires no logical operations in the build. If there is logic, you need to manually encapsulate or provide the proxy binding object.

## Fair architecture

Flutter Fair is evolved from prototype, many external APIs has changed many times in the early stage of development, until they gradually converged and stabilized in the later stage. In the coding process, we need to consider the final effect. The package cannot be arbitrary as in the prototype, we have been convergent parameters to improve readability.

The Fair package can be rendered in a plain structure diagram, with the front and back servers removed, there are three pieces:

![img](https://cdn-images-1.medium.com/max/1600/0*g93Od4zIwx_e0XnH.png)

In the “runtime” section, it includes the bundle resource loader, the parser, and the component agent layer. The “compiler” section is not like a language compiler. Fair Compiler is a compilation tool based on the build runner mechanism of the Flutter. It is mainly used to generate binding and bundle for dart code.

> Version compatibility

Everyone who developed Flutter knows that the Flutter version iterates very fast, so it’s worth thinking about how to do a good job of version compatibility.

Some tech teams may have been developed early and used an “older version” such as 1.17.x. As of this writing (2020.11.03), the stable version of flutter is 1.22.x now. Although Fair’s API rarely uses a version-specific API, but in order to implement dynamic components, we had to generate a component map in advance, which is a product of full coupling with the flutter version.

The flutter was 1.20.x when we developed it, so we generated the flutter component of this version by default. To accommodate the multiple versions, we extract the version sensitive logic into a fair_version library.So once flutter releases a new stable version, we can quickly generate a new corresponding fair_version.

```yaml
# Switch to another stable flutter version
dependency_overrides:
  fair_version:
    git:
      url: https://github.com/wuba/fair.git
      ref: master
      path: fair_version/flutter_1_12_13
```

> Widget mapping

By writing the component mapping table, Fair can support more widgets, either from the Flutter framework or from three-party components.

For example we customized a CustomTag component that needed to generate the binding mapping component and we also wanted to generate additional mapping components for the package component of the convex_bottom_bar community. You can do this:

![img](https://cdn-images-1.medium.com/max/1600/0*1tHTy3bWGIHdylZt.png)

The generated code snippet is as follows:

![img](https://cdn-images-1.medium.com/max/1600/0*LLSsXzqKPCPWBZ5R.png)

> Bundle generation

In order to achieve seamless integration, our goal is to support the generation of business bundles directly from the Flutter layout. Using the build_runner mechanism, we can nicely combine the bundle build with project Flutter. So ideally, all the developer has to do is add the annotations, and then the flutter compiler will generate the artifacts for you.

![img](https://cdn-images-1.medium.com/max/1600/0*T5Y5qCyDfKy1YZtm.png)

## DSL & AST

I guess those of you reading so far are really interested in Flutter. These two nouns are very common, and both are general concepts that have nothing to do with language:

- DSL : Domain Specific Language
- AST: Abstract Syntax Tree

In Flutter Fair, DSL is the expression of our intermediates, and AST is the expression of our primary products for analysis.

In Fair Complier, we have designed a layer of Fairc, which is an important part of an auxiliary compilation tool that provides DSL generation capabilities based on the AST to help developers quickly generate DSL bundles and Proxy files from source code. Here is a brief introduction to the practical use of Fair.

![img](https://cdn-images-1.medium.com/max/1600/0*l2sAnSyyGGfOYjjT.png)

The idea of DSL generation is shown in the figure above, which is to generate CustomAST from the source code through fair_ast_get, and then CustomAST through fair_dsl_gen to generate the target Fair DSL. Let’s look at the overall workflow of the converter.

![img](https://cdn-images-1.medium.com/max/1600/0*JwNMTvJvTbcMQ4qc.png)

First of all, we abstract the syntax nodes of 100+ into identifiers, literals, expressions and syntax blocks, and the other five classes, including 30+ kinds of commonly used nodes. At the same time, we strip away the information irrelevant to business parsing, and only retain the key information in the original Node. Makes node resolution clearer.

The original syntax tree has a large amount of data, and the Visitor schema is not convenient for us to deal with the business in context, so we need to simplify and construct our own syntax tree to facilitate our subsequent processing

## Next

The Flutter Fair package is a little exploration on Flutter dynamic update. It will be open source soon: https://github.com/wuba.

You can also find document about Flutter Fair at https://fair.hacktons.cn/

> It’s mandarin, sorry for not providing English version, any i18n translation is appreciated!!😁