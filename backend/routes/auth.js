const express = require('express'); // Express.js - Framework để tạo API
const bcrypt = require('bcryptjs'); // bcryptjs - Thư viện để mã hóa mật khẩu
const jwt = require('jsonwebtoken'); // jsonwebtoken - Thư viện tạo JWT token
const User = require('../models/user'); // Import mô hình User để làm việc với MongoDB

// Tạo Router cho API xác thực
const authRouter = express.Router();

<<<<<<< HEAD
// ma hoa mk
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');


=======
// API đăng ký người dùng
>>>>>>> 2998c69 (Update)
authRouter.post('/api/signup', async (req, res) => {
    try {
        // Lấy dữ liệu từ request body
        const { fullName, email, password } = req.body;

        // Kiểm tra xem email đã tồn tại trong database chưa
        const existingEmail = await User.findOne({ email });
        if (existingEmail) {
            return res.status(400).json({ msg: "Email cung cấp đã tồn tại" });
        }

        // Tạo một chuỗi salt để mã hóa mật khẩu
        const salt = await bcrypt.genSalt(10);

        // Mã hóa mật khẩu bằng bcrypt
        const hashedPassword = await bcrypt.hash(password, salt);

        // Tạo một người dùng mới với thông tin đã mã hóa
        let user = new User({ fullName, email, password: hashedPassword });

        // Lưu người dùng vào cơ sở dữ liệu
        user = await user.save();

        // Trả về thông tin người dùng (không bao gồm mật khẩu)
        res.json({ user });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

<<<<<<< HEAD
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
=======
// API đăng nhập người dùng
authRouter.post('/api/signin', async (req, res) => {
    try {
        // Lấy email và password từ request body
        const { email, password } = req.body;

        // Tìm người dùng trong database theo email
        const findUser = await User.findOne({ email });
        if (!findUser) {
            return res.status(400).json({ msg: "User not found with this email" });
        }

        // So sánh mật khẩu nhập vào với mật khẩu trong database
        const isMatch = await bcrypt.compare(password, findUser.password);
        if (!isMatch) {
            return res.status(400).json({ msg: 'Incorrect Password' });
        }

        // Tạo JWT token để xác thực người dùng
        const token = jwt.sign({ id: findUser._id }, "passwordKey", { expiresIn: "1h" });

        // Loại bỏ password trước khi gửi dữ liệu trả về
        const { password: _, ...userWithoutPassword } = findUser._doc;

        // Trả về token và thông tin người dùng (không chứa mật khẩu)
        res.json({ token, ...userWithoutPassword });
    } catch (error) {
        // Xử lý lỗi nếu có bất kỳ vấn đề nào xảy ra
        res.status(500).json({ error: error.message });
    }
});

// Xuất module authRouter để sử dụng ở file khác
module.exports = authRouter;
>>>>>>> 2998c69 (Update)
