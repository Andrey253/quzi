import 'package:flutter/material.dart';

class ShowSearchDifficulty extends SearchDelegate<String?> {
  final theme = ['Easy', 'Medium', 'Hard'];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) close(context, null);
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context, null), icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(children: [
      ...theme
          .where((q) => q.toLowerCase().contains(query.toLowerCase()))
          .map((e) => TextButton(child: Text(e), onPressed: () => close(context, e)))
    ]);
  }
}
