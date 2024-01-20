import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/models/shop_app_model/categories_model.dart';
import 'package:untitled/models/shop_app_model/home_model.dart';
import 'package:untitled/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) => productsBuilder(
              cubit.homeModel!, cubit.categoriesModel!, context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeModel? model, CategoriesModel? catModel, context) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data.banners
                    .map((i) => Image(
                          image: NetworkImage(i.image.toString()),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 200.0,
                  initialPage: 0,
                  autoPlay: false,
                  autoPlayAnimationDuration: const Duration(seconds: 3),
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  reverse: false,
                  viewportFraction: 1.0,
                  scrollDirection: Axis.horizontal,
                )),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 100.0,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCatItems(catModel.data.data[index]),
                      itemCount: catModel!.data.data.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 15.0,
                      ),
                    ),
                  ),
                  const Text(
                    'Products',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.58,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  children: List.generate(
                    model.data.products.length,
                    (index) =>
                        buildProducts(model.data.products[index], context),
                  )),
            )
          ],
        ),
      );

  Widget buildProducts(ProductsData model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                ),
                if (model.discount != 0)
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      width: 70,
                      child: const Center(
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: const TextStyle(color: defaultColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            ShopCubit.get(context).favirotes[model.id]
                                ? defaultColor
                                : Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavirotes(model.id);
                          },
                          icon: const Icon(Icons.favorite_border),
                          iconSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget buildCatItems(DataModel model) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(.5),
            width: 100,
            child: Text(
              model.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ],
      );
}
