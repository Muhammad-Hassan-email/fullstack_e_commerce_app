import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback? onMicTap;
  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    super.key,
    this.onMicTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Search any Product.',
            hintStyle:
                TextStyle(color: Colors.grey.shade600, fontSize: 14),
            prefixIcon:
                Icon(Icons.search, color: Colors.grey.shade600, size: 22),
            suffixIcon: IconButton(
              icon: Icon(Icons.mic_none,
                  color: Colors.grey.shade600, size: 22),
              onPressed: onMicTap,
            ),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}