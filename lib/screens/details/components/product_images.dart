import 'package:flutter/material.dart';
import 'package:smart_prescription/models/pateint_history_model.dart';
import 'package:smart_prescription/shared/helper/mangers/colors.dart';


class ProductImages extends StatefulWidget {

  final PatientHistoryModel model;


  ProductImages(this.model);

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.model.id.toString(),
              child: Image.network(widget.model.imageList[selectedImage]),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.model.imageList.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: ColorsManger.primaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(widget.model.imageList[index]),
      ),
    );
  }
}
