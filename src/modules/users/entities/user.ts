import {Entity} from "../../../kernel/types";

export type User = Entity<number> & {
    name: string,
    lastname: string,
    email: string,
    password:string,
    phone_number: string,
    extension_number: string,
    status: boolean,
    role: Role
}

export enum Role {
    Administrator = 'Administrator',Director= 'Director',Assistant = 'Assistant'
}

