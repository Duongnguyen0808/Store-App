const express = require('express');
// mo hinh nguoi dung (dc goi tu index.js)
const User = require('../models/user');
// tao 1 bien luu tri dinh tuyen nhanh 
const authRouter = express.Router();

// ma hoa mk
const bcrypt = require('bcryptjs');


authRouter.post('/api/signup', async (req, res) => {
    try {
        const { fullName, email, password } = req.body;
        const existingEmail = await User.findOne({ email });
        if (existingEmail) {
            return res.status(400).json({
                msg: "Email cung cấp đã tồn tại"
            });
        } else {
            // tao giai so cho mat khau
            const salt = await bcrypt.genSalt(10);
            // su dung mk dc tao ra 
            const hashedPassword = await bcrypt.hash(password, salt);
            let user = new User({ fullName, email, password: hashedPassword });
            user = await user.save();
            res.json({ user });
        }
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
module.exports = authRouter;