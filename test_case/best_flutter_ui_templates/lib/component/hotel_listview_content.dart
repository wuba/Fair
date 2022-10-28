import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/hotel_booking/hotel_app_theme.dart';
import 'package:best_flutter_ui_templates/hotel_booking/model/hotel_list_data.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@FairPatch()
class HotelListViewContent extends StatelessWidget {
  final VoidCallback? callback;
  @FairWell('hotelData')
  final HotelListData? hotelData;
  @FairWell('primaryColor')
  final Color primaryColor = HotelAppTheme.buildLightTheme().primaryColor;
  @FairWell('backgroundColor')
  final Color backgroundColor = HotelAppTheme.buildLightTheme().backgroundColor;

  @FairWell('onItemTap')
  void onItemTap() => {callback!()};

  String perNight() => '${hotelData!.perNight}';

  String reviews() => '${hotelData!.reviews} Reviews';

  String distance() => '${hotelData!.dist.toStringAsFixed(1)} km to city';

  HotelListViewContent({Key? key, this.callback, this.hotelData})
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
                spreadRadius: 0
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
                          Image.asset(hotelData!.imagePath, fit: BoxFit.cover),
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
                                      hotelData!.titleTxt,
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
                                          hotelData!.subTxt,
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
                                          RatingBar(
                                            initialRating:
                                            hotelData!.rating,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 24,
                                            ratingWidget: RatingWidget(
                                              full: Icon(
                                                Icons.star_rate_rounded,
                                                color: HotelAppTheme
                                                    .buildLightTheme()
                                                    .primaryColor,
                                              ),
                                              half: Icon(
                                                Icons.star_half_rounded,
                                                color: HotelAppTheme
                                                    .buildLightTheme()
                                                    .primaryColor,
                                              ),
                                              empty: Icon(
                                                Icons
                                                    .star_border_rounded,
                                                color: HotelAppTheme
                                                    .buildLightTheme()
                                                    .primaryColor,
                                              ),
                                            ),
                                            itemPadding:
                                            EdgeInsets.zero,
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
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
