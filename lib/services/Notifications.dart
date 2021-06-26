import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inventar/main.dart';
import 'package:whf_events_app/main.dart';
import 'package:whf_events_app/routes/event_arguments.dart';
import 'package:whf_events_app/routes/route_names.dart';
import 'package:whf_events_app/widget/Header.dart';
import 'package:whf_events_app/widget/drawer.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  RemoteNotification notification;
  String token;
  ValueNotifier<int> notificationCounterValueNotifer =
  ValueNotifier(0);
  Map<String,dynamic> notificationdata;
  List<String> notifications;
  @override
  void initState() {
    var initializationSettingAndroid =
          AndroidInitializationSettings('@mipmap/icon');
    var initializationSettings = InitializationSettings(android: initializationSettingAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      notificationdata =  message.data;
      notificationCounterValueNotifer.value++;
      notification = message.notification;
      notifications.add(notification.title.toString());
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        print("message recieved");
        print(notification.body);
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'icon',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });

    getToken();
  }


  @override
  Widget build(BuildContext context) {
    print("notification data: $notificationdata");
    print("notifications list: $notifications");
    //return Text(notificationCounterValueNotifer.value.toString());
    return Scaffold(
      appBar: header(context,title: "Notifications",notification: notificationCounterValueNotifer.value),
      drawer: CustomDrawer(context),
      body: ListView.builder(
          itemCount: notificationCounterValueNotifer.value,
          itemBuilder: (context,index){
            //TODO: return event card tile
            return Card(
              child: ListTile(
                title: Text('${notification.title}'),
                subtitle: Text('${notification.body}'),
                onTap: (){
                  Navigator.pushNamed(context, EventDescriptionRoute,
                      arguments: EventArguments(

                      ));
                },
              ),
            );
          }),
    );
  }
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
    });
    print(token);
  }

}