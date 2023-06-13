import { Role } from "../../entities/role"

export type GetUserDto = {
    id: number,
    name: string,
    lastname1: string,
    lastname2: string,
    email: string,
    phone_number?: string,
    extension_number?: string,
    status: boolean,
    availability: boolean,
    role: Role,
    password?: string,
}