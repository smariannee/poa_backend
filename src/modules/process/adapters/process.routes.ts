import {Router} from "express";
import {ProcessController} from "./process.controller";



const router = Router()

/**
 * Verbs
 */

/***
 * AUTH
 */


router.get('/',ProcessController.findUsers)
router.get('/:id' , ProcessController.findById)
router.post('/', ProcessController.createUser)
router.put('/:id', ProcessController.updateUser)
router.patch('/:id', ProcessController.updateStatusUser)



export default router