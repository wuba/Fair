import '../protos/dart_services.pb.dart';

/**
 * 组件集
 */
class Component {

  Future<GetComponentListResponse> getComponentList(GetComponentListRequest request) async {
    var projectName = request.projectName;
    var projectId = request.projectId;
    var categoryType = request.categoryType;

    var response = GetComponentListResponse();

    response.projectName = projectName;
    response.projectId = projectId;
    response.categoryType = categoryType;

    ComponentItemInfo itemInfo =  ComponentItemInfo();
    itemInfo.componentName = "测试组件";
    itemInfo.componentId = "1";
    itemInfo.categoryType = "fair";
    itemInfo.type = "1";
    itemInfo.content = "content";
    itemInfo.dependencies.add("依赖1");
    itemInfo.dependencies.add("依赖2");
    itemInfo.dependencies.add("依赖3");
    itemInfo.dependencies.add("依赖4");

    response.componentItems.add(itemInfo);

    print("请求服务器");

    switch(categoryType){
      case "fair":
        break;
      case "custom":
        break;
      case "all":
      default:
        break;

    }

    return response;
  }



}
