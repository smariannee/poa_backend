export type GetProcessDto = {
    id: number,
    process: string,
    process_number: string,
    sheet_number: string,
    status: string,
}

export type SaveProcessDto = {
    process: string,
    process_number: string,
}

export type UpdateProcessDto = {
    id: number,
    process: string,
    process_number: string,

}

export type UpdateStatusProcessDto = {
    id: number,
    status: boolean

}