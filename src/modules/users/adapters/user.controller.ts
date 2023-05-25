import {ResponseApi} from "../../../kernel/types";
import {SaveUserDto, UpdateStatusUserDto, UpdateUserDto} from "./userDTO";
import {UserRepository} from "../use-cases/ports/user.repository";
import {UserStorageGateway} from "./user.storage.gateway";
import {
    CreateUserInteractor,
    GetAllUsersInteractor,
    GetUserInteractor, UpdateStatusUserInteractor, UpdateUserInteractor,
} from "../use-cases/userInteractor";
import {User} from "../entities/user";
import {Request, Response} from "express";


export class UserController {

    // Error Message initialize
    static getError(): ResponseApi<User> {
        return {
            code: 500,
            error: true,
            message: 'SOMETHING BROKE 😢!',
            cause: 'ERROR_INTERNAL_SEVER'
        } as ResponseApi<User>
    }

    static findUsers = async (req: Request, res: Response): Promise<Response> => {
        try {

            const repo: UserRepository = new UserStorageGateway();
            const interact: GetAllUsersInteractor = new GetAllUsersInteractor(repo);
            const users: User[] = await interact.execute();

            let body: ResponseApi<User> = {
                code: 200,
                error: false,
                message: 'OK',
                data: users
            }

            return res.status(body.code).json(body)

        } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }

    }

    static createUser = async (req: Request, res: Response): Promise<Response> => {
        try {


            const payload: SaveUserDto = {...req.body} as SaveUserDto;
            const repo: UserRepository = new UserStorageGateway();
            const interact: CreateUserInteractor = new CreateUserInteractor(repo);


            if (!await repo.existByEmail(payload.email)) {

                const user: User = await interact.execute(payload);
                const body: ResponseApi<User> = {
                    code: 201,
                    error: false,
                    message: 'CREATED',
                    data: user,
                }

                return res.status(body.code).json(body)

            } else return res.status(400).json({message: 'Email not available ', error: true});


        } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }
    }

    static findById = async (req: Request, res: Response): Promise<Response> => {
        try {
            /**
             * Validation by number
             */
            const id: number = parseInt(req.params.id)

            const repo: UserRepository = new UserStorageGateway();
            const interact: GetUserInteractor = new GetUserInteractor(repo);
            const user: User = await interact.execute(id);

            let body: ResponseApi<User> = {
                code: 200,
                error: false,
                message: 'OK',
                data: user
            }

            if (!user) body = {...this.getError(), message: 'NOT FOUND USER', code: 404, error: false}
            return res.status(body.code).json(body)

        } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }

    }

    static updateUser = async (req: Request, res: Response): Promise<Response> => {
        try {
            const id: number = parseInt(req.params.id)
            const payload: UpdateUserDto = {id, ...req.body} as UpdateUserDto;
            const repo: UserRepository = new UserStorageGateway();
            const interact: UpdateUserInteractor = new UpdateUserInteractor(repo);


            if (!await repo.existByEmail(payload.email)) {

                const user: User = await interact.execute(payload);
                const body: ResponseApi<User> = {
                    code: 200,
                    error: false,
                    message: 'UPDATED',
                    data: user,
                }

                return res.status(body.code).json(body)

            } else return res.status(400).json({message: 'Email not available ', error: true});


        } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }
    }

    static updateStatusUser = async (req: Request, res: Response): Promise<Response> => {
        try {

            const id: number = parseInt(req.params.id)
            const payload: UpdateStatusUserDto = {id,...req.body} as UpdateStatusUserDto;
            const repo: UserRepository = new UserStorageGateway();
            const interact: UpdateStatusUserInteractor = new UpdateStatusUserInteractor(repo);

            const user: User = await interact.execute(payload);
            let body: ResponseApi<User> = {
                code: 201,
                error: false,
                message: 'CREATED',
                data: user,
            }

            if (!user) body = {...this.getError(), message: 'NOT FOUND USER', code: 404, error: false}
            return res.status(body.code).json(body)


        } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }
    }


}