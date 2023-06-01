import {Router} from "express";
import {AreaController} from "./area.controller";

const router = Router()

/**
 * Verbs
 */

/***
 * AUTH
 */


router.get('/',AreaController.findAreas)
router.get('/:id' , AreaController.findById)
router.post('/', AreaController.createArea)
// router.put('/:id', AreaController.updateUser)
// router.patch('/:id', AreaController.updateStatusUser)



export default router