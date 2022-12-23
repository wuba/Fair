import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:fair_online_service/src/fair_plugin/constant/fair_constants.dart';
import 'package:fair_online_service/src/fair_plugin/fair_sugar_visitor/fair_map_visitor.dart';
import 'package:fair_online_service/src/fair_plugin/model/issue.dart';
import 'package:fair_online_service/src/fair_plugin/model/sugar_type.dart';
import 'package:fair_online_service/src/fair_plugin/utils/list_ext.dart';
import 'package:fair_online_service/src/fair_plugin/utils/string_utils.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('fair_visitor');

class FairVisitor extends RecursiveAstVisitor<void> {
  final _issues = <BaseIssue>[];

  Iterable<BaseIssue> get issues => _issues;

  @override
  void visitAnnotation(Annotation node) {
    node.visitChildren(this);
    if (node.name.name == 'FairPatch') {
      final classVisitor = _FairClassVisitor();
      //node.parent就是指的当前FairPatch所在的类
      final parent = node.parent;

      parent.accept(classVisitor);
      _issues.addAll(classVisitor.issues);
    }
  }
}

class _FairClassVisitor extends RecursiveAstVisitor<void> {
  final issues = <BaseIssue>[];

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final extend = node.extendsClause;
    if (null != extend) {
      final type = extend.superclass;
      if (type.name.name == 'StatelessWidget') {
        final methodVisitor = _FairMethodVisitor();
        node.accept(methodVisitor);
        issues.addAll(methodVisitor.issues);
      } else if (type.name.name == 'StatefulWidget') {
        final member = node.members.firstWhereOrNull(
            (element) =>
                element is MethodDeclaration &&
                element.name.toString() == 'createState',
            orElse: () => null);
        var expectedStateClassName =
            ((member as MethodDeclaration).returnType as NamedType).name.name;
        if (expectedStateClassName == 'State') {
          final body = member.body;
          if (body is BlockFunctionBody) {
            final ReturnStatement? returnStatement = body.block.statements
                .singleWhereOrNull((element) => element is ReturnStatement,
                    orElse: () => null) as ReturnStatement?;
            expectedStateClassName =
                (returnStatement?.expression as MethodInvocation)
                    .methodName
                    .name;
          } else if (body is ExpressionFunctionBody) {
            try {
              final exp = body.expression;
              if (exp is MethodInvocation) {
                expectedStateClassName = exp.methodName.name;
              } else if (exp is InstanceCreationExpression) {
                expectedStateClassName = exp.staticType?.name ?? '';
              }
            } catch (e) {
              print(e);
            }
          }
        }

        if (expectedStateClassName.isNotEmpty &&
            expectedStateClassName != 'State') {
          final stateVisitor = _FairStateVisitor(expectedStateClassName);
          node.parent?.accept(stateVisitor);
          issues.addAll(stateVisitor.issues);
        }
      }
    }
  }
}

class _FairStateVisitor extends RecursiveAstVisitor<void> {
  final String _targetState;
  final issues = <BaseIssue>[];

  _FairStateVisitor(this._targetState);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    node.visitChildren(this);
    if (node.name.name == _targetState) {
      final methodVisitor = _FairMethodVisitor();
      node.accept(methodVisitor);
      issues.addAll(methodVisitor.issues);
    }
  }
}

class _FairMethodVisitor extends RecursiveAstVisitor<void> {
  final issues = <BaseIssue>[];

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    node.visitChildren(this);
    //这里是方法声明
    //node.returnType.toString() == 'Widget'
    if (node.name.name == 'build') {
      final sugarIfVisitor = SugarIfVisitor();
      node.accept(sugarIfVisitor);
      issues.addAll(sugarIfVisitor.issues);
    }
    final sugarMapVisitor = SugarMapVisitor();
    node.accept(sugarMapVisitor);
    issues.addAll(sugarMapVisitor.issues);
  }
}

class SugarIfVisitor extends RecursiveAstVisitor<void> {
  final issues = <BaseIssue>[];

  @override
  void visitIfStatement(IfStatement node) {
    _logger.info('Blues ===>visitIfStatement:${node.toSource()}');

    node.visitChildren(this);
    final ifToken = node.ifKeyword;

    final condition = node.condition;
    final conditionSource = condition.toSource();
    final elseStatement = node.elseStatement?.toSource();
    final ifStatement = node.thenStatement.toSource();

    dealWithIf(
        node, ifToken, condition, conditionSource, ifStatement, elseStatement);
    _logger.info('Blues ===>after dealWithIf:$issues');
  }

