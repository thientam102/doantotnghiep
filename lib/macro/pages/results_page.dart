import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:appoint/macro/utils/colors.dart';
import 'package:appoint/macro/utils/helpers.dart';
import 'package:appoint/macro/utils/textStyles.dart';
import 'package:appoint/macro/widgets/result_tile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ResultPage extends StatelessWidget {
  ResultPage({
    this.totalCalories,
    this.carbs,
    this.protein,
    this.fats,
    this.bmi,
    this.tdee,
    this.bmiScale,
  });

  final double totalCalories;
  final double carbs;
  final double protein;
  final double fats;
  final double bmi;
  final double tdee;
  final String bmiScale;

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    return Scaffold(
      backgroundColor:
          isThemeDark(context) ? MyColors.darkGrey : MyColors.white,
      appBar: AppBar(
        backgroundColor:
            isThemeDark(context) ? MyColors.darkGrey : MyColors.white,
        elevation: 0,
        title: Text(
          "Kết quả",
          style: isThemeDark(context)
              ? AppBarTitleStyle.dark
              : AppBarTitleStyle.light,
        ),
        leading: IconButton(
          icon: Icon(EvaIcons.arrowIosBack),
          color: isThemeDark(context) ? MyColors.white : MyColors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(6.0),
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                color:
                    isThemeDark(context) ? MyColors.darkGrey : MyColors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ResultTile(
                      title: "Tổng Calories",
                      value: "${totalCalories.toStringAsFixed(0)}",
                      units: "KCALS",
                    ),
                    ResultTile(
                      title: "Tinh bột",
                      value: "${carbs.toStringAsFixed(0)}",
                      units: "GRAMS",
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ResultTile(
                            title: "Chất đạm",
                            value: "${protein.toStringAsFixed(0)}",
                            units: "GRAMS",
                          ),
                        ),
                        Expanded(
                          child: ResultTile(
                            title: "Chất béo",
                            value: "${fats.toStringAsFixed(0)}",
                            units: "GRAMS",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ResultTile(
                            title: "BMI",
                            value: "${bmi.toStringAsFixed(1)}",
                            units: bmiScale,
                          ),
                        ),
                        Expanded(
                          child: ResultTile(
                            title: "TDEE",
                            value: "${tdee.toStringAsFixed(0)}",
                            units: "KCALS",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            // noDataChild: Padding(
            // padding: EdgeInsets.all(18.0),
            Text(
                'Một ngày bạn phải cung cấp năng lượng cho cơ thể khoảng ${totalCalories.toStringAsFixed(0)} Calo\nVới 3 thành phần cơ bản\n *Tinh bột: ${carbs.toStringAsFixed(0)} Grams\n *Chất đạm: ${protein.toStringAsFixed(0)} Grams\n *Chất béo: ${fats.toStringAsFixed(0)} Grams',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18.0)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'share',
        child: Icon(Icons.share_outlined),
        foregroundColor: MyColors.black,
        onPressed: () => shareScreenshot(screenshotController),
      ),
    );
  }

  void shareScreenshot(ScreenshotController key) async {
    var unit8List = await key.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/img.png');
    await file.writeAsBytes(unit8List);
    await Share.shareFiles([file.path], text: 'KET_QUA' + '');
  }
}
