import 'package:example/best_flutter_ui/app_theme.dart';
import 'package:example/best_flutter_ui/hotel_booking/hotel_app_theme.dart';
import 'package:example/best_flutter_ui/hotel_booking/model/hotel_list_data.dart';
import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

@FairPatch()
class HotelListViewContent extends StatelessWidget {
  final VoidCallback callback;
  @FairWell('hotelData')
  final HotelListData hotelData;
  @FairWell('primaryColor')
  final Color primaryColor = HotelAppTheme.buildLightTheme().primaryColor;
  @FairWell('backgroundColor')
  final Color backgroundColor = HotelAppTheme.buildLightTheme().backgroundColor;

  @FairWell('onItemTap')
  void onItemTap() => {callback()};

  String perNight() => '${hotelData.perNight}';

  String reviews() => '${hotelData.reviews} Reviews';

  String distance() => '${hotelData.dist.toStringAsFixed(1)} km to city';

  HotelListViewContent({Key? key,required this.callback,required this.hotelData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
      child: InkWell(
        splashColor: Colors.transparent,
        //onTap: AppTheme.onTapEmpty,//onItemTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color:
                    AppTheme.greyWithOpacity /*Colors.grey.withOpacity(0.6)*/,
                offset: const Offset(4, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 2,
                      child:
                          Image.asset(hotelData.imagePath, fit: BoxFit.cover),
                    ),
                    Container(
                      color: backgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 8, bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      hotelData.titleTxt,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          hotelData.subTxt,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.greyWithOpacity
                                              /*Colors.grey.withOpacity(0.8)*/),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          size: 12,
                                          color: primaryColor,
                                        ),
                                        Expanded(
                                          child: Text(
                                            distance(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppTheme
                                                    .greyWithOpacity /*Colors.grey
                                                    .withOpacity(0.8)*/
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: <Widget>[
                                          SmoothStarRating(
                                            allowHalfRating: true,
                                            starCount: 5,
                                            rating: hotelData.rating,
                                            size: 20,
                                            color: primaryColor,
                                            borderColor: primaryColor,
                                          ),
                                          Text(
                                            reviews(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppTheme
                                                    .greyWithOpacity /*Colors.grey
                                                    .withOpacity(0.8)*/
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16, top: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  perNight(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  '/per night',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme
                                          .greyWithOpacity /*Colors.grey.withOpacity(0.8)*/),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      //onTap: AppTheme.onTapEmpty,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.favorite_border,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
