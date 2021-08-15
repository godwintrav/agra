import 'package:agraapp/models/farm_class.dart';
import 'package:agraapp/pages/farmer/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;
import 'package:intl/intl.dart';

class View_Farm extends StatelessWidget {
  final Farm farm;

  const View_Farm({Key key, this.farm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${farm.farmTitle.toUpperCase()}'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.green[500],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 28,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '${farm.farmLocation.toUpperCase()}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: globals.font_family),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Text(
              'Date Founded: ${DateFormat.yMMMd().format(farm.farmEstablishDate)}',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          '${globals.apiUrl}${globals.farmImgUrl}${farm.id}/attachments/${farm.farmImage}'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green[500],
                  size: 28,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Farm name: ${farm.farmTitle.toUpperCase()}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: globals.font_family),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green[500],
                  size: 28,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Farm type: ${farm.farmType}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: globals.font_family),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
