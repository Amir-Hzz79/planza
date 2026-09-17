import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';
import '../models/template_model.dart';

part 'template_dao.g.dart';

@DriftAccessor(tables: [Templates])
class TemplateDao extends DatabaseAccessor<AppDatabase> with _$TemplateDaoMixin {
  TemplateDao(super.attachedDatabase);

  Stream<List<TemplateModel>> watchAllTemplates() {
    return select(templates).watch().map((rows) {
      return rows.map((template) => TemplateModel.fromEntity(template)).toList();
    });
  }

  Stream<List<TemplateModel>> watchTemplatesByCategory(String category) {
    return (select(templates)..where((t) => t.category.equals(category))).watch().map(
      (rows) => rows.map((template) => TemplateModel.fromEntity(template)).toList(),
    );
  }

  Stream<List<TemplateModel>> watchBuiltinTemplates() {
    return (select(templates)..where((t) => t.isBuiltin.equals(true))).watch().map(
      (rows) => rows.map((template) => TemplateModel.fromEntity(template)).toList(),
    );
  }

  Future<TemplateModel?> getTemplateById(int id) async {
    final template = await (select(templates)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (template == null) return null;
    return TemplateModel.fromEntity(template);
  }

  Future<int> insertTemplate(TemplateModel template) async {
    return await into(templates).insert(template.toInsertCompanion());
  }

  Future<bool> updateTemplate(TemplateModel template) =>
      update(templates).replace(template.toEntity());

  Future<int> deleteTemplate(int id) =>
      (delete(templates)..where((t) => t.id.equals(id))).go();

  Future<int> deleteAllTemplates() => delete(templates).go();

  Future<List<TemplateModel>> getAllTemplates() async {
    final rows = await select(templates).get();
    return rows.map((template) => TemplateModel.fromEntity(template)).toList();
  }

  Future<List<TemplateModel>> getBuiltinTemplates() async {
    final rows = await (select(templates)..where((t) => t.isBuiltin.equals(true))).get();
    return rows.map((template) => TemplateModel.fromEntity(template)).toList();
  }

  Future<List<TemplateModel>> getCustomTemplates() async {
    final rows = await (select(templates)..where((t) => t.isBuiltin.equals(false))).get();
    return rows.map((template) => TemplateModel.fromEntity(template)).toList();
  }

  Future<List<TemplateModel>> getTemplatesByCategory(String category) async {
    final rows = await (select(templates)..where((t) => t.category.equals(category))).get();
    return rows.map((template) => TemplateModel.fromEntity(template)).toList();
  }
}