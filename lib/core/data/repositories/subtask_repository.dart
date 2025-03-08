import '../data_access_object/subtask_dao.dart';
import '../models/subtask_model.dart';

class SubtaskRepository {
  final SubtaskDao _subtaskDao;

  SubtaskRepository(this._subtaskDao);

  Future<List<SubtaskModel>> getAllSubtasks() async {
    final subtasks = await _subtaskDao.getAllSubtasks();
    return subtasks.map((subtask) => SubtaskModel.fromEntity(subtask)).toList();
  }

  Future<SubtaskModel?> getSubtaskById(int id) async {
    final subtask = await _subtaskDao.getSubtaskById(id);
    return SubtaskModel.fromEntity(subtask);
  }

  Future<int> addSubtask(SubtaskModel subtask) async {
    return await _subtaskDao.insertSubtask(subtask.toEntity());
  }

  Future<bool> updateSubtask(SubtaskModel subtask) async {
    return await _subtaskDao.updateSubtask(subtask.toEntity());
  }

  Future<int> deleteSubtask(int id) async {
    return await _subtaskDao.deleteSubtask(id);
  }
}