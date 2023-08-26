import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vender/constant.dart';
import 'package:vender/user/screen/cart.dart';
import 'package:vender/user/model/cart_model.dart';
import 'package:vender/user/model/products.dart';
import 'package:http/http.dart' as http;
import 'productDetailPage.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
//
  Future<List<dynamic>> fetchProducts() async {
    final response = await http
        .get(Uri.parse('http://190.190.2.226:3000/admin/getProduct/'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse != null &&
          jsonResponse['product_list'] is List<dynamic>) {
        final products = jsonResponse['product_list'] as List<dynamic>;
        return products;
      } else {
        throw Exception("Response is not a valid product list");
      }
    } else {
      throw Exception("GET request failed with status: ${response.statusCode}");
    }
  }

//
  final List<GetProductRequest> productList_ = [
    GetProductRequest(
      userId: "64afa968935c3ce30d04076f",
      productType: 'Drinks',
      productName: 'Wine',
      productPrice: 199.99,
      productStock: 10,
      productImage: 'assets/wine.jpg',
      productOfferPrice: 188.22,
      productQuantity: 1,
      isSelectedToCart: false,
    ),
    GetProductRequest(
      userId: "64afa968935c3ce30d04076f",
      productType: 'Fruits',
      productName: 'Apple',
      productPrice: 88.99,
      productStock: 20,
      productImage: 'assets/apple.jpg',
      productOfferPrice: 76.22,
      productQuantity: 1,
      isSelectedToCart: false,
    ),
    GetProductRequest(
      userId: "64afa968935c3ce30d04076f",
      productType: 'Drinks',
      productName: 'Vodka',
      productPrice: 299.99,
      productStock: 10,
      productImage: 'assets/wine.jpg',
      productOfferPrice: 148.22,
      productQuantity: 1,
      isSelectedToCart: false,
    ),
    GetProductRequest(
      userId: "64afa968935c3ce30d04076f",
      productType: 'Fruits',
      productName: 'Orange',
      productPrice: 188.99,
      productStock: 20,
      productImage: 'assets/apple.jpg',
      productOfferPrice: 76.22,
      productQuantity: 1,
      isSelectedToCart: false,
    ),
  ];

  int selectedCategory = 0;
  List<String> categoryTab_ = [
    'All',
    'Fruits & Vegetables',
    'Dairy Products',
    'Meat & Seafood',
    'Pantry Staples',
    'Snacks & Beverages',
    'Bakery & Bread',
    'Personal Care & Household',
  ];
  //

  bool isProductAddedCart_ = false;
  bool isProductAddedToCart(GetProductRequest product) {
    return selectedItems.contains(product);
  }

  void toggleSelection(int index) {
    setState(() {
      productList_[index].isSelectedToCart =
          productList_[index].isSelectedToCart;
      print(
          "is selected added to cart ? -> ${productList_[index].isSelectedToCart}");
    });
  }

  void addToCart(GetProductRequest product) {
    setState(() {
      // Update the isSelectedToCart property
      product.isSelectedToCart = true;
      selectedItems.add(product);
      print(selectedItems.length);
    });
  }

  void selectedItemsList(int index) {
    setState(() {
      print(productList_[index].productName);
      String productName = productList_[index].productName;
      double productPrice = productList_[index].productPrice;
      String productType = productList_[index].productType;
      String productImage = productList_[index].productImage;
      int productQuantity = productList_[index].productQuantity;
      bool isSelectedToCart = productList_[index].isSelectedToCart;
      double productOfferPrice = productList_[index].productOfferPrice;

      // Use Navigator to push a new page with the selected product name.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsPage(
            productName: productName,
            productPrice: "$productPrice",
            productType: productType,
            productImage: productImage,
            productQuantity: productQuantity,
            isSelectedToCart: isSelectedToCart,
            productOfferPrice: productOfferPrice,
          ),
        ),
      );
    });
  }

  //

  //

  @override
  Widget build(BuildContext context) {
    final width_ = MediaQuery.of(context).size.width * 360;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: width_,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    const Text("Our Store",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartPage(),
                              // products: selectedItems
                            ),
                          );
                        });
                      },
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: width_,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff843667),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 26.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "D Mart",
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xffeeeeee),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Find your daily needs\nhere to your door step",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xffeeeeee),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Shop new arrivals",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xffffdcbc),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //
              const SizedBox(height: 16),

              SizedBox(
                width: MediaQuery.sizeOf(context).width * 360,
                height: 50,
                child: ListView.builder(
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryTab_.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            padding: const EdgeInsets.all(11),
                            // height: 70,
                            decoration: BoxDecoration(
                              color: index == selectedCategory
                                  ? const Color(0xff0C1A30)
                                  : const Color(0xffeeeeee),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                categoryTab_[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: index == selectedCategory
                                      ? const Color(0xffeeeeee)
                                      : const Color(0xff0C1A30),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 16.0,
              ),

              SizedBox(
                height: 50,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "New Sales",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff0C1A30),
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "See all",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue[400]),
                        ))
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 16,
              // ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 360,
                height: 265,
                child: Consumer<CartModel>(
                    // stream: null,
                    builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: productList_.length,
                    // clipBehavior: Clip.none,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final productLists_ = productList_[index];
                      GetProductRequest productSelective_ = productList_[index];
                      productSelective_.isSelectedToCart = true;
                      return Padding(
                        padding: const EdgeInsets.only(right: 9),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedItemsList(index);
                              print('tapped $index product');
                            });
                          },
                          child: Container(
                            width: 166,
                            height: 263,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.1),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 158,
                                    height: 159,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        productLists_.productImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            productLists_.productType,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff0C1A30),
                                            ),
                                          ),
                                          Text(
                                            productLists_.productName,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff0C1A30),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 130,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "\$ ${productLists_.productPrice}",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff0C1A30),
                                                  ),
                                                ),
                                                // SizedBox(width: 10,),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      toggleSelection(index);
                                                      print(
                                                          'tapped $index product');

                                                      Provider.of<CartModel>(
                                                              context,
                                                              listen: false)
                                                          .addToCart(index);
                                                      if (!isProductAddedToCart(
                                                          productList_[
                                                              index])) {
                                                        // postData();
                                                        addToCart(productList_[
                                                            index]);
                                                        Get.snackbar(
                                                          "Product Added",
                                                          "Product added to cart",
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM,
                                                          backgroundColor:
                                                              Colors.green[300],
                                                          colorText:
                                                              Colors.white,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 2),
                                                          icon: const Icon(
                                                            Icons
                                                                .check_circle_outline_rounded,
                                                            color: Colors.white,
                                                          ),
                                                        );
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    width: isProductAddedToCart(
                                                            productList_[index])
                                                        ? 50
                                                        : 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          isProductAddedToCart(
                                                                  productList_[
                                                                      index])
                                                              ? Colors
                                                                  .yellow[300]
                                                              : const Color(
                                                                  0xff0C1A30),
                                                    ),
                                                    child: isProductAddedToCart(
                                                            productList_[index])
                                                        ? const Icon(
                                                            Icons
                                                                .shopping_bag_outlined,
                                                            color: Color(
                                                                0xff0C1A30),
                                                          )
                                                        : const Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              )
            ],
          ),
        )),
      ),
    );
  }
}
