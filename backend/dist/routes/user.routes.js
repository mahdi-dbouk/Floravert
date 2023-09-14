import { Router } from "express";
import { login, register } from '../controllers/auth.controller.js';
import { check } from "express-validator";
let router = Router();
router.post("/login", login);
router.post("/register", [
    check('firstName').notEmpty().withMessage("first name must not be empty"),
    check('lastName').notEmpty().withMessage("first name must not be empty"),
    check('email').isEmail().withMessage("Incorrectly formatted email"),
    check('password').isLength({ min: 6 }).withMessage("password should be at least 6 characters long"),
    check('phone').notEmpty().withMessage("phone number is required"),
    check('age').isInt({ min: 18 }).withMessage("age must be over 18"),
    check('base64Image').notEmpty().withMessage("base64 image is missing")
], register);
export default router;
//# sourceMappingURL=user.routes.js.map