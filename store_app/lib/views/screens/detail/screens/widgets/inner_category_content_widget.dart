import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/controllers/subcategory_controller.dart';
import 'package:store_app/models/category.dart';
import 'package:store_app/models/subcategory.dart';
import 'package:store_app/views/screens/detail/screens/widgets/inner_banner_widget.dart';
import 'package:store_app/views/screens/detail/screens/widgets/inner_header_widget.dart';

import 'package:store_app/views/screens/detail/screens/widgets/subcategory_tile_widget.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;

  const InnerCategoryContentWidget({super.key, required this.category});

  @override
  State<InnerCategoryContentWidget> createState() =>
      _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryContentWidget> {
  late Future<List<Subcategory>> _subCategories;
  final SubcategoryController _subcategoryController = SubcategoryController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subCategories = _subcategoryController.getSubcategoriesByCategoryName(
      widget.category.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.2,
        ),
        child: const InnerHeaderWidget(),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidget(image: widget.category.banner),
            Center(
              child: Text(
                'Shop By Category',
                style: GoogleFonts.quicksand(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FutureBuilder(
              future: _subCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Subcategories'));
                } else {
                  final subcategories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate(
                        (subcategories.length / 7).ceil(),
                        (setIndex) {
                          final start = setIndex * 7;
                          final end = (setIndex + 1) * 7;

                          return Padding(
                            padding: EdgeInsets.all(8.9),
                            child: Row(
                              children:
                                  subcategories
                                      .sublist(
                                        start,
                                        end > subcategories.length
                                            ? subcategories.length
                                            : end,
                                      )
                                      .map(
                                        (subcategory) => SubcategoryTileWidget(
                                          image: subcategory.image,
                                          title: subcategory.subCategoryName,
                                        ),
                                      )
                                      .toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