  @override
  void visitIfElement(IfElement node) {
    node.visitChildren(this);
    final ifToken = node.ifKeyword;

    final condition = node.condition;
    final conditionSource = condition.toSource();
    final elseStatement = node.elseElement?.toSource();
    final ifStatement = node.thenElement.toSource();

    dealWithIf(
        node, ifToken, condition, conditionSource, ifStatement, elseStatement);
  }

  void dealWithIf(AstNode node,Token ifToken, Expression condition, String conditionSource,
      String ifStatement, String? elseStatement) {

    //如果if的condition里面有contains方法，判断一下是否是List的contains方法
    if (conditionSource.contains('contains') == true) {
      final visitor = IfRangeVisitor();
      condition.accept(visitor);

      final isSugarIfRange = visitor.result;
      if (isSugarIfRange) {
        //如果是调用的List的contains方法
        issues.add(
          SugarIfIssue(
            ifToken.offset,
            ifToken.length,
            ERROR_MESSAGE.format(['build', 'if', Sugar.ifRange]),
            Sugar.ifRange.toString(),
            node.offset,
            node.length,
            conditionSource,
            ifStatement,
            type: Sugar.ifRange,
            actualExpression: visitor.actual?.toSource(),
            exceptExpression: visitor.target?.toSource(),
            elseStatement: elseStatement,
          ),
        );
      }
    } else if (conditionSource.contains('==') == true) {
      final visitor = IfEqualVisitor();
      condition.accept(visitor);
      final isSugarIfEqual = visitor.result;
      if (isSugarIfEqual) {
        issues.add(
          SugarIfIssue(
            ifToken.offset,
            ifToken.length,
            ERROR_MESSAGE.format(['build', 'if', Sugar.ifEqual]),
            Sugar.ifEqual.toString(),
            node.offset,
            node.length,
            conditionSource,
            ifStatement,
            type: Sugar.ifEqual,
            actualExpression: visitor.leftExpression?.toSource(),
            exceptExpression: visitor.rightExpression?.toSource(),
            elseStatement: elseStatement,
          ),
        );
      }
    } else {
      //Sugar.ifEqualBool
      issues.add(
        SugarIfIssue(
          ifToken.offset,
          ifToken.length,
          ERROR_MESSAGE.format(['build', 'if', Sugar.ifEqualBool]),
          Sugar.ifEqualBool.toString(),
          node.offset,
          node.length,
          conditionSource,
          ifStatement,
          elseStatement: elseStatement,
        ),
      );
    }
  }
}

class IfRangeVisitor extends RecursiveAstVisitor<void> {
  bool _result = false;
  Expression? _target;
  Expression? _actual;

  bool get result => _result;

  Expression? get target => _target;

  Expression? get actual => _actual;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);

    _result = node.target?.staticType?.isDartCoreList ?? false;
    if (_result) {
      _target = node.target;
      _actual = node.argumentList.arguments.first;
    }
  }
}

class IfEqualVisitor extends RecursiveAstVisitor<void> {
  bool _result = false;
  Expression? _leftExpression;
  Expression? _rightExpression;

  bool get result => _result;

  Expression? get leftExpression => _leftExpression;

  Expression? get rightExpression => _rightExpression;

  @override
  void visitBinaryExpression(BinaryExpression node) {
    super.visitBinaryExpression(node);

    //todo 这里先去掉static type的校验，因为存在ast未转化完成获取不到staticType的情况。
    // bool left = _isDartCore(node.leftOperand.staticType);
    // bool right = _isDartCore(node.rightOperand.staticType);
    // if (left && right) {
      _result = true;
      _leftExpression = node.leftOperand;
      _rightExpression = node.rightOperand;
    // }
  }

  bool _isDartCore(DartType? type) {
    if (type == null) {
      return false;
    }
    return type.isDartCoreString ||
        type.isDartCoreBool ||
        type.isDartCoreDouble ||
        type.isDartCoreInt ||
        type.isDartCoreNull ||
        type.isDartCoreEnum ||
        type.isDartCoreList ||
        type.isDartCoreMap ||
        type.isDartCoreSet ||
        type.isDartCoreNum ||
        type.isDartCoreObject ||
        type.isDartCoreIterable;
  }
}
