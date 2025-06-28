import 'package:event_favorites_organizer/src/presentation/presentation.dart';
import 'package:event_favorites_organizer/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Center(child: UpcomingEventsTab()),
    Center(child: FavoriteFoldersTab()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? AppConstants.upcomingEventTitle
              : AppConstants.favoriteTabName,
          style: TextStyle(fontSize: 18),
        ),

        actions:
            _currentIndex == 0
                ? []
                : [
                  IconButton(
                    onPressed: () {
                      AddFolderBottomsheet.showBottomSheetDialog(context);
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });

          if (_currentIndex == 1) {
            context.read<FavoriteFolderBloc>().add(
              GetAllFavoriteFoldersEvent(),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: AppConstants.eventsTabName,
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.folder),
            label: AppConstants.favoriteTabName,
          ),
        ],
      ),
    );
  }
}
