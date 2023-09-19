import {Router} from "express";
import {login,logout,register} from '../controllers/auth.controller.js';
import { addScanned, addPost, follow, unfollow, becomeTrader } from "../controllers/user.controller.js";
import {isAuthorized} from '../middlewares/auth.middleware.js';
import {check} from "express-validator";
import { isTrader } from "../middlewares/trader.middleware.js";
import { createProduct, deleteProduct, getAllProducts, updateProduct } from "../controllers/product.controller.js";

let router : Router = Router();

router.post("/login", [
    check('email').isEmail().withMessage("Incorrectly formatted email"),
    check('password').isLength({min: 6}).withMessage("password should be at least 6 characters long"),
], login);

router.post("/register", [
    check('firstName').notEmpty().withMessage("first name must not be empty"),
    check('lastName').notEmpty().withMessage("first name must not be empty"),
    check('email').isEmail().withMessage("Incorrectly formatted email"),
    check('password').isLength({min: 6}).withMessage("password should be at least 6 characters long"),
    check('phone').notEmpty().withMessage("phone number is required"),
    check('age').isInt({min: 18}).withMessage("age must be over 18"),
    check('base64Image').notEmpty().withMessage("base64 image is missing")
], register);

router.get('/logout', isAuthorized, logout);

router.post('/scanned/add', [
    check('commonName').notEmpty().withMessage("common name must not be empty"),
    check('botanicalName').notEmpty().withMessage("botanical name must not be empty"),
    check('description').notEmpty().withMessage("description must not be empty"),
    check('base64Image').notEmpty().withMessage("base64 image is missing"),
], isAuthorized, addScanned);


router.post('/posts/add', [
    check('content').notEmpty().withMessage("content must not be empty"),
], isAuthorized, addPost);

router.post('/follow', isAuthorized, follow);
router.post('/unfollow', isAuthorized, unfollow);


router.post('/account/trader', isAuthorized, becomeTrader);

router.post('/trader/product/add', isAuthorized, isTrader, createProduct);
router.post('/trader/product/delete', isAuthorized, isTrader, deleteProduct);
router.post('/trader/product/update', isAuthorized, isTrader, updateProduct);
router.get('/products', isAuthorized, getAllProducts);
export default router;