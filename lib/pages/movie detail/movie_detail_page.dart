import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/config/config_theme.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/helpers/helper.dart';
import 'package:movie_theater/pages/home/home_page.dart';
import 'package:movie_theater/pages/home/widgets/appbar_back_button.dart';
import 'package:movie_theater/pages/home/widgets/home_page_promo_list.dart';
import 'package:movie_theater/pages/home/widgets/home_page_row_header.dart';
import 'package:movie_theater/pages/home/widgets/side_sheet_active_button.dart';
import 'package:movie_theater/pages/movie%20detail/movie_detail_table.dart';
import 'package:movie_theater/pages/theater%20select/theater_select_page.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';

class MovieDetail extends StatelessWidget {
  MovieDetail({super.key, required this.movie});

  Movie movie;
  String castString = "";
  String directorString = "";
  String genreString = "";

  Future<String> getGenreOutput() async {
    String s = "";
    List<String> genreList = [];
    List<Movie_Genre>? movieGenreList =
        await APIService.getMovieGenreList(movie.id);
    for (int i = 0; i < movieGenreList!.length; i++) {
      Genre? genre = await APIService.getGenreByID(movieGenreList[i].genreId);
      genreList.add(genre!.name);
    }
    s = genreList.join(", ");
    return s;
  }

  Future<String> getDirectorOutput() async {
    String s = "";
    List<String> directorList = [];
    List<Credit>? creditList = await APIService.getMovieCreditList(movie.id);
    if (creditList == null) return s;
    for (int i = 0; i < creditList.length; i++) {
      if (directorList.length >= 3) {
        break;
      }
      if (creditList[i].departmentID == 0 && directorList.length < 3) {
        Participant? participant =
            await APIService.getParticipantByID(creditList[i].particapantID);
        directorList.add(participant!.name);
      }
    }
    s = directorList.join(", ");
    return s;
  }

  Future<String> getCastOutput() async {
    String s = "";
    List<String> castList = [];
    List<Credit>? creditList = await APIService.getMovieCreditList(movie.id);
    if (creditList == null) {
      return s;
    }
    for (int i = 0; i < creditList.length; i++) {
      if (castList.length >= 5) {
        break;
      }
      if (creditList[i].departmentID == 1 && castList.length < 5) {
        Participant? participant =
            await APIService.getParticipantByID(creditList[i].particapantID);
        if (participant != null) {
          castList.add(participant.name); // Use `!` if sure it's not null.
        }
      }
    }
    s = castList.join(", ");
    return s;
  }

  Future getInforFunc() async {
    genreString = await getGenreOutput();
    castString = await getCastOutput();
    directorString = await getDirectorOutput();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //centerTitle: true,
        // title: Image.network(
        //   'https://demotimhecgv.goldena.vn/images/logo.png',
        //   fit: BoxFit.cover,
        //   width: screenSize.width / 6,
        // ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const AppBarBackButton(),
        actions: const [
          SideSheetActiveButton(),
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: FutureBuilder(
            future: getInforFunc(),
            initialData: null,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // Hoặc bất kỳ Widget nào để hiển thị trạng thái chờ
              }
              if (snapshot.hasError) {
                print("Error: ${snapshot.error}");
                return Text(
                  'Error: ${snapshot.error}',
                  style: ThemeConfig.nearlyWhiteTextStyle(),
                ); // Xử lý lỗi
              }
              return SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minHeight: screenSize.height),
                  color: Colors.black,
                  child: Column(
                    children: [
                      Stack(children: [
                        Container(
                          foregroundDecoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0, 0.5],
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Image.network(
                                "https://indieground.net/wp-content/uploads/2023/03/Freebie-GradientTextures-Preview-05.jpg"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(height: screenSize.height / 4.4),
                              Row(
                                children: [
                                  Container(
                                    width: screenSize.width / 4,
                                    height: screenSize.width / 4 * 3 / 2,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              movie.getPosterFullPath())),
                                      //color: Colors.amber,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Title
                                          Text(
                                            movie.title,
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),

                                          //Release Date
                                          Row(
                                            children: [
                                              BoxBorderWithIconAndText(
                                                content: movie.release_date,
                                                icon: Icons.calendar_month,
                                              ),
                                              const SizedBox(width: 10),
                                              BoxBorderWithIconAndText(
                                                content:
                                                    MyHelper.getHourMinFromMin(
                                                        movie.runtime),
                                                icon: Icons.timelapse,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                movie.overview,
                                style: ThemeConfig.nearlyWhiteTextStyle(),
                              ),
                              const SizedBox(height: 20),
                              MovieDetailTable(
                                movie: movie,
                                genreString: genreString,
                                castString: castString,
                                directorString: directorString,
                              ),
                              const SizedBox(height: 50),
                              const RowHeader(),
                              const SizedBox(height: 10),
                              const HomePagePromoList(),
                              const SizedBox(height: 100),
                            ],
                          ),
                        )
                      ]),
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.transparent,
                  width: 3,
                  style: BorderStyle.solid)),
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
          child: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TheaterSelectPage(movie: movie)),
              );
            },
            child: const Text("Book"),
          ),
        ),
      ),
    );
  }
}

class BoxBorderWithIconAndText extends StatelessWidget {
  BoxBorderWithIconAndText({
    super.key,
    this.content = "19/01/2003",
    this.icon = Icons.timelapse,
  });

  String content;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                content,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
