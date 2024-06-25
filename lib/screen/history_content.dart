import 'package:clear_finance/data/history_data.dart';
import 'package:clear_finance/model/history_model.dart';
import 'package:clear_finance/screen/new_history_content.dart';
import 'package:clear_finance/util/format_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryContent extends StatefulWidget {
  const HistoryContent({super.key});

  @override
  _HistoryContentState createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  bool showNewHistoryContent = false;
  HistoryModel? historyToEdit;

  @override
  Widget build(BuildContext context) {
    return showNewHistoryContent
        ? NewHistoryContent(
      historyToEdit: historyToEdit,
      onCancel: () {
        setState(() {
          showNewHistoryContent = false;
        });
      },
      onHistoryCreated: (fromEdit, historyModel) {
        if (fromEdit) {
          if (historyToEdit == null) return;
          HistoryData.removeHistory(historyToEdit!);
          historyToEdit = null;
        }
        HistoryData.addHistory(historyModel);
        setState(() {
          showNewHistoryContent = false;
        });
      },
    )
        : _buildHistoryContent();
  }

  Widget _buildHistoryContent() {
    Map<String, List<HistoryModel>> groupedHistory = {};

    for (var historyItem in HistoryData.history) {
      String formattedDate = FormatUtil.formatDate(historyItem.date);
      if (groupedHistory.containsKey(formattedDate)) {
        groupedHistory[formattedDate]!.add(historyItem);
      } else {
        groupedHistory[formattedDate] = [historyItem];
      }
    }

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          InkWell(
              onTap: () {
                setState(() {
                  showNewHistoryContent = true;
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
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
                      Text(
                        'Añadir Nuevo Movimiento',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          )),
                    ],
                  ))),
          const SizedBox(height: 10),
          HistoryData.history.isEmpty
              ? const Expanded(child: Center(child: Text('No hay movimientos')))
              : Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: groupedHistory.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(entry.key,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Column(
                          children: entry.value.map((historyItem) {
                            return _buildHistoryItem(historyItem);
                          }).toList(),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ))
        ]));
  }

  Widget _buildHistoryItem(HistoryModel historyItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildChip(historyItem.category, historyItem.categoryColor),
                  const SizedBox(width: 8),
                  _buildChip(historyItem.type, historyItem.typeColor),
                  const Spacer(),
                  IconButton(
                    icon: SvgPicture.asset('assets/images/ic_edit.svg'),
                    onPressed: () {
                      setState(() {
                        showNewHistoryContent = true;
                        historyToEdit = historyItem;
                      });
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset('assets/images/ic_delete.svg'),
                    onPressed: () {
                      setState(() {
                        HistoryData.removeHistory(historyItem);
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(historyItem.description,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300)),
              const SizedBox(height: 8),
              Text('${FormatUtil.formatCurrency(historyItem.amount)} COP',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
