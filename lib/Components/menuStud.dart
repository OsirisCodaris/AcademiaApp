import 'package:academia26102020/Issets/profil_user.dart';
import 'package:academia26102020/LocalRequest/localDatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academia26102020/log_sign.dart';

class MenuStud extends StatefulWidget {
  @override
  _MenuStudState createState() => _MenuStudState();
}

class _MenuStudState extends State<MenuStud> {
  bool isLoading = true;
  List<Map<String, dynamic>> queryRows;
  @override
  void initState() {
    super.initState();
    onLoad();
  }

  onLoad() async {
    queryRows = await DatabaseHelper.instance.user();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.only(left: 3.0),
            // ignore: missing_required_param
            child: DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/academia_log_sign.jpeg"),
                      fit: BoxFit.contain)),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.only(top: 0.0),
          color: Theme.of(context).primaryColor,
          child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 3.0),
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  ListTile(
                    title: isLoading
                        ? new Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Container(
                                padding: new EdgeInsets.all(9.0),
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  strokeWidth: 3.0,
                                ),
                              )
                            ],
                          ))
                        : Text(queryRows[0]["fullname"]),
                    subtitle: isLoading
                        ? new Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Container(
                                padding: new EdgeInsets.all(9.0),
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  strokeWidth: 3.0,
                                ),
                              )
                            ],
                          ))
                        : Text(queryRows[0]["email"]),
                  ),
                ],
              )),
        ),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.all(3.0),
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('Mon profil'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Profil()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).primaryColor,
                ),
                title:
                    Text('Déconnexion', style: TextStyle(color: Colors.grey)),
                onTap: () async {
                  int result;
                  result = await DatabaseHelper.instance.deleteUser();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ChoixLog()));
                },
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  style: TextStyle(),
                  text: 'conçue par', // default text style
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Codaris',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
