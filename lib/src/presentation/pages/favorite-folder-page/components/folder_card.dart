import 'package:event_favorites_organizer/src/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class FolderCard extends StatelessWidget {
  const FolderCard({super.key, required this.folderData});

  final FolderModel folderData;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Iconsax.folder_2_copy, size: 16),
      title: Text(
        folderData.name,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15),
    );
  }
}
