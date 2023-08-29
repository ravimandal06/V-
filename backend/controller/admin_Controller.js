const adminModel = require("../models/admin");
const productModel = require("../models/product.model");
const productService = require("../services/product_service");
const registerAdmin = async (req, res) => {
  try {
    console.log("Register route for admin");
    console.log(req.body);
    var admin = new adminModel(req.body);
    await admin.save();
    let { _id, name, email, phoneNumber } = admin._doc;
    res
      .status(200)
      .json({ status: true, success: "User registered successfully" });
  } catch (err) {
    console.log(err);
    res.status(500).json(err);
  }
};

const loginAdmin = async (req, res) => {
  try {
    console.log("Login route for admin");
    console.log(req.body);
    const { email, password } = req.body;
    const admin = await adminModel.findAndValidate(email, password);
    if (admin) {
      const { _id, name, email, phoneNumber } = admin._doc;
      res.status(200).json({
        status: true,
        success: "User logged in successfully",
        token: _id,
      });
    } else {
      res.status(401).json({ status: false, error: "Invalid Credentials" });
    }
  } catch (err) {
    console.log(err);
    res.status(500).json(err);
  }
};

const addProduct = async (req, res) => {
  try {
    console.log("Adding new product route");
    console.log(req.body);

    const adminId = req.params.adminId;
    let adminDetails = await adminModel.findById(adminId);
    if(adminDetails === null)
    {
      return res.status(401).json({ status: false, error: "Invalid Admin" });
    }
    req.body["city"] = adminDetails.city;
    req.body["shopName"] = adminDetails.shopName;
    req.body["adminId"] = adminId;
    var newProduct = await productModel.create(req.body);
    //adding the new product into the list of products sold by the admin
    adminDetails.products.push(newProduct._id);
    await adminDetails.save();

    console.log(newProduct);
    return res.json({
      status: true,
      details: newProduct,
      message: "Product added successfully ---->",
      token: newProduct._id,
    });
  } catch (err) {
    console.log("---> err -->", err);
    return res.status(500).json(err);
  }
};

const getProducts = async (req, res) => {
  try {
    const city = req.params.city;
    console.log("Get all products in the city ---> ",city);
    const products = await productModel.find({city:city}); // Retrieve all products
    console.log(products);
    return res.json({
      status: true,
      products: products,
      message: "All products retrieved successfully",
    });
  } catch (err) {
    console.log("Error:", err);
    return res.status(500).json(err);
  }
};

const deleteProduct = async (req, res) => {
  try {
    const { id } = req.body;
    console.log("Deleting product with ID:", id);

    const deletedProduct = await productService.deleteProduct(id);
    console.log("Deleted product:", deletedProduct);

    if (!deletedProduct) {
      console.log("Product not found");
      return res.json({ status: false, message: "Product not found" });
    }

    return res.json({ status: true, message: "Product deleted successfully" });
  } catch (err) {
    console.log("Error:", err);
    return res.status(500).json(err);
  }
};

module.exports = {
  registerAdmin,
  loginAdmin,
  addProduct,
  getProducts,
  deleteProduct,
};
