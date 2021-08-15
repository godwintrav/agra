import 'package:agraapp/controllers/investor_controller.dart';
import 'package:agraapp/models/project_class.dart';
import 'package:agraapp/pages/investor/navigation_bar.dart';
import 'package:agraapp/pages/investor/view_project.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;

class AllProjects extends StatefulWidget {
  @override
  _AllProjectsState createState() => _AllProjectsState();
}

class _AllProjectsState extends State<AllProjects> {
  int result;
  List<Project> projects;
  int projectsCount;

  @override
  void initState() {
    super.initState();
    projectsCount = -1;
    getProjects();
  }

  void getProjects() async {
    projects = await InvestorController().fetchallProjects();
    setState(() {
      projectsCount = projects.length;
    });
  }

  Widget _NoProject() {
    return Center(
      child: Text(
        'No Available Project Currently',
        style: TextStyle(fontSize: 14, fontFamily: globals.font_family),
      ),
    );
  }

  Widget _ProjectCard(int index) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 120,
      width: double.maxFinite,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InvestorViewProject(project: projects[index]),
              ));
        },
        splashColor: Colors.green[500],
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 7, 7, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${projects[index].farm.farmTitle.toUpperCase()}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: globals.font_family,
                        color: Colors.green[500]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        projects[index].farm.farmType.toUpperCase(),
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: globals.font_family),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Text(
                    '${projects[index].percentageReturns}% returns',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontFamily: globals.font_family),
                  ),
                  Text(
                    projects[index].farm.farmLocation,
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontFamily: globals.font_family),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ProjectList() {
    return ListView.builder(
      itemCount: projectsCount,
      itemBuilder: (context, index) {
        return _ProjectCard(index);
      },
    );
  }

  Widget _LoadingProjects() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AVAILABLE PROJECTS",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: globals.font_family),
        ),
        backgroundColor: Colors.green[500],
        elevation: 0.0,
      ),
      body: (projectsCount > 0)
          ? _ProjectList()
          : (projectsCount == 0)
              ? _NoProject()
              : _LoadingProjects(),
      bottomNavigationBar: BottomBar(),
    );
  }
}
