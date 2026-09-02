import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/translations.dart';
import '../../../../api/models/message.dart';
import '../../tablet/in_app_browser_view.dart';
import 'tool_glass_card.dart';

class WebCard extends StatelessWidget {
  final Part part;

  const WebCard({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final input = part.toolInput;
    final url = (input['url'] ?? input['uri'] ?? '') as String;
    final query = input['query'] as String? ?? '';
    final isSearch = part.toolName == 'websearch';
    final status = part.toolStatus;
    final isError = status == ToolStateStatus.error;

    final label = isSearch ? query : url;
    final shortLabel = label.length > 60
        ? '${label.substring(0, 60)}...'
        : label;

    final canOpen = !isSearch && url.isNotEmpty;

    return ToolGlassCard(
      onTap: canOpen ? () => openUrlInApp(context, url) : null,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      leading: ToolIconCapsule(
        icon: isSearch
            ? CupertinoIcons.search
            : CupertinoIcons.globe,
        color: isError
            ? theme.colorScheme.error
            : theme.colorScheme.primary,
      ),
      child: Text(
        shortLabel,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          fontWeight: canOpen ? FontWeight.w600 : FontWeight.w500,
          color: canOpen
              ? theme.colorScheme.primary
              : theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
