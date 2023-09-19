import User from "../models/user.model.js";
export const isTrader = async (req, res, next) => {
    const _id = req.user._id;
    const user = await User.findOne({ _id });
    if (!user) {
        return res.status(404).json({
            message: "user not found"
        });
    }
    if (!user.isTrader) {
        return res.status(401).json({
            message: "Unauthorized",
            isTrader: false
        });
    }
    next();
};
//# sourceMappingURL=trader.middleware.js.map