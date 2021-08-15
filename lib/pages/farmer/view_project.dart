import 'package:agraapp/models/project_class.dart';
import 'package:agraapp/pages/farmer/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;
import 'package:intl/intl.dart';

class ViewProject extends StatelessWidget {
  final Project project;

  const ViewProject({Key key, this.project}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${project.farm.farmTitle}'),
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
                  '${project.farm.farmLocation.toUpperCase()}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: globals.font_family),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Date Founded: ${DateFormat.yMMMd().format(project.farm.farmEstablishDate)}',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          '${globals.apiUrl}${globals.farmImgUrl}${project.farm.id}/attachments/${project.farm.farmImage}'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 20,
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
                  'Required Amount: \$${project.requiredAmount}',
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
                  'Percentage Return: ${project.percentageReturns}%',
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
                  'Project Duration: ${project.duration} weeks',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: globals.font_family),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text('Project Detail',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: globals.font_family)),
            SizedBox(
              height: 10,
            ),
            Text(
              '${project.detail}',
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: globals.font_family,
                  fontSize: 14),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
