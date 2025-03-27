const mongooge = require('mongoose');

const bannerSchema = mongooge.Schema({
    image: {
        type: String,
        required: true,
    }
});

const Banner = mongooge.model("Banner", bannerSchema);
module.exports = Banner;