import 'package:flutter/material.dart';

class MultiSelectItem<T> {
  final T value;
  final String label;
  final Color? color;

  MultiSelectItem({required this.value, required this.label, this.color});
}

class MultiSelectPage<T> extends StatefulWidget {
  final String title;
  final List<MultiSelectItem<T>> items;
  final Set<T> initialSelectedValues;

  const MultiSelectPage({
    super.key,
    required this.title,
    required this.items,
    required this.initialSelectedValues,
  });

  @override
  State<MultiSelectPage<T>> createState() => _MultiSelectPageState<T>();
}

class _MultiSelectPageState<T> extends State<MultiSelectPage<T>> {
  late Set<T> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = Set.from(widget.initialSelectedValues);
  }

  void _onItemTapped(T value) {
    setState(() {
      if (_selectedValues.contains(value)) {
        _selectedValues.remove(value);
      } else {
        _selectedValues.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(_selectedValues),
            child: const Text("Done"),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return CheckboxListTile(
            title: Text(item.label),
            value: _selectedValues.contains(item.value),
            onChanged: (isSelected) => _onItemTapped(item.value),
            secondary: item.color != null
                ? CircleAvatar(backgroundColor: item.color, radius: 12)
                : null,
          );
        },
      ),
    );
  }
}