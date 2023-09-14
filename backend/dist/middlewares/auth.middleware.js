import 'dotenv/config';
import jsonwebtoken from 'jsonwebtoken';
const jwt = jsonwebtoken;
export const blackList = [];
export const isAuthorized = async (req, res, next) => {
    const token = req.headers.authorization?.split(" ")[1];
    //verify the token
    if (!token || blackList.includes(token)) {
        return res.status(403).json({ message: "Unauthorized" });
    }
    try {
        const secret = process.env.JWT_SECRET_KEY;
        const decoded = jwt.verify(token, secret);
        //attach auth user to request
        req.user = decoded;
        next();
    }
    catch (error) {
        console.log(error);
    }
};
export const revokeToken = (token) => {
    const prevLength = blackList.length;
    const currentLength = blackList.push(token);
    if (currentLength > prevLength) {
        return true;
    }
    return false;
};
//# sourceMappingURL=auth.middleware.js.map