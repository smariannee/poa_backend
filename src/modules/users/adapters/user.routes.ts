import { Router } from "express";
import { UserController } from "./user.controller";

const router = Router()

router.get('/',UserController.findUsers)
router.get('/:id' , UserController.findUserById)
router.post('/', UserController.saveUser)
router.put('/:id', UserController.updateUser)
router.patch('/status/:id', UserController.updateStatusUser)
router.patch('/password/:id', UserController.updatePasswordUser)

export default router