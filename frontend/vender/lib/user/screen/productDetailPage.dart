import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:vender/constant.dart';
import 'package:vender/user/model/cart_model.dart';
import 'package:vender/user/model/products.dart';
import 'package:vender/user/screen/sellerInfo.dart';
import 'package:http/http.dart' as http;
import 'reviewProduct.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productType;
  final String productImage;
  final int productQuantity;
  final bool isSelectedToCart;
  final double productOfferPrice;

  const ProductDetailsPage(
      {super.key,
      required this.productName,
      required this.productPrice,
      required this.productType,
      required this.productImage,
      required this.productQuantity,
      required this.isSelectedToCart,
      required this.productOfferPrice});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _quantity = 1;

  void _increaseQuantity() {
    setState(() {
      if (_quantity < 10) {
        _quantity++;
      }
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
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

  bool isProductAddedCart_ = false;

  void toggleSelection(int index) {
    setState(() {
      productList_[index].isSelectedToCart =
          !productList_[index].isSelectedToCart;
      print(productList_[index].isSelectedToCart);
    });
  }

  void addToCart(GetProductRequest product) {
    setState(() {
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
  Future<void> postData() async {
    const String url =
        'http://190.190.2.226:3000/Cart/addToCart'; // Replace with your actual API endpoint

    Map<String, dynamic> data = {
      "userId": "64afa968935c3ce30d04076f",
      "product_name": widget.productName,
      "product_type": widget.productType,
      "product_price": widget.productPrice,
      "product_quantity": widget.productQuantity,
      "product_offerPrice": widget.productOfferPrice,
      "product_stock": 20,
      "product_image": widget.productImage,
      "isSelectedToCart": widget.isSelectedToCart,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print("POST request successful");
      print(response.body); // Response from the server
    } else {
      print("POST request failed with status: ${response.statusCode}");
    }
  }

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<CartModel>(builder: (context, value, child) {
            return Column(
              children: [
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(Icons.arrow_back_ios)),
                    const Icon(Icons.favorite_border_rounded),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                Container(
                  child: Stack(children: [
                    Image.asset(
                      "assets/productContainer.png",
                    ),
                    Positioned(
                      top: 80,
                      left: 60,
                      child: Image.asset(
                        "assets/orange.png",
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.productName,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  "\$${widget.productPrice}",
                  style: const TextStyle(
                      fontSize: 16,
                      // color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _decreaseQuantity();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: const Color(0xffFECC4C),
                              width: 2,
                            ),
                          ),
                          width: 30,
                          height: 30,
                          child: const Center(
                            child: Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "$_quantity",
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          _increaseQuantity();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xffFECC4C),
                            border: Border.all(
                              color: const Color(0xffFECC4C),
                              width: 2,
                            ),
                          ),
                          width: 30,
                          height: 30,
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  width: 325,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      SizedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0xffFECC4C),
                            ),
                            Text("4.5")
                          ],
                        ),
                      ),

                      SizedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_fire_department_outlined,
                              color: Color(0xffFECC4C),
                            ),
                            Text("62 kcal")
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Color(0xffFECC4C),
                            ),
                            Text("30 min")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SellerInfoPage());
                  },
                  child: const SizedBox(
                    // height: 45,
                    width: 325,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        // Container(
                        //   height: 50,
                        //   width: 50,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(100),
                        //     color: const Color(0xffFECC4C),
                        //   ),
                        // )
                        CircleAvatar(),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Orange Juice",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Fresh Orange Juice",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                // Transform.scale(
                                //     scale: 0.3,
                                //     child: Image.asset("assets/shield.png"))

                                Icon(
                                  Icons.shield_outlined,
                                  color: Color(0xffFECC4C),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                const SizedBox(
                  width: 300,
                  child: ExpandableText(
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi '
                        'ut aliquip ex ea commodo consequat.',
                    maxLines: 4, // You can adjust this value as needed.
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      Text(
                        "Review (5)",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0xffFECC4C),
                            ),
                            Text("4.6")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  // height: 45,
                  width: 325,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      // Container(
                      //   height: 50,
                      //   width: 50,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(100),
                      //     color: const Color(0xffFECC4C),
                      //   ),
                      // )
                      CircleAvatar(),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Yelena Belova",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  "2 Minggu yang lalu",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          StarRating(
                            rating: 4.5, // Set the rating value here.
                            size: 18.0, // Adjust the size of the stars.
                            color: Color(
                              0xffFECC4C,
                            ), // Adjust the star color.
                          ),
                          Row(
                            children: [
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor\nincididunt ut labore et dolore magna aliqua.",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //

                          //
                          //
                        ],
                      ),
                    ],
                  ),
                ),
                //
                SizedBox(
                  height: 50,
                  width: 340,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => const ReviewProductPage());
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white, // Text color

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Button border radius
                      ),
                      elevation: 4, // Elevation (shadow)
                    ),
                    child: const Text("See All Review"),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Featured Product",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff0C1A30),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "See All",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue[400]),
                        ),
                      ),
                    ],
                  ),
                ),
                //
                const SizedBox(
                  height: 16,
                ),
                //
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
                        GetProductRequest productSelective_ =
                            productList_[index];
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
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                      });
                                                    },
                                                    child: Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color: productSelective_
                                                                        .isSelectedToCart &&
                                                                    GetStorage().read(
                                                                            'cartItems') !=
                                                                        null
                                                                ? Colors
                                                                    .yellow[300]
                                                                : const Color(
                                                                    0xff0C1A30)),
                                                        child: productSelective_
                                                                    .isSelectedToCart &&
                                                                GetStorage().read(
                                                                        'cartItems') !=
                                                                    null
                                                            ? const Icon(
                                                                Icons
                                                                    .shopping_bag_outlined,
                                                                color: Color(
                                                                    0xff0C1A30),
                                                              )
                                                            : const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                              )),
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
                ),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      child: Column(
                        children: [
                          const Text(
                            "Total x2",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff0C1A30),
                            ),
                          ),
                          RichText(
                              text: TextSpan(children: [
                            const TextSpan(
                              text: "\$",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffFECC4C),
                              ),
                            ),
                            TextSpan(
                              text: widget.productPrice,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0C1A30),
                              ),
                            ),
                          ]))
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 60.0),
                      child: SizedBox(
                        height: 50,
                        width: 180,
                        child: ElevatedButton(
                          onPressed: () {
                            //
                            postData();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor:
                                const Color(0xffFECC4C), // Text color

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  54), // Button border radius
                            ),
                          ),
                          child: const Text(
                            "Add to Cart",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    //
                  ],
                ),
              ],
            );
          }),
        )),
      ),
    );
  }
}

//
class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableText({super.key, required this.text, this.maxLines = 2});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: _isExpanded ? widget.maxLines : null,
          overflow: TextOverflow.ellipsis,
        ),
        InkWell(
          onTap: _toggleExpanded,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              _isExpanded ? 'Less' : 'More',
              style: const TextStyle(
                color: Color(0xffFECC4C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;

  const StarRating(
      {super.key,
      required this.rating,
      this.size = 24.0,
      this.color = Colors.yellow});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.toInt();
    double remainingStar = rating - fullStars;

    List<Widget> stars = List.generate(fullStars, (index) {
      return Icon(
        Icons.star,
        size: size,
        color: color,
      );
    });

    if (remainingStar > 0) {
      stars.add(
        Icon(
          Icons.star_half,
          size: size,
          color: color,
        ),
      );
    }

    return Row(
      children: stars,
    );
  }
}
