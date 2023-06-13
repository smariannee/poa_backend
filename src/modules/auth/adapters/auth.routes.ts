import {Router} from "express";
import {AuthController} from "../../../modules/auth/adapters/auth.controller";


const router =  Router();


router.post('/login',  AuthController.login);
router.post('/forgot-pwd',  AuthController.generateResetToken);


export default router;