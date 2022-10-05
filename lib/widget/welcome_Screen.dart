import 'package:flutter/material.dart';
import 'package:google_signin/utils/app_strings.dart';
import 'package:google_signin/utils/colors.dart';
import 'package:intl/intl.dart';

class Welcome extends StatelessWidget {
  Welcome({Key? key}) : super(key: key);

  String now = DateFormat("MMM dd , yyyy").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image.asset("assets/images/BMountain.jpg"),
            const Positioned(
                left: 10,
                bottom: 75,
                child: Text(
                  TextConstants.welcomnote,
                  style: TextStyle(fontSize: 40, color: AppColors.textLight),
                )),
            Positioned(
                bottom: 20,
                left: 10,
                child: Text(
                  now,
                  style:
                      const TextStyle(fontSize: 15, color: AppColors.textFaded),
                )),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 5,
                width: MediaQuery.of(context).size.width * 0.6,
                color: Colors.blue,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Stack(
                children: [
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    height: MediaQuery.of(context).size.height * 1,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  const Positioned(
                      bottom: 115,
                      right: 10,
                      child: Text(
                        TextConstants.intro1,
                        style:
                            TextStyle(fontSize: 30, color: AppColors.textLight),
                      )),
                  Positioned(
                      bottom: 100,
                      right: 10,
                      child: Row(
                        children: [
                          Text(
                            TextConstants.intro2,
                            style: const TextStyle(
                                fontSize: 15, color: AppColors.textFaded),
                          ),
                        ],
                      )),
                  Positioned(
                    bottom: 10,
                    right: 30,
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.all(2),
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.textFaded,
                            value: 0.65,
                          ),
                        ),
                        Text(
                          TextConstants.percentage,
                          style: const TextStyle(
                              fontSize: 15, color: AppColors.textFaded),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                TextConstants.inbox,
                style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textFaded,
                    fontWeight: FontWeight.bold),
              )),
        )
      ],
    );
  }
}
