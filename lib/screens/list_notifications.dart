import 'package:flutter/material.dart';
import 'package:voice_notification_app/storage/database/data/notification.dart';
import 'package:voice_notification_app/storage/database/database.dart';

class ListNotifications extends StatelessWidget {
  const ListNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All notifications'),
      ),
      body: FutureBuilder<List<Notif>>(
        future: NotifDatabaseProvider.db.getAllNotifs(),
        builder: (BuildContext context, AsyncSnapshot<List<Notif>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                Notif item = snapshot.data![index];
                return ListTile(
                  title: Text(item.payload),
                  leading: CircleAvatar(child: Text(item.id.toString())),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
