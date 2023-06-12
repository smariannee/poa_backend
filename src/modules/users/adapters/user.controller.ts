import { Request, Response } from "express";
import { ResponseApi } from "../../../kernel/types";
import { User } from "../entities/user";
import { GetAllUsersInteractor, GetUserInteractor, SaveUserInteractor, UpdateStatusUserInteractor, UpdateUserInteractor } from "../use-cases";
import { UserRepository } from "../use-cases/ports/user.repository";
import { UserStorageGateway } from "./user.storage.gateway";
import { SaveUserDto, UpdateStatusUserDto, UpdateUserDto } from "./dto";
import { validateError } from "../../../utils/error_codes";

export class UserController {

    static findUsers = async (req: Request, res: Response): Promise<Response> => {
        try {
            const repository: UserRepository = new UserStorageGateway();
            const interact: GetAllUsersInteractor = new GetAllUsersInteractor(repository);
            const users: User[] = await interact.execute();
            let body: ResponseApi<User[]> = {
                code: 200,
                error: false,
                message: 'Ok',
                data: users
            }
            return res.status(body.code).json(body)
        } catch (e) {
            return res.status(500).json(validateError(e as Error))
        }

    }

    static findUserById = async (req: Request, res: Response): Promise<Response> => {
        try {
            const id: number = parseInt(req.params.id)
            const repository: UserRepository = new UserStorageGateway();
            const interact: GetUserInteractor = new GetUserInteractor(repository);
            const user: User = await interact.execute(id);
            let body: ResponseApi<User> = {
                code: 200,
                error: false,
                message: 'Ok',
                data: user
            }
            return res.status(body.code).json(body)
        } catch (e) {
            throw Error('Server Error' + e);
        }

    }

    static saveUser = async (req: Request, res: Response): Promise<Response> => {
        try {
            const payload: SaveUserDto = {...req.body} as SaveUserDto
            const repository: UserRepository = new UserStorageGateway()
            const interact: SaveUserInteractor = new SaveUserInteractor(repository)
            const user: User = await interact.execute(payload)
            const body: ResponseApi<User> = {
                code: 201,
                error: false,
                message: 'Created',
                data: user,
            }
            return res.status(body.code).json(body)
        } catch (e) {
            const error = validateError(e as Error)
            return res.status(error.code).json(error)
        }
    }

    static updateUser = async (req: Request, res: Response): Promise<Response> => {
        try {
            const id: number = parseInt(req.params.id)
            const payload: UpdateUserDto = {id, ...req.body} as UpdateUserDto;
            const repository: UserRepository = new UserStorageGateway();
            const interact: UpdateUserInteractor = new UpdateUserInteractor(repository);
            const user: User = await interact.execute(payload);
            const body: ResponseApi<User> = {
                code: 200,
                error: false,
                message: 'Updated',
                data: user,
            }
            return res.status(body.code).json(body)
        } catch (e) {
            throw Error('Server Error' + e);
        }
    }

    static updateStatusUser = async (req: Request, res: Response): Promise<Response> => {
        try {

            const id: number = parseInt(req.params.id)
            const payload: UpdateStatusUserDto = {id,...req.body} as UpdateStatusUserDto;
            const repository: UserRepository = new UserStorageGateway();
            const interact: UpdateStatusUserInteractor = new UpdateStatusUserInteractor(repository);
            const user: User = await interact.execute(payload);
            let body: ResponseApi<User> = {
                code: 201,
                error: false,
                message: 'Updated',
                data: user,
            }
            return res.status(body.code).json(body)
        } catch (e) {
            throw Error('Server Error' + e);
        }
    }

}