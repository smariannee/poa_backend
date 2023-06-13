import { Router } from "express";
import { UserController } from "./user.controller";

const router = Router()

router.get('/',UserController.findUsers)
router.get('/:id' , UserController.findUserById)
router.post('/', UserController.saveUser)
router.put('/:id', UserController.updateUser)
router.patch('/:id', UserController.updateStatusUser)

export default router