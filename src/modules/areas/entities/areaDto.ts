export type GetAreaDto = {
    id?:number,
    area: string,
    status: boolean,
    director?: {
        name: string,
        lastname: string,
        email: string,
        status: boolean,
        role: string,
    }
    assistant?:  {
        name: string,
        lastname: string,
        email: string,
        status: boolean,
        role: string,
    }
}

export type SaveAreaDto = {
    area: string,
    director?: number,
    assistant?: number,
}


export type UpdateAreaDto = {
    id?: number,
    area: string,
    director: number,
    assistant: number,
}

export type UpdateStatusAreaDto = {
    id: number,
    status: boolean,

}

