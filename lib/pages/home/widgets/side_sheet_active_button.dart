import 'package:flutter/material.dart';
import 'package:movie_theater/pages/home/home_page.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';

class SideSheetActiveButton extends StatelessWidget {
  const SideSheetActiveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => SideSheet.right(
          body: Container(
            decoration: const BoxDecoration(color: Colors.black38),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                const SizedBox(height: 30),
                const CircleAvatar(
                  radius: 48, // Image radius
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2LXLcFC4dITo9xY44-DbI3cttjeDtK61duaeV2199tg&s'),
                ),
                const Text("username"),
                SideSheetButton(
                  buttonText: "Sign In",
                  func: () => context.read<GlobalUtils>().loginFunc(context),
                ),
                SideSheetButton(
                    buttonText: "Sign Up",
                    func: () =>
                        context.read<GlobalUtils>().signUpFunc(context)),
              ],
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
