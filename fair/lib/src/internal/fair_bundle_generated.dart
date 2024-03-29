// automatically generated by the FlatBuffers compiler, do not modify
// ignore_for_file: unused_import, unused_field, unused_element, unused_local_variable

import 'dart:typed_data' show Uint8List;
import 'package:flat_buffers/flat_buffers.dart' as fb;


class WidgetData {
  WidgetData._(this._bc, this._bcOffset);
  factory WidgetData(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<WidgetData> reader = _WidgetDataReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  String? get className => const fb.StringReader().vTableGetNullable(_bc, _bcOffset, 4);
  List<int>? get data => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 6);
  List<int>? get na => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 8);
  List<int>? get pa => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 10);
  List<int>? get methodMap => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 12);

  @override
  String toString() {
    return 'WidgetData{className: ${className}, data: ${data}, na: ${na}, pa: ${pa}, methodMap: ${methodMap}}';
  }
}

class _WidgetDataReader extends fb.TableReader<WidgetData> {
  const _WidgetDataReader();

  @override
  WidgetData createObject(fb.BufferContext bc, int offset) =>
      WidgetData._(bc, offset);
}

class WidgetDataBuilder {
  WidgetDataBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(5);
  }

  int addClassNameOffset(int? offset) {
    fbBuilder.addOffset(0, offset);
    return fbBuilder.offset;
  }
  int addDataOffset(int? offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }
  int addNaOffset(int? offset) {
    fbBuilder.addOffset(2, offset);
    return fbBuilder.offset;
  }
  int addPaOffset(int? offset) {
    fbBuilder.addOffset(3, offset);
    return fbBuilder.offset;
  }
  int addMethodMapOffset(int? offset) {
    fbBuilder.addOffset(4, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class WidgetDataObjectBuilder extends fb.ObjectBuilder {
  final String? _className;
  final List<int>? _data;
  final List<int>? _na;
  final List<int>? _pa;
  final List<int>? _methodMap;

  WidgetDataObjectBuilder({
    String? className,
    List<int>? data,
    List<int>? na,
    List<int>? pa,
    List<int>? methodMap,
  })
      : _className = className,
        _data = data,
        _na = na,
        _pa = pa,
        _methodMap = methodMap;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? classNameOffset = _className == null ? null
        : fbBuilder.writeString(_className!);
    final int? dataOffset = _data == null ? null
        : fbBuilder.writeListUint8(_data!);
    final int? naOffset = _na == null ? null
        : fbBuilder.writeListUint8(_na!);
    final int? paOffset = _pa == null ? null
        : fbBuilder.writeListUint8(_pa!);
    final int? methodMapOffset = _methodMap == null ? null
        : fbBuilder.writeListUint8(_methodMap!);
    fbBuilder.startTable(5);
    fbBuilder.addOffset(0, classNameOffset);
    fbBuilder.addOffset(1, dataOffset);
    fbBuilder.addOffset(2, naOffset);
    fbBuilder.addOffset(3, paOffset);
    fbBuilder.addOffset(4, methodMapOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}
