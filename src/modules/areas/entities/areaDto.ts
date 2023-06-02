export type GetAreaDto = {
    id?:number,
    title: string,
    abbreviation: string,
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
    title: string,
    abbreviation: string,
    director?: number,
    assistant?: number,
}


export type UpdateAreaDto = {
    id?: number,
    title: string,
    abbreviation: string,
    director: number,
    assistant: number,
}

export type UpdateStatusAreaDto = {
    id: number,
    status: boolean,

}

