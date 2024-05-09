import 'package:flutter/material.dart';

class HomePagePromoList extends StatelessWidget {
  const HomePagePromoList({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double padding = 10;
    List<String> promoURLs = [
      "https://iguov8nhvyobj.vcdn.cloud/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/i/m/imgpsh_fullsize_anim_2.png",
      "https://iguov8nhvyobj.vcdn.cloud/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/t/3/t3_-_movie_-_cgv_980x448.jpg",
      "https://iguov8nhvyobj.vcdn.cloud/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/h/o/holo-drink_combo_rbanner.jpg",
      "https://iguov8nhvyobj.vcdn.cloud/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/9/8/980x448_2__12.png",
      "https://iguov8nhvyobj.vcdn.cloud/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/u/n/untitled-2_980x448-min.jpg",
      "https://iguov8nhvyobj.vcdn.cloud/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/m/p/mp_doi_vi_soda_rbanner.png",
      "https://iguov8nhvyobj.vcdn.cloud/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/9/8/980x448_may_gap_thu.jpg",
      "https://iguov8nhvyobj.vcdn.cloud/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/_/c/_cj_-banner-web-980x448.png",
      "https://iguov8nhvyobj.vcdn.cloud/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/i/f/if_rbanner.jpg",
      "https://iguov8nhvyobj.vcdn.cloud/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/2/0/2024_garfield_baby_rolling_banner.jpg",
    ];
    return SizedBox(
        height: (screenSize.width * 0.8 - padding * 2) / 980 * 448,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.8, initialPage: 10),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage(promoURLs[index % promoURLs.length])),
                  ),
                )),
          ),
        ));
  }
}
