import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/modules/shop_app/login/shop_loogin_screen.dart';
import 'package:untitled/shared/component/component.dart';
import 'package:untitled/shared/network/local/shared_helper.dart';
import 'package:untitled/shared/styles/colors.dart';
class BoardingModel {
    late final String image;
    late final String title;
    late final String body;

    BoardingModel({
      required this.image,
      required this.title, 
      required this.body,
    });
    
  }
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List <BoardingModel> boarding = [
  BoardingModel(
    image: 'assets/images/Onboarding.png',
    title: 'Welcome ',
    body: 'Shopping now'),
  BoardingModel(
    image: 'assets/images/souq.png',
    title: 'Screen Title 2',
    body: 'body 2'),
  BoardingModel(
    image: 'assets/images/sign.png',
    title: 'Screen Title 3',
    body: 'body 3'),
  ];

  var boardController = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      actions: [TextButton(
      onPressed:(){
        CachHelper.saveData(
        key: 'onBoarding', 
        value: true).then((value){
          if (value){
          navigateAndFinish(context, ShopLoginScreen());
          }

        });
        
        
      } , 
      child: const Text('Skip')),]
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                itemBuilder: (context,index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (index) {
                  if (index == boarding.length - 1){
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                ),
            ),
              const SizedBox(height: 30.0,),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController, 
                    effect: const ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      spacing: 5.0,
                      dotHeight: 10.0,
                      dotWidth: 10.0
                    ),
                    count: boarding.length),
                  const Spacer(),
                  FloatingActionButton(
                    
                    onPressed: (){
                    if (isLast){
                      CachHelper.saveData(key: 'onBoarding', value: true).then((value){
                        if(value){
                        navigateAndFinish(context, ShopLoginScreen(),
                        );
                        }
                      });
                      
                    }else {
                      boardController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                    }
                    },
                    child: const Icon(Icons.arrow_forward_ios) ,)
                ],
              )
          ],
        ),
      ),
      
        );
  }

  Widget buildBoardingItem(BoardingModel model)=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
        Expanded(
        child: 
        Image(image: AssetImage(model.image),)),
        const SizedBox(height: 16.0,),
        Text(model.title,
        style: const TextStyle(
          fontSize: 20.0,
        ),),
        const SizedBox(height: 16.0,),
        Text(model.body,
        style: const TextStyle(
          fontSize: 16.0,
        ),),
        ],
      );
}