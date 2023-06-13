import {Request, Response} from "express";
//entities
import {LoginUserDto} from "@/modules/auth/entities";
import {User} from "../boundary";
//ports
import {AuthStorageGateway} from "../adapters/auth.storage.gateway";
import {AuthRepository} from "@/modules/auth/use-cases/ports/auth.repository";
import {AuthLoginInteractor, GenerateResetToken} from "../use-cases";
import {ResponseApi} from "@/kernel/types";
import {generateToken} from "../../../kernel/jwt";
import {validateError} from "../../../utils/error_codes";


export class AuthController{

    static login = async (req:Request, res:Response):Promise<Response> => {
        try {
           // get data from request
            const userDto = {...req.body} as LoginUserDto;
            const repo:AuthRepository = new AuthStorageGateway();
            const interact = new AuthLoginInteractor(repo);
            const user = await interact.execute(userDto) ;

            let body: ResponseApi<User> = {
                code: 200,
                error: false,
                message: 'Ok',
                data: user
            };

            const tokenUser = generateToken(user);
            return res.header('Authorization', `Bearer ${tokenUser}`).status(body.code).json({
                ...body,
                token: tokenUser
            })

        }catch (e) {
            const error = validateError(e as Error)
            return res.status(error.code).json(error)
        }
    }

    static generateResetToken = async (req:Request, res:Response):Promise<Response> => {
        try {
            const email = req.body['email'];
            const repo:AuthRepository = new AuthStorageGateway();
            const interact: GenerateResetToken = new GenerateResetToken(repo);
            const result = await interact.execute(email);

            let body: ResponseApi<boolean> = {
                code: 200,
                error: result,
                message: 'token generated',
            }
            return res.status(body.code).json(body)

        }catch (e){
            const error = validateError(e as Error)
            return res.status(error.code).json(error)
        }
    }
}