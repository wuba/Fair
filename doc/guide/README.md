
# Introduction

> This post is translated by [ME-smile](https://github.com/ME-smile)

Fair is a lightweight package for Flutter, which can be used to update widget tree and state dynamically. This package is still at an early stage.

We create Fair so we can dispatch page changes to users as bundle(s), the way similar to React Native. With Flutter Fair integrated, you can publish your pages without waiting for the next release date of your App. Fair provides standard widget, it can be used as a new dynamic page or as part of existing Flutter page.

## Architecture

![fair architecture](./assets/fair.png)

## Flutter Fair is ...?

- Fair is short for Flutter over the air.
- Fair is used to update widget tree and state dynamically.
::: tip Why open source?
There are few packages for dynamization. After open source, we can get feedback from developers in Flutter community, which is conducive to the continuous improvement of the project itself. Also it can provide reference and ideas for developers.
:::

- Fair is a part-time project lead by RD
::: tip Maintenance
This project is lead by RD, including project design and development. All participants join on a part-time basis. Maintenance after open source will keep the same way.
:::

## Fair is not ...?

* Flutter hotfix

App hotfix usually includes both logic and UI. The Fair 2.0 version now supports page-level updates. It is like the module or action for Hybrid and React-Native.

* MXFlutter

mxflutter is a package based on javascript. If you are developing flutter app with js, [mxflutter](https://github.com/mxflutter/mxflutter) is recommended.

## Demo Preview

<video width="360" height="auto" loop="loop" controls="" preload="none">
  <source src="/bestui.mp4" type="video/mp4">
  您的浏览器不支持 video 标签。
</video>
