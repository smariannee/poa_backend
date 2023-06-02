
/**
 * Only use specify data
 * Each one in a file
 */
export type GetUserDto = {
    id?:number,
    name: string,
    lastname: string,
    email: string,
    phone_number: string,
    extension_number: string,
    status: boolean,
    role:  string
    password?: string,
}

export type SaveUserDto = {
    name: string,
    lastname: string,
    email: string,
    phone_number: string,
    extension_number: string,
    password: string,
    role:  string
}

export type UpdateUserDto = {

    id: number,
    name: string,
    lastname: string,
    email: string,
    phone_number: string,
    extension_number: string,
    password: string,
    role:  string
}

export type UpdateStatusUserDto = {
    id: number,
    status: boolean,

}