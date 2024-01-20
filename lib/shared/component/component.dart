import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/shared/styles/colors.dart';

import '../../modules/news_app/webview/webview_screen.dart';

Widget defaultButton({
  
  double width = double.infinity,
  Color background = defaultColor,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: background,
        ),
        
      child: MaterialButton(
        
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormFeild({
  required TextEditingController controller,
  required TextInputType type,
  onChanged,
  onSubmitted,
  final FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  suffixPress,
  onTap,
}) =>
    SizedBox(
      height: 70,
      child: TextFormField(
        style: const TextStyle(fontSize: 13,),
        controller: controller,
        keyboardType: type,
        onFieldSubmitted: onSubmitted,
        validator: validate,
        obscureText: isPassword,
        onChanged: onChanged,
        onTap: onTap,
        decoration: (InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(prefix),
          suffixIcon: IconButton(
              onPressed:
                suffixPress
              ,
              icon: Icon(suffix)),
        )
        ),
        
      ),
    );

Widget buildArticleItems(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['link']));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                      image: NetworkImage('${article['image_url']}'),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Text(
                      '${article['pubDate']}',
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articleBuilder(list) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArticleItems(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length),
    fallback: (context) => const Center(child: CircularProgressIndicator()));
void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      ( route ) => false,
      // (Route<dynamic> route) => until,
    );

Future<bool?> showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

// ignore: constant_identifier_names
enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.yellow;
  }
  return color;
}
