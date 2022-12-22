import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

class PreviewPageVisitor extends RecursiveAstVisitor<void> {
  final _pages = <String>[];

  Iterable<String> get pages => _pages;

  @override
  void visitAnnotation(Annotation node) {
    node.visitChildren(this);
    if (node.name.name == 'FairPreviewPage') {
      final classVisitor = _FairPreviewPageVisitor();
      final parent = node.parent;
      parent.accept(classVisitor);
      _pages.addAll(classVisitor.pages);
    }
  }
}

class _FairPreviewPageVisitor extends RecursiveAstVisitor<void> {
  final pages = <String>[];

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    pages.add(node.name.name);
  }
}