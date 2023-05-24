import {Entity} from "../../../kernel/types";

export type User = Entity<number> & {
    name: string,
    lastname: string,
    email: string,
    password:string,
    status: boolean,
    role: Role
}

export enum Role {
    Administrator,Director,Assistant
}

