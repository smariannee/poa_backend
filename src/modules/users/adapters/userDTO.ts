import {Role} from "../entities/user";

/**
 * Only use specify data
 * Each one in a file
 */
export type GetUserDto = {
    id?:number,
    name: string,
    lastname: string,
    email: string,
    status: boolean,
    role: Role
    password?: string,
}

export type SaveUserDto = {
    name: string,
    lastname: string,
    email: string,
    password: string,
    status: boolean,
    role: Role
}

export type UpdateUserDto = {

    id: number,
    name: string,
    lastname: string,
    email: string,
    password: string,
    status: boolean,
    role: Role
}