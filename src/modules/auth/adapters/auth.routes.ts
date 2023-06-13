import {Router} from "express";
import {AuthController} from "../../../modules/auth/adapters/auth.controller";


const router =  Router();


router.post('/login',  AuthController.login);


export default router;