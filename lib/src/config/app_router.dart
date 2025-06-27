import 'package:event_favorites_organizer/src/domain/domain.dart';
import 'package:event_favorites_organizer/src/presentation/presentation.dart';
import 'package:event_favorites_organizer/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: AppRoutes.rootRouteName,
        redirect:
            ((context, state) =>
                state.namedLocation(AppRoutes.upcomingEventsPage)),
      ),
      GoRoute(
        path: '/upcoming-events',
        name: AppRoutes.upcomingEventsPage,
        pageBuilder:
            (context, state) => const MaterialPage<void>(child: EventsPage()),
        routes: [
          GoRoute(
            path: 'folder-detail',
            name: AppRoutes.folderDetailPage,
            pageBuilder: (context, state) {
              FolderModel? folderData =
                  state.extra == null ? null : state.extra as FolderModel;
              return MaterialPage<void>(
                child: FolderDetailPage(folderData: folderData!),
              );
            },
          ),
        ],
      ),
    ],
  );
}
