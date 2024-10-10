import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/network/server_calls/cart_api.dart';
import 'package:millyshb/configs/network/server_calls/order_api.dart';
import 'package:millyshb/models/cart_product_model.dart';
import 'package:millyshb/models/coupon_model.dart';
import 'package:millyshb/models/delivery_slot_model.dart';
import 'package:millyshb/models/product_model.dart';
import 'package:millyshb/view/payment/payment_success_screen.dart';
import 'package:millyshb/view_model/product_view_model.dart';
import 'package:provider/provider.dart';

class CartProvider with ChangeNotifier {
  Cart _cart = Cart(
      id: '',
      user: '',
      products: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      version: 0);
  bool get isLoading => _isLoading;
  bool _isLoading = false;
  List<DeliverySlot> _lstSlot = [];
  List<DeliverySlot> get lstSlot => _lstSlot;
  List<Coupon> _lstCoupon = [];
  List<Coupon> get lstCoupon => _lstCoupon;
  List<DeliverySlot> _lstMorningSlot = [];

  List<DeliverySlot> get lstMorningSlot => _lstMorningSlot;
  List<DeliverySlot> _lstFreeDelivery = [];
  List<DeliverySlot> get lstFreeDelivery => _lstFreeDelivery;
  List<DeliverySlot> _lstfixedTimeDelivery = [];
  List<DeliverySlot> get lstfixedTimeDelivery => _lstfixedTimeDelivery;
  List<DeliverySlot> _lstExpressDeliverySlot = [];
  List<DeliverySlot> get lstExpressDeliverySlot => _lstExpressDeliverySlot;
  // Getter for the product list
  dynamic get userCart => _cart;

  addTOCart(Product product, String userId, BuildContext context) async {
    bool isLogin = SharedPrefUtil.getValue(isLogedIn, false) as bool;

    if (isLogin) {
      ApiResponseWithData response =
          await CartAPIs().addProductToCart(product.id, userId);
      if (response.success) {
        // (userCart as Cart).products.add(product);
        await getCart(userId, context);
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text("Product Added"),
        //   backgroundColor: Colors.green,
        // ));
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(response.message),
        //     backgroundColor: Colors.red,
        //   ),
        // );
      }
    } else {
      CartItem cartItem = CartItem(id: "", product: product, quantity: 1);
      _cart.products.add(cartItem);
    }

    notifyListeners();
  }

  getCart(String userId, BuildContext context) async {
    ApiResponseWithData response = await CartAPIs().getCart(userId);
    if (response.success) {
      _cart = Cart.fromJson(response.data["data"]);
    } else {}
  }

  getCoupon(BuildContext context) async {
    ApiResponseWithData response = await OrderApi().getCoupon();
    if (response.success) {
      _lstCoupon = (response.data["data"] as List)
          .map((item) => Coupon.fromJson(item))
          .toList();
      //_lstCoupon = Coupon.fromJson(response.data["data"]);
    } else {}
  }

  getSlot(String deliveryDate, BuildContext context) async {
    ApiResponseWithData response = await CartAPIs().getSlot(deliveryDate);

    if (response.success) {
      _lstSlot = (response.data["data"] as List)
          .map((item) => DeliverySlot.fromJson(item))
          .toList();
      //Fixed Time Delivery
      _lstFreeDelivery = _lstSlot
          .where((order) => order.deliveryType == "Free Delivery")
          .toList();
      _lstMorningSlot = _lstSlot
          .where((order) => order.deliveryType == "Morning Delivery")
          .toList();
      _lstfixedTimeDelivery = _lstSlot
          .where((order) => order.deliveryType == "Fixed Time Delivery")
          .toList();
      _lstExpressDeliverySlot = _lstSlot
          .where((order) => order.deliveryType == "Express Delivery I")
          .toList();
    } else {}
  }

  removeFromCart(String userId, Product product, BuildContext context) async {
    ApiResponse response = await CartAPIs().removeProduct(
      product.id,
      userId,
    );
    if (response.success) {
      int index =
          _cart.products.indexWhere((product) => product.id == product.id);
      _cart.products.removeAt(index);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Internal server error"),
          backgroundColor: Colors.red,
        ),
      );
    }
    notifyListeners();
  }

  increaseProductQuantity(
      String userId, Product product, BuildContext context) async {
    ApiResponse response = await CartAPIs().increaseProduct(
      product.id,
      userId,
    );
    if (response.success) {
      await getCart(userId, context);

      // int index =
      //     _cart.products.indexWhere((product) => product.id == product.id);
      // _cart.products.removeAt(index);

      //(userCart as Cart).products.remove(product);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Internal server error"),
          backgroundColor: Colors.red,
        ),
      );
    }
    notifyListeners();
  }

  decreaseProductQuantity(
      String userId, Product product, BuildContext context) async {
    ApiResponse response = await CartAPIs().decreaseProduct(
      product.id,
      userId,
    );
    if (response.success) {
      await getCart(userId, context);

      // int index =
      //     _cart.products.indexWhere((product) => product.id == product.id);
      // _cart.products.removeAt(index);

      //(userCart as Cart).products.remove(product);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Internal server error"),
          backgroundColor: Colors.red,
        ),
      );
    }
    notifyListeners();
  }

  createOrder(String userId, String slotId, BuildContext context) async {
    ApiResponseWithData response = await OrderApi().createOrder(
      userId,
      slotId,
    );
    if (response.success) {
      await getCart(userId, context);
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.getOrderList(userId, context, isForceRefresh: true);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const PaymentSuccessScreen();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Internal server error"),
          backgroundColor: Colors.red,
        ),
      );
    }
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    // notifyListeners();
  }
}
