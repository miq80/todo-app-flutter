import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 15),
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      'Welcome back!',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700]),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      'Username',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.delete,
            color: Colors.grey[700],
            size: 40,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.settings,
            color: Colors.grey[700],
            size: 40,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: signUserOut,
          child: Icon(
            Icons.logout,
            color: Colors.grey[700],
            size: 40,
          ),
        )
      ],
    );
  }
}
