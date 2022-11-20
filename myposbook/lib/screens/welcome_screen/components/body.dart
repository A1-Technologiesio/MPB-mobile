import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreenBody extends StatelessWidget {
  const WelcomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mediaWidth * 0.05,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: mediaHeight * 0.05,
              ),
              child: SizedBox(
                height: mediaHeight * 0.39,
                // child: Image.asset(
                //   'lib/assets/images/undraw_setup_analytics_re_foim 1.png',
                // ),
                child: Lottie.asset(
                  'lib/assets/lottiefiles/115876-calculator.json',
                  // height: mediaHeight * 0.5,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  'Hello and Welcome!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: mediaHeight * 0.04,
                  ),
                ),
                SizedBox(height: mediaHeight * 0.02),
                Text(
                  'We help you track POS Business cashouts and deposits easily and with little effort',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: mediaHeight * 0.019,
                  ),
                )
              ],
            ),
            SizedBox(
              height: mediaHeight * 0.063,
            ),
            // buttons
            Column(
              children: [
                SizedBox(
                  height: mediaHeight * 0.07,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/create_account');
                    },
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(
                          fontSize: mediaHeight * 0.018,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff27142A),
                    ),
                  ),
                ),
                SizedBox(height: mediaHeight * 0.02),
                SizedBox(
                  height: mediaHeight * 0.07,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'I already have an account',
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: mediaHeight * 0.018,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      primary: Color(0xfF6F5F5),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
