import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_theater/helpers/helper.dart';
import 'package:movie_theater/pages/home/home_page.dart';
import 'package:movie_theater/pages/home/widgets/side_sheet_ctrl.dart';
import 'package:movie_theater/pages/login/login_ctrl.dart';
import 'package:movie_theater/pages/login/login_page.dart';
import 'package:movie_theater/pages/my%20tickets/my_ticket_page.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';

class SideSheetActiveButton extends StatelessWidget {
  const SideSheetActiveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    return IconButton(
      onPressed: () => SideSheet.right(
          width: screenSize.width * 0.85,
          sheetColor: Colors.transparent,
          body: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              //width: MediaQuery.sizeOf(context).width / 1.5,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(color: Colors.black54),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(height: screenSize.height / 20),
                  Visibility(
                    visible: LoginController.currentAccount != null,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: screenSize.width / 10, // Image radius
                          backgroundImage: const NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2LXLcFC4dITo9xY44-DbI3cttjeDtK61duaeV2199tg&s'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          LoginController.currentCustomer != null
                              ? LoginController.currentCustomer!.name
                              : "username",
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Member Card No.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 233, 30, 186),
                              fontSize: 12),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          color: Colors.white,
                          height: 100,
                        ),
                        const SizedBox(height: 10),
                        const UserSpendRewardRow(),
                      ],
                    ),
                  ),
                  const BookingByFilterRow(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconTextBelowWidget(
                              iconData: Icons.houseboat_outlined,
                              content: "Home"),
                          IconTextBelowWidget(
                              iconData: Icons.people_outline,
                              content: "My CGV"),
                          IconTextBelowWidget(
                              iconData: Icons.info_outlined,
                              content: "Theater"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconTextBelowWidget(
                              iconData: Icons.star_border_outlined,
                              content: "Special Theater"),
                          IconTextBelowWidget(
                              iconData: Icons.gif_box_outlined,
                              content: "News & Offer"),
                          IconTextBelowWidget(
                            iconData: Icons.airplane_ticket_outlined,
                            content: "My Tickets",
                            func: SideSheetController.myTicketsOnClick,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconTextBelowWidget(
                              iconData: Icons.food_bank_outlined,
                              content: "CGv Store"),
                          IconTextBelowWidget(
                              iconData: Icons.card_giftcard_outlined,
                              content: "CGV eGift"),
                          IconTextBelowWidget(
                              iconData: Icons.gif_box_outlined,
                              content: "Rewards"),
                        ],
                      ),
                    ],
                  ),
                  LoginController.currentAccount == null
                      ? Column(
                          children: [
                            SideSheetButton(
                              buttonText: "",
                              func: () {},
                              vPad: 1,
                            ),
                            SideSheetButton(
                              buttonText: "Log In",
                              func: () => GlobalUtils.navToLogin(context),
                            ),
                            SideSheetButton(
                                buttonText: "Register",
                                func: () =>
                                    GlobalUtils.navToSignUpPage(context)),
                          ],
                        )
                      : SideSheetButton(
                          buttonText: "Log out",
                          func: () =>
                              LoginController.getInstance().logOutFunc(context),
                        ),
                ],
              ),
            ),
          ),
          context: context),
      icon: const Icon(
        Icons.view_list_rounded,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

class IconTextBelowWidget extends StatelessWidget {
  IconTextBelowWidget({
    super.key,
    this.iconData = Icons.info_outline,
    this.content = "Theater",
    this.func,
  });

  IconData iconData;
  String content;
  Function? func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("clicked");
        if (func != null) {
          func!(context);
        }
      },
      child: Container(
        width: (MediaQuery.sizeOf(context).width * .85 - 30) / 3,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 28,
            ),
            Text(
              content,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingByFilterRow extends StatelessWidget {
  const BookingByFilterRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SideSheetButton(
          buttonText: "",
          func: () {},
          vPad: 0,
        ),
        SideSheetButton(
          buttonText: "Booking by Movie",
          func: () {},
        ),
        SideSheetButton(
          buttonText: "Booking by Theater",
          func: () {},
        ),
      ],
    );
  }
}

class UserSpendRewardRow extends StatelessWidget {
  const UserSpendRewardRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total spend",
              style: TextStyle(
                color: Color.fromARGB(255, 146, 133, 91),
                fontSize: 11,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "100.000\$",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reward point",
              style: TextStyle(
                color: Color.fromARGB(255, 146, 133, 91),
                fontSize: 11,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "16",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            )
          ],
        ),
      ],
    );
  }
}
