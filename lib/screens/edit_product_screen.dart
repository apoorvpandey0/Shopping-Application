import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  // FocusNode() helps to keep track of the form field the user is currently into
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  // To keep track of loading indicator
  bool _isLoading = false;

  // To run our didChangeDependencoes only once we use this bool variable
  bool _isInit = true;

  // We need to control ImageUrl manually for that Image display feature
  final _imageUrlController = TextEditingController();

  // GlobalKey is used to control a Widget from inside a widget, generally used with forms
  final _form = GlobalKey<FormState>();

  // This Map will hold all the entered values
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  // This will hold initial values for form fields
  var _initValues = {
    'id': null,
    'title': '',
    // this to string is required to render initial values in TextFormField
    'price': 0.toString(),
    'description': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    // Added a new listener
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // This method runs before build is executed
    // ModalRoute does not works in initState thats why we are using this function
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments;
      print(productId);
      // productId would be null if we are adding a new product else will be the id of product to be edited
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        // print(_editedProduct.id);
        _initValues = {
          'id': _editedProduct.id,
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          'imageUrl': _editedProduct.imageUrl,
        };
        // We have to initiliaze imageUrl like this because in the TextFormField we cannot...
        // ... have a initialValue and a controller parameter togethe
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }

    // this Fn will run each time build is exectued isilie we set this _isInit to false
    // taki ye Fn ek baar he chale
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // We should dispose all the FocusNodes and listeners after done using
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    // This listener updates the Image if user goes from image field to another field
    // it does so by calling resetting the state and hence now the Image.network loads an image
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    // We'll use this to save the form
    bool isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      setState(() {
        _isLoading = true;
        print('Loading -> TRUE');
      });
    }
    print(_editedProduct.id);
    if (_editedProduct.id == null) {
      print("Adding");
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .then((_) {
        setState(() {
          _isLoading = false;
          print("Loading -> FALSE");
        });

        // Pop the EDIT screen once we are done adding the product
        Navigator.of(context).pop();
      });
    } else {
      print("Updating");
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Running build -> EDITSCREEN");
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),

            // Form saving method 1
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),

//FORM STARTS HEREEEEEEEEEE
              child: Form(
                // here we refer to our GlobalKey
                key: _form,
                child: ListView(
                  children: <Widget>[
                    // TITLE FIELD

                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        // This moves the focus from title to price field
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },

                      // Title field Validation
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a title';
                        } else {
                          return null;
                        }
                      },

                      // onSaved is called for each field when the entire form has been submitted
                      onSaved: (value) {
                        // Updating the _editedPoduct field
                        _editedProduct = Product(
                            title: value,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                            id: _editedProduct.id,
                            isfavourite: _editedProduct.isfavourite);
                      },
                    ),

                    // PRICE FIELD
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a value';
                        }
                        if (double.tryParse(value) == null) {
                          // tryParse return null if it fails to convert the given input
                          return 'Please enter a valid number';
                        }
                        if (double.tryParse(value) <= 0) {
                          return 'Price cannot be less than of equals to 0';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: _editedProduct.title,
                            price: double.parse(value),
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                            id: _editedProduct.id,
                            isfavourite: _editedProduct.isfavourite);
                      },
                    ),

                    // Description field
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: _editedProduct.title,
                            price: _editedProduct.price,
                            description: value,
                            imageUrl: _editedProduct.imageUrl,
                            id: _editedProduct.id,
                            isfavourite: _editedProduct.isfavourite);
                      },
                    ),

                    // Image field
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Center(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                        Expanded(
                          // We need Expanded here because Row takes as much width as possible and then TextFormField will overflow
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,

                            // We are controlling this manually because we need the value to update the Image.network field
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            validator: (value) {
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Make sure URL starts with http/https';
                              }
                              if (!value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg') &&
                                  !value.endsWith('.png') &&
                                  !value.endsWith('.gif') &&
                                  !value.endsWith('.webp')) {
                                return 'Please enter a .jpg/.jpeg/png or a .gif image';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                  title: _editedProduct.title,
                                  price: _editedProduct.price,
                                  description: _editedProduct.description,
                                  imageUrl: value,
                                  id: _editedProduct.id,
                                  isfavourite: _editedProduct.isfavourite);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
