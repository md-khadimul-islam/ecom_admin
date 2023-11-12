import 'dart:io';

import 'package:ecom_admin/models/address_model.dart';
import 'package:ecom_admin/providers/user_provider.dart';
import 'package:ecom_admin/utils/helper_functions.dart';
import 'package:ecom_admin/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/user_expansion_item.dart';

class UserListPage extends StatefulWidget {
  static const String routeName = '/userlist';

  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<AppUserExpansionItem> itemList = [];

  @override
  void didChangeDependencies() {
    itemList = Provider.of<UserProvider>(context, listen: false)
        .getAppUserExpansionItemList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              child: ExpansionPanelList(
                expansionCallback: (index, isExpanded) {
                  setState(() {
                    itemList[index].isExpanded = isExpanded;
                  });
                },
                children: itemList
                    .map(
                      (item) => ExpansionPanel(
                        headerBuilder: (context, isExpanded) => ListTile(
                          title: Text(item.header.email),
                          subtitle: Text(
                              'Subscribed on: ${getFormattedDate(item.header.timestamp.toDate())}'),
                        ),
                        body: Column(
                          children: [
                            Text(item.body.displayName ?? 'Name not found'),
                            Text(item.body.userAddress?.streetAddress ??
                                'Address not ser'),
                            Text(item.body.phoneNumber ??
                                'Phone number not found'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (item.body.phoneNumber != null) {
                                      _userAction(
                                          'tel:${item.body.phoneNumber}');
                                    }
                                  },
                                  icon: const Icon(Icons.call),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (item.body.phoneNumber != null) {
                                      _userAction(
                                          'sms:${item.body.phoneNumber}');
                                    }
                                  },
                                  icon: const Icon(Icons.sms_outlined),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _userAction('mailto:${item.header.email}');
                                  },
                                  icon: const Icon(Icons.email_outlined),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _openMap(item.body.userAddress);
                                  },
                                  icon: const Icon(Icons.location_on_outlined),
                                ),
                              ],
                            )
                          ],
                        ),
                        isExpanded: item.isExpanded,
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  ListView buildListView(UserProvider provider) {
    return ListView.builder(
      itemCount: provider.userList.length,
      itemBuilder: (context, index) {
        final user = provider.userList[index];
        return ListTile(
          title: Text(user.displayName ?? user.email),
          subtitle: Text(
              'Subscribed on ${getFormattedDate(user.userCreationTime.toDate())}'),
          trailing: IconButton(
            onPressed: () async {
              final url = 'mailto: ${user.email}';
              if (await canLaunchUrlString(url)) {
                await launchUrlString(url);
              } else {
                showMsg(context, 'No apps found to perfoem this action');
              }
            },
            icon: const Icon(Icons.email_outlined),
          ),
        );
      },
    );
  }

  void _userAction(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'No apps found to perfoem this action');
    }
  }

  void _openMap(AddressModel? addressModel) {
    if (addressModel != null) {
      final fullAddress = '${addressModel.streetAddress},${addressModel.city}';
      String url = '';
      if (Platform.isAndroid) {
        url = 'geo:0,0?q=$fullAddress';
      } else {
        url = 'http://maps.apple.com/?q=$fullAddress';
      }
      _userAction(url);
    }
  }
}
