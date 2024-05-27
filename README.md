# movie_theater

A new Flutter project.

#1 Text Overflow
<!-- You should wrap your Container in a Flexible to let your Row know that it's ok for the Container to be narrower than its intrinsic width. Expanded will also work. -->
Flexible(
  child: new Container(
    padding: new EdgeInsets.only(right: 13.0),
    child: new Text(
      'Text largeeeeeeeeeeeeeeeeeeeeeee',
      overflow: TextOverflow.ellipsis,
    ),
  ),
),

#2 Navigation
Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewPage()),
              );

# Future Builder
FutureBuilder(
                  future: Func(),
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
                      ); // Xử lý lỗi
                    }
                    return const Widget();
                  },
                )

# Value Listener
ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

return ValueListenableBuilder(
                        valueListenable: _currentIndex,
                        builder: (context, value, child) {
                          return Column()
                          };
                          )

#