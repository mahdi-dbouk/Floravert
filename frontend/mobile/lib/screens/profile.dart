import 'package:flutter/material.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/providers/scanned_plant_provider.dart';
import 'package:mobile/widgets/horizontal_scrollable_widget_list.dart';
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
        body: SafeArea(
            child: Column(
          children: [
            Stack(children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 110,
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
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                authUserModel.logout();
                                Navigator.of(context).popAndPushNamed('/login');
                              },
                              child: Text("Logout"))
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    height: 100,
                    width: 100,
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
            ]),
            Divider(
              color: primary[100],
            ),
            SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Recently Scanned Plants",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: HorizontallyScrollableSection(
                  scannedPlantModel: Provider.of<ScannedPlantProvider>(context,
                      listen: false)),
            ),
            const SizedBox(
              height: 0,
            ),
            SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "My Products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 200,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: (authUserModel.user.products!.length > 0)
                          ? ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: authUserModel.user.products!.length,
                              separatorBuilder: (context, _) => const SizedBox(
                                    width: 14,
                                  ),
                              itemBuilder: (context, index) => SizedBox(
                                    width: 150,
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                authUserModel
                                                        .user
                                                        .products![index]
                                                        .images![0] ??
                                                    "https://raw.githubusercontent.com/julien-gargot/images-placeholder/master/placeholder-square.png",
                                                fit: BoxFit.cover,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress != null) {
                                                    return Shimmer(
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
                                                          begin:
                                                              FractionalOffset
                                                                  .topLeft,
                                                          end: FractionalOffset
                                                              .bottomRight),
                                                      period: const Duration(
                                                          milliseconds: 1500),
                                                      direction:
                                                          ShimmerDirection.ltr,
                                                      child: Container(
                                                        width: 200,
                                                        height: 256,
                                                        color: Colors.white,
                                                      ),
                                                    );
                                                  } else {
                                                    return child;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text.rich(TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: authUserModel.user
                                                        .products![index].name),
                                              ],
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                        ),
                                      ],
                                    ),
                                  ))
                          : const Center(child: Text("Nothing here yet :("))),
                )),
          ],
        )),
      ),
    );
  }
}
