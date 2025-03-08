import '../data_access_object/task_dao.dart';
import '../models/task_model.dart';

class TaskRepository {
  final TaskDao _taskDao;

  TaskRepository(this._taskDao);

  Future<List<TaskModel>> getAllTasks() async {
    final tasks = await _taskDao.getAllTasks();
    return tasks.map((task) => TaskModel.fromEntity(task)).toList();
  }

  Future<TaskModel?> getTaskById(int id) async {
    final task = await _taskDao.getTaskById(id);
    return TaskModel.fromEntity(task);
  }

  Future<int> addTask(TaskModel task) async {
    return await _taskDao.insertTask(task.toEntity());
  }

  Future<bool> updateTask(TaskModel task) async {
    return await _taskDao.updateTask(task.toEntity());
  }

  Future<int> deleteTask(int id) async {
    return await _taskDao.deleteTask(id);
  }
}
