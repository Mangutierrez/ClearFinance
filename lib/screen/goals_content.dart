import 'package:clear_finance/util/format_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'new_goal_content.dart';
import 'package:clear_finance/data/goal_data.dart';
import 'package:clear_finance/model/goal_model.dart';

class GoalsContent extends StatefulWidget {
  const GoalsContent({super.key});

  @override
  _GoalsContentState createState() => _GoalsContentState();
}

class _GoalsContentState extends State<GoalsContent> {
  bool showNewGoalContent = false;
  GoalModel? goalToEdit;

  @override
  Widget build(BuildContext context) {
    return showNewGoalContent
        ? NewGoalContent(
            goalToEdit: goalToEdit,
            onCancel: () {
              setState(() {
                showNewGoalContent = false;
              });
            },
            onGoalCreated: (fromEdit, goalModel) {
              setState(() {
                if (fromEdit) {
                  if (goalToEdit == null) return;
                  GoalData.removeGoal(goalToEdit!);
                  goalToEdit = null;
                }
                GoalData.addGoal(goalModel);
                showNewGoalContent = false;
              });
            },
          )
        : _buildGoalContent();
  }

  Widget _buildGoalContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                showNewGoalContent = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFBA7423),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  SizedBox.shrink(),
                  Text(
                    'Añadir Nueva Meta',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GoalData.goals.isNotEmpty
                ? ListView.builder(
                    itemCount: GoalData.goals.length,
                    itemBuilder: (context, index) {
                      final goal = GoalData.goals[index];
                      return _buildGoalItem(goal);
                    },
                  )
                : const Center(
                    child: Text('No hay metas'),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalItem(GoalModel goal) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildChip(goal.category, goal.categoryColor),
                  const Spacer(),
                  IconButton(
                    icon: SvgPicture.asset('assets/images/ic_edit.svg',
                        color: Colors.yellow),
                    onPressed: () {
                      setState(() {
                        showNewGoalContent = true;
                        goalToEdit = goal;
                      });
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset('assets/images/ic_delete.svg',
                        color: Colors.red),
                    onPressed: () {
                      setState(() {
                        GoalData.removeGoal(goal);
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                goal.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 8),
              Text(
                '${FormatUtil.formatCurrency(goal.amount)} COP',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Fecha Límite: ${DateFormat('dd/MM/yyyy').format(goal.date)}',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFFBA7423)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Icon(Icons.category, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
