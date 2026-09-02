import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../api/models/message.dart';
import 'tool_glass_card.dart';

class FallbackToolCard extends StatelessWidget {
  final Part part;

  const FallbackToolCard({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tool = part.toolName;
    final status = part.toolStatus;
    final isError = status == ToolStateStatus.error;
    final displayName = tool.isNotEmpty ? tool : 'Tool';

    return ToolGlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      leading: ToolIconCapsule(
        icon: isError
            ? CupertinoIcons.exclamationmark_triangle_fill
            : CupertinoIcons.wrench_fill,
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
              fontWeight: FontWeight.w600,
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
