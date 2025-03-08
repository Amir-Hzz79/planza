import '../data_access_object/tag_dao.dart';
import '../models/tag_model.dart';

class TagRepository {
  final TagDao _tagDao;

  TagRepository(this._tagDao);

  Future<List<TagModel>> getAllTags() async {
    final tags = await _tagDao.getAllTags();
    return tags.map((tag) => TagModel.fromEntity(tag)).toList();
  }

  Future<TagModel?> getTagById(int id) async {
    final tag = await _tagDao.getTagById(id);
    return TagModel.fromEntity(tag);
  }

  Future<int> addTag(TagModel tag) async {
    return await _tagDao.insertTag(tag.toEntity());
  }

  Future<bool> updateTag(TagModel tag) async {
    return await _tagDao.updateTag(tag.toEntity());
  }

  Future<int> deleteTag(int id) async {
    return await _tagDao.deleteTag(id);
  }
}