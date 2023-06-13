import { Role } from "../../entities/role"

export type SaveUserDto = {
    name: string,
    lastname1: string,
    lastname2: string,
    email: string,
    phone_number?: string,
    extension_number?: string,
    role: Role
}