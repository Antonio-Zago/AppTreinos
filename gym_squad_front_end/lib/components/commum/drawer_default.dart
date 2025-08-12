import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class DrawerDefault extends StatefulWidget {
  const DrawerDefault({super.key});

  @override
  State<DrawerDefault> createState() => _DrawerDefaultState();
}

class _DrawerDefaultState extends State<DrawerDefault> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(ColorConstants.fundoApp),
      child: ListView(
        children: [
           UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(ColorConstants.douradoPadrao)
            ),
              accountName: Text("Macoratti"),
              accountEmail: Text("macoratti@yahoo.com"),
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                backgroundImage:AssetImage("assets/images/squad-home.png"),
                backgroundColor: Colors.transparent,
              ),
            ),
          ListTile(
            title: Text(
              "Grupos",
              style: TextStyle(
                color: Color(ColorConstants.brancoPadrao),
                fontSize: 20
              ),
            ),
            leading: Icon(
              Icons.group_outlined,
              color: Color(ColorConstants.brancoPadrao),
            ),
             trailing: Icon(Icons.arrow_forward),
             onTap: (){
              Navigator.pushNamed(
                                      context,
                                      '/home',
                                    );
             },
          ),
          ListTile(
            title: Text(
              "Treinos",
              style: TextStyle(
                color: Color(ColorConstants.brancoPadrao),
                fontSize: 20
              ),
            ),
            leading: Icon(
              Icons.fitness_center,
              color: Color(ColorConstants.brancoPadrao),
            ),
             trailing: Icon(Icons.arrow_forward),
             onTap: (){
               Navigator.pushNamed(
                                      context,
                                      '/treinos-individuais',
                                    );
             },
          ),

          ListTile(
            title: Text(
              "Histórico",
              style: TextStyle(
                color: Color(ColorConstants.brancoPadrao),
                fontSize: 20
              ),
            ),
            leading: Icon(
              Icons.calendar_month,
              color: Color(ColorConstants.brancoPadrao),
            ),
             trailing: Icon(Icons.arrow_forward),
             onTap: (){
               Navigator.pushNamed(
                                      context,
                                      '/calendario-treinos',
                                    );
             },
          ),
          
        ],
      )
    );
  }
}