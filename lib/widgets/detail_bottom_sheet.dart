import 'package:flutter/material.dart';
import '../theme/glass.dart';

/// Opens a scrollable liquid-glass detail sheet. [bodyBuilder] runs only when
/// the sheet is shown, so heavy content stays off the chat main tree.
Future<T?> showDetailBottomSheet<T>({
  required BuildContext context,
  required String title,
  required WidgetBuilder bodyBuilder,
  double heightFactor = 0.75,
}) {
  final maxHeight = MediaQuery.sizeOf(context).height * heightFactor;
  return showGlassBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      final theme = Theme.of(ctx);
      return SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: const GlassDragHandle()),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 6, 24, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 17,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: bodyBuilder(ctx)),
            ],
          ),
        ),
      );
    },
  );
}
