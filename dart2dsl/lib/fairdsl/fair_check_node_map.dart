/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

// **************************************************************************
// 如果存在新文件需要更新，建议先执行清除命令：
// flutter packages pub run build_runner clean
//
// 然后执行下列命令重新生成相应文件：
// flutter packages pub run build_runner build --delete-conflicting-outputs
// 自动生成请勿修改
// **************************************************************************
final checkNode = {
  'DeclaredSimpleIdentifier': 'DeclaredSimpleIdentifier',
  'ConstructorDeclarationImpl': 'ConstructorDeclarationImpl',
  'InterpolationStringImpl': 'InterpolationStringImpl',
  'MapLiteralEntryImpl': 'visitMapLiteralEntry',
  'SetOrMapLiteralImpl': 'visitSetOrMapLiteral',
  'AnnotationImpl': 'visitAnnotation',
  'ListLiteralImpl': 'visitListLiteral',
  'InterpolationExpressionImpl': 'visitInterpolationExpression',
  'StringInterpolationImpl': 'visitStringInterpolation',
  'PostfixExpressionImpl': 'visitPostfixExpression',
  'ExpressionStatementImpl': 'visitExpressionStatement',
  'FieldDeclarationImpl': 'visitFieldDeclaration',
  'CompilationUnitImpl': 'visitCompilationUnit',
  'BlockImpl': 'visitBlock',
  'BlockFunctionBodyImpl': 'visitBlockFunctionBody',
  'VariableDeclarationImpl': 'visitVariableDeclaration',
  'VariableDeclarationStatementImpl': 'visitVariableDeclarationStatement',
  'VariableDeclarationListImpl': 'visitVariableDeclarationList',
  'SimpleIdentifierImpl': 'visitSimpleIdentifier',
  'IntegerLiteralImpl': 'visitIntegerLiteral',
  'DoubleLiteralImpl': 'visitDoubleLiteral',
  'FunctionDeclarationImpl': 'visitFunctionDeclaration',
  'FunctionDeclarationStatementImpl': 'visitFunctionDeclarationStatement',
  'ExpressionFunctionBodyImpl': 'visitExpressionFunctionBody',
  'FunctionExpressionImpl': 'visitFunctionExpression',
  'SimpleFormalParameterImpl': 'visitSimpleFormalParameter',
  'DefaultFormalParameterImpl': 'visitDefaultFormalParameter',
  'FormalParameterListImpl': 'visitFormalParameterList',
  'NamedTypeImpl': 'visitNamedType',
  'ReturnStatementImpl': 'visitReturnStatement',
  'MethodDeclarationImpl': 'visitMethodDeclaration',
  'NamedExpressionImpl': 'visitNamedExpression',
  'PrefixedIdentifierImpl': 'visitPrefixedIdentifier',
  'MethodInvocationImpl': 'visitMethodInvocation',
  'ClassDeclarationImpl': 'visitClassDeclaration',
  'InstanceCreationExpressionImpl': 'visitInstanceCreationExpression',
  'SimpleStringLiteralImpl': 'visitSimpleStringLiteral',
  'BooleanLiteralImpl': 'visitBooleanLiteral',
  'ArgumentListImpl': 'visitArgumentList',
  'LabelImpl': 'visitLabel',
  'ExtendsClauseImpl': 'visitExtendsClause',
  'ImplementsClauseImpl': 'visitImplementsClause',
  'WithClauseImpl': 'visitWithClause',
  'PropertyAccessImpl': 'visitPropertyAccess',
  'PrefixExpressionImpl': 'visitPrefixExpression'
};
