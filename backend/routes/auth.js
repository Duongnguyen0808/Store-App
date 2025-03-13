const express = require('express');
// mo hinh nguoi dung (dc goi tu index.js)
const User = require('../models/user');
// tao 1 bien luu tri dinh tuyen nhanh 
const authRouter = express.Router();

// ma hoa mk
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');


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

// dang nhap api voi pont

authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        const findUser = await User.findOne({ email });
        if (!findUser) {
            return res.status(400).json({ msg: " Không tìm thấy tài khoản " });
        } else {
            const isMatch = await bcrypt.compare(password, findUser.password);
            if (!isMatch) {
                return res.status(400).json({ msg: "Mật khẩu không đúng" });
            } else {
                const token = jwt.sign({ id: findUser._id }, "passwordKey");
                const { password, ...userWithoutPassword } = findUser._doc;
                res.json({ token, ...userWithoutPassword });
            }
        }
    } catch (error) {

    }
});

module.exports = authRouter;