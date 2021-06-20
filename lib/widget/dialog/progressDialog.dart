import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_gallery/values/colors.dart';
import 'package:my_gallery/values/dimens.dart';

class ProgressDialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key,String content) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: UIColor.white,
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(UIDimens.margin_upper_medium),
                        child: Row(children: [
                          CircularProgressIndicator(backgroundColor: UIColor.secondPrimaryColor,),
                          SizedBox(width: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: Text(content,overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            maxLines: 3,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.normal,
                                fontSize: UIDimens.font_size_small,
                                color: UIColor.black_overlay),
                          ),)
                        ]),
                      ),
                    )
                  ]));
        });
  }
}