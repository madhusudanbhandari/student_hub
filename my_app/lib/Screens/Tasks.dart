import 'package:flutter/material.dart';
import 'package:my_app/Services/task_service.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  bool isLoading = false;
  final taskService = TaskService();
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    getTask();
  }

  Future<void> addTask() async {
    try {
      setState(() => isLoading = true);
      await taskService.addTask(
        title: titleController.text.trim(),
        description: descController.text.trim(),
      );
      if (!mounted) return;
      titleController.clear();
      descController.clear();
      await getTask();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Task added")));
    } catch (err) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(err.toString())));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> getTask() async {
    final response = await taskService.getTasks();
    setState(() => tasks = response);
  }

  Widget _styledField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF64748B)),
        filled: true,
        fillColor: const Color(0xFF0F172A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF34D399), width: 1.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completed = tasks.where((t) => t['is_completed'] == true).length;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFFE2E8F0),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tasks',
          style: TextStyle(
            color: Color(0xFFE2E8F0),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
            if (tasks.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$completed of ${tasks.length} completed',
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    '${((completed / tasks.length) * 100).round()}%',
                    style: const TextStyle(
                      color: Color(0xFF34D399),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: completed / tasks.length,
                  backgroundColor: const Color(0xFF1E293B),
                  color: const Color(0xFF34D399),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Input fields
            _styledField(controller: titleController, label: 'Title'),
            const SizedBox(height: 12),
            _styledField(
              controller: descController,
              label: 'Description',
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : addTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF34D399),
                  disabledBackgroundColor: const Color(
                    0xFF34D399,
                  ).withOpacity(0.5),
                  foregroundColor: const Color(0xFF0F172A),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          color: Color(0xFF0F172A),
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Add task',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Task count label
            Text(
              '${tasks.length} task${tasks.length == 1 ? '' : 's'}',
              style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
            ),
            const SizedBox(height: 10),

            // Task list
            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            color: Color(0xFF334155),
                            size: 48,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'No tasks yet',
                            style: TextStyle(
                              color: Color(0xFF475569),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: tasks.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        final isCompleted =
                            tasks[index]['is_completed'] ?? false;
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(14),
                            border: isCompleted
                                ? Border.all(
                                    color: const Color(
                                      0xFF34D399,
                                    ).withOpacity(0.3),
                                    width: 1,
                                  )
                                : null,
                          ),
                          padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                          child: Row(
                            children: [
                              Checkbox(
                                value: isCompleted,
                                onChanged: (value) async {
                                  await taskService.toggleTask(
                                    tasks[index]['id'],
                                    tasks[index]['is_completed'] ?? false,
                                  );
                                  await getTask();
                                },
                                activeColor: const Color(0xFF34D399),
                                checkColor: const Color(0xFF0F172A),
                                side: const BorderSide(
                                  color: Color(0xFF475569),
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tasks[index]['title'],
                                      style: TextStyle(
                                        color: isCompleted
                                            ? const Color(0xFF475569)
                                            : const Color(0xFFE2E8F0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        decoration: isCompleted
                                            ? TextDecoration.lineThrough
                                            : null,
                                        decorationColor: const Color(
                                          0xFF475569,
                                        ),
                                      ),
                                    ),
                                    if ((tasks[index]['description'] ?? '')
                                        .isNotEmpty) ...[
                                      const SizedBox(height: 3),
                                      Text(
                                        tasks[index]['description'],
                                        style: TextStyle(
                                          color: isCompleted
                                              ? const Color(0xFF334155)
                                              : const Color(0xFF94A3B8),
                                          fontSize: 13,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await taskService.deleteTask(
                                    tasks[index]['id'],
                                  );
                                  await getTask();
                                },
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Color(0xFFFF6B6B),
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
