import 'package:ecom_admin/providers/user_provider.dart';
import 'package:ecom_admin/utils/helper_functions.dart';
import 'package:ecom_admin/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserListPage extends StatelessWidget {
  static const String routeName = '/userlist';
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.userList.length,
          itemBuilder: (context, index) {
            final user = provider.userList[index];
            return ListTile(
              title: Text(user.displayName ?? user.email),
              subtitle: Text('Subscribed on ${getFormattedDate(user.userCreationTime.toDate())}'),
              trailing: IconButton(
                onPressed: () async {
                  final url = 'mailto: ${user.email}';
                  if(await canLaunchUrlString(url)) {
                    await launchUrlString(url);
                  } else{
                    showMsg(context, 'No apps found to perfoem this action');
                  }
                },
                icon: const Icon(Icons.email_outlined),
              ),
            );
          },
        ),
      ),
    );
  }
}
