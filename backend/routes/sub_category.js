const express = require('express');
const SubCategory = require('../models/sub_category');

const subcategoryRouter = express.Router();

// API tạo danh mục con
subcategoryRouter.post('/api/subcategories', async (req, res) => {
    try {
        const { categoryId, categoryName, image } = req.body;
        const subCategory = new SubCategory({ categoryId, categoryName, image });
        await subCategory.save();
        res.status(201).send(subCategory);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

subcategoryRouter.get('/api/category/:categoryName/subcategories', async (req, res) => {
    try {
        const { categoryName } = req.params;

        const subcategories = await SubCategory.find({ categoryName: categoryName });


        if (!subcategories || subcategories.length == 0) {
            return res.status(404).json({ msg: "subcategories not found " });
        } else {
            return res.status(200).json(subcategories);
        }
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
module.exports = subcategoryRouter;
