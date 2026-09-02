import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/translations.dart';
import '../../../../api/models/message.dart';
import 'tool_glass_card.dart';

class GlobCard extends StatelessWidget {
  final Part part;

  const GlobCard({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final input = part.toolInput;
    final pattern = input['pattern'] as String? ?? '';
    // Backend glob/list inputs carry the base directory as `path`.
    final dir = (input['path'] ?? input['directory'])?.toString() ?? '';
    final status = part.toolStatus;

    // E2：行数按 part 实例缓存（Part.toolOutputNonEmptyLineCount），
    // 每次 build 不再对整个 output split + 过滤。
    final fileCount = part.toolOutputNonEmptyLineCount;

    final label = dir.isNotEmpty ? dir : pattern;
    final suffix = fileCount > 0 ? '$fileCount files' : '';
    final isError = status == ToolStateStatus.error;

    return ToolGlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      leading: ToolIconCapsule(
        icon: isError
            ? CupertinoIcons.exclamationmark_triangle_fill
            : CupertinoIcons.folder_fill,
        color: isError ? theme.colorScheme.error : theme.colorScheme.primary,
      ),
      child: Row(
        children: [
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.75),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (suffix.isNotEmpty) ...[
            const SizedBox(width: 8),
            Text(
              suffix,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary.withValues(alpha: 0.75),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
