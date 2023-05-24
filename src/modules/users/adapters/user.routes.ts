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
// router.put('/:id', UserController.updateUser)
// router.delete('/:id', UserController.deleteUser)



export default router