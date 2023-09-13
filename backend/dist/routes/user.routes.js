import { Router } from "express";
import { login } from '../controllers/auth.controller.js';
let router = Router();
router.post("/login", login);
export default router;
//# sourceMappingURL=user.routes.js.map