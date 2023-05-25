import {Router} from "express";
import {UserController} from "./user.controller";


const router = Router()

/**
 * Verbs
 */

/***
 * AUTH
 */


router.get('/',UserController.findUsers)
router.get('/:id' , UserController.findById)
router.post('/', UserController.createUser)
router.put('/:id', UserController.updateUser)
router.patch('/:id', UserController.updateStatusUser)



export default router