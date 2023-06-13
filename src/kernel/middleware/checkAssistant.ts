import {NextFunction, Request, Response} from "express";
import {decodeToken} from "@/kernel/jwt";
import {validateError} from "@/utils/error_codes";


const checkToken = (req: Request, res: Response, next: NextFunction) => {
    try {

        //@ts-ignore
        const dataUser = req.token;
        if(!dataUser) throw Error('Invalid Token');
        const { role } = dataUser;
        if(role != 'Admininstrador' && role != 'Asistente') throw Error('Unauthorized');
        return next();

    } catch (e) {
        const error = validateError(e as Error)
        return res.status(error.code).json(error)
    }
}