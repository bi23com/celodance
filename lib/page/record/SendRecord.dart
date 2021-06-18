import 'package:dpos/base/BaseTitle.dart';
import 'package:dpos/generated/l10n.dart';
import 'package:dpos/page/address/dialog/CoinTypeDialog.dart';
import 'package:dpos/tools/NoScrollBehavior.dart';
import 'package:dpos/tools/view/no_shadow_tab_bar.dart' as NoShadowTabBar;
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'view/SendRecordList.dart';

/// Describe: 发送记录
/// Date: 3/26/21 1:38 PM
/// Path: page/record/send/SendRecord.dart
class SendRecord extends StatefulWidget {
  SendRecord({Key key, @required this.address}) : super(key: key);
  final String address;

  @override
  _SendRecordState createState() => _SendRecordState();
}

class _SendRecordState extends State<SendRecord>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController mPageController = PageController(initialPage: 0);
  var tabs = ["","", ""];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    tabs = [S.of(context).all, S.of(context).send, S.of(context).receive];
    return BaseTitle(
      title: S.of(context).history,
      // rightLeading: [
      //   GestureDetector(
      //     onTap: () {
      //       CoinTypeDialog(
      //               context: context, coinName: "", onItemClick: (name) {})
      //           .show();
      //     },
      //     child: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 10),
      //       child: Image.asset(
      //         "assets/img/cd_sr_screening_icon.png",
      //         width: ScreenUtil.getInstance().getWidth(20),
      //         fit: BoxFit.fitWidth,
      //       ),
      //     ),
      //   ),
      // ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NoShadowTabBar.NoShadowTabBar(
              controller: _tabController,
              indicatorSize: NoShadowTabBar.TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.only(right: 15, left: 15),
              // indicatorPadding: EdgeInsets.symmetric(
              //     horizontal: ScreenUtil.getInstance().getWidthPx(46)),
              onTap: (value) {
                // LogUtil.v("位置====$value");
                // mPageController.jumpToPage(value);
                mPageController.animateToPage(value,
                    duration: Duration(milliseconds: 400), curve: Curves.ease);
              },
              indicatorColor: Color(0XFF34D07F),
              indicatorWeight: ScreenUtil.getInstance().getWidthPx(5),
              labelColor: Color(0XFF252525),
              labelStyle: TextStyle(
                  color: Color(0XFF252525),
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil.getInstance().getSp(14)),
              unselectedLabelStyle: TextStyle(
                  color: Color(0XFFAAAAAA),
                  fontSize: ScreenUtil.getInstance().getSp(14)),
              isScrollable: true,
              tabs: tabs
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList()),
          Expanded(
              child: ScrollConfiguration(
                  behavior: NoScrollBehavior(),
                  child: PageView.builder(
                      itemCount: tabs.length,
                      scrollDirection: Axis.horizontal,
                      controller: mPageController,
                      // physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        //  LogUtil.v("位置==PageView==$index");
                        _tabController.animateTo(index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease);
                      },
                      // physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
                      itemBuilder: (context, index) {
                        return SendRecordList(
                          type: index,
                          address: widget.address,
                        );
                      })))
        ],
      ),
    );
  }
}
