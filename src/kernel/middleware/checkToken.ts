import {NextFunction, Request, Response} from "express";
import {decodeToken} from "@/kernel/jwt";
import {validateError} from "@/utils/error_codes";


const checkToken = (req: Request, res: Response, next: NextFunction) => {
    try {
        // get token from header request
        const token = req.header('Authorization')?.replace('Bearer ', '');
        if (!token) throw Error('Invalid Token');
        const dataToken = decodeToken(token);
        if (!dataToken) throw Error('Expired Token');

        //@ts-ignore
        req.token = dataToken; // add dataUser to request
        return next();

    } catch (e) {
        const error = validateError(e as Error)
        return res.status(error.code).json(error)
    }
}