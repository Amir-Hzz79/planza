import '../data_access_object/task_tag_dao.dart';
import '../models/task_tag_model.dart';

class TaskTagRepository {
  final TaskTagDao _taskTagDao;

  TaskTagRepository(this._taskTagDao);

  Future<List<TaskTagModel>> getAllTaskTags() async {
    final taskTags = await _taskTagDao.getAllTaskTags();
    return taskTags.map((taskTag) => TaskTagModel.fromEntity(taskTag)).toList();
  }

  Future<TaskTagModel?> getTaskTagById(int taskId, int tagId) async {
    final taskTag = await _taskTagDao.getTaskTagById(taskId, tagId);
    return TaskTagModel.fromEntity(taskTag);
  }

  Future<int> addTaskTag(TaskTagModel taskTag) async {
    return await _taskTagDao.insertTaskTag(taskTag.toEntity());
  }

  Future<bool> updateTaskTag(TaskTagModel taskTag) async {
    return await _taskTagDao.updateTaskTag(taskTag.toEntity());
  }

  Future<int> deleteTaskTag(int taskId, int tagId) async {
    return await _taskTagDao.deleteTaskTag(taskId, tagId);
  }
}