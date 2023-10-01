import 'package:flutter/material.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (BuildContext context, authUserModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(children: [
          Stack(children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 160,
                color: primary[200]),
            Column(children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.black87,
                            size: 32.0,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("back",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16))
                        ],
                      )),
                ],
              ),
              Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).colorScheme.primary)),
                  child: (authUserModel.user.pictureUrl == null)
                      ? Shimmer(
                          gradient: LinearGradient(
                              colors: [
                                Colors.grey[300]!,
                                Colors.grey[300]!,
                                Colors.grey[300]!,
                                Colors.grey[300]!,
                                Colors.grey[300]!,
                                Colors.grey[100]!,
                                Colors.grey[300]!,
                                Colors.grey[300]!,
                                Colors.grey[300]!,
                                Colors.grey[300]!,
                                Colors.grey[300]!,
                              ],
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight),
                          period: const Duration(milliseconds: 1500),
                          direction: ShimmerDirection.ltr,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(200)),
                          ),
                        )
                      : Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(400)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(400),
                            child: Image.network(
                              authUserModel.user.pictureUrl!,
                              fit: BoxFit.cover,
                            ),
                          ))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  authUserModel.user.username!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 25,
                  child: Center(
                    child: Text(
                      authUserModel.user.email!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
            ])
          ])
        ]))),
      ),
    );
  }
}
