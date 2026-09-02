import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../api/models/message.dart';
import 'tool_glass_card.dart';

class TodoCard extends StatelessWidget {
  final Part part;

  const TodoCard({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = part.toolStatus;
    final isError = status == ToolStateStatus.error;

    final input = part.toolInput;
    var todoVal =
        input['todo'] ??
        input['task'] ??
        input['description'] ??
        input['content'] ??
        input['instruction'] ??
        input['title'] ??
        input['goal'] ??
        input['prompt'] ??
        '';

    // Backend todowrite input is `todos` (list of {id, content, ...}).
    if (todoVal.toString().isEmpty) {
      final todosRaw = input['todos'];
      if (todosRaw is List && todosRaw.isNotEmpty) {
        final items = <String>[];
        for (final t in todosRaw) {
          if (t is Map) {
            final c =
                t['content'] ?? t['description'] ?? t['task'] ?? t['title'];
            if (c != null && c.toString().trim().isNotEmpty) {
              items.add(c.toString().trim());
            }
          } else if (t != null && t.toString().trim().isNotEmpty) {
            items.add(t.toString().trim());
          }
        }
        if (items.isNotEmpty) todoVal = items.join('; ');
      }
    }

    if (todoVal.toString().isEmpty && input.isNotEmpty) {
      todoVal = input.values.map((v) => v.toString()).join(', ');
    }

    if (todoVal.toString().isEmpty) {
      final rawTodo =
          part.raw['todo'] ??
          part.raw['content'] ??
          part.raw['description'] ??
          part.raw['text'] ??
          part.raw['instruction'] ??
          '';
      if (rawTodo.toString().isNotEmpty) {
        todoVal = rawTodo.toString();
      }
    }

    String displayName = 'TODO';
    if (todoVal.toString().isNotEmpty) {
      displayName = 'TODO · ${todoVal.toString().trim()}';
    }

    return ToolGlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      leading: ToolIconCapsule(
        icon: isError
            ? CupertinoIcons.exclamationmark_triangle_fill
            : CupertinoIcons.checkmark_seal_fill,
        color: isError ? theme.colorScheme.error : theme.colorScheme.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            displayName,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isError
                  ? theme.colorScheme.error.withValues(alpha: 0.7)
                  : null,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (isError && part.toolError.isNotEmpty)
            Text(
              part.toolError,
              style: TextStyle(
                fontSize: 11.5,
                color: theme.colorScheme.error.withValues(alpha: 0.6),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
