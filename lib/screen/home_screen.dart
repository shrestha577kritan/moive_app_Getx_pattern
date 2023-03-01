import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/moviecontroller.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  //dependency injecited into code
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff05103A),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff05103A),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: appBar_Section(),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Container(
                height: 30.w,
                width: 30.w,
                decoration: BoxDecoration(
                  color: Color(0xff444C6B),
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: Icon(
                  CupertinoIcons.bell,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                // appBar_Section(),
                SizedBox(height: 15.h),
                search_Section(),
                SizedBox(height: 15.h),
                movieHeadingSection(Show: 'Now Showing', more: 'see more'),
                SizedBox(height: 15.h),

                Obx(
                  () => movieController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : CarouselSlider.builder(
                          itemCount:
                              movieController.movieModel?.results?.length ?? 0,
                          itemBuilder: (context, index, realIndex) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(25.r),
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(110.r), // Image radius
                                child: Image.network(
                                    movieController.movieModel?.results![index]
                                            .posterPath ??
                                        'https://tinyurl.com/bdfzkexy',
                                    fit: BoxFit.cover),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: 380.h,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            },
                          ),
                        ),
                ),

                SizedBox(height: 15.h),
                IndicatorSection(),
                SizedBox(height: 15.h),
                movieHeadingSection(Show: 'Top Film', more: 'see more'),
                SizedBox(
                  height: 180.h,
                  child: Obx(
                    () => movieController.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: movieController
                                    .topRatedMovie?.results?.length ??
                                0,
                            separatorBuilder: (context, index) => SizedBox(
                              width: 8.w,
                            ),
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(25.r),
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(60.r), // Image radius
                                  child: Image.network(
                                      movieController.movieModel
                                              ?.results![index].posterPath ??
                                          'https://tinyurl.com/mse684d4',
                                      fit: BoxFit.cover),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AnimatedSmoothIndicator IndicatorSection() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: 5,
      effect: ExpandingDotsEffect(
        dotHeight: 10.h,
        dotWidth: 10.w,
        activeDotColor: Color(0xff4CCDEB),
      ),
    );
  }
}

class appBar_Section extends StatelessWidget {
  const appBar_Section({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30.w,
          width: 30.w,
          decoration: BoxDecoration(
            color: Color(0xffC3EAFC),
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset('assets/profile.png'),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello Arie'),
            Text(
              'Book your favorite movie',
              style: TextStyle(fontSize: 10.sp),
            ),
          ],
        ),
      ],
    );
  }
}

class movieHeadingSection extends StatelessWidget {
  final String Show;
  final String more;
  movieHeadingSection({
    required this.Show,
    required this.more,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Show,
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            more,
            style: TextStyle(color: Color(0xff82879C), fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}

class search_Section extends StatelessWidget {
  const search_Section({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15.h),
            fillColor: Color(0xff2A3457),
            filled: true,
            hintText: 'Search movies...',
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
            ),
            prefixIcon: Container(
              child: Padding(
                padding: EdgeInsets.all(12.sp),
                child: SvgPicture.asset('assets/icons/Search.svg'),
              ),
            ),
            suffixIcon: Container(
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: SvgPicture.asset(
                      'assets/icons/Filter.svg',
                    ),
                  ),
                ],
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
