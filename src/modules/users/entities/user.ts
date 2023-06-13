import { Entity } from "@/kernel/types"
import { Role } from "./role"

export type User = Entity<number> & {
    name: string,
    lastname1: string,
    lastname2: string,
    email: string,
    password: string,
    phone_number: string,
    extension_number: string,
    status: boolean,
    availability: boolean,
    role: Role,
    reset_token: string
}