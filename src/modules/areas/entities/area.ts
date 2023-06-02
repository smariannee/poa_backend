import {Entity} from "../../../kernel/types";
import {UserEntity} from "../boundary";

export type Area = Entity<number> & {
    title: string,
    abbreviation: string,
    status: boolean,
    director: UserEntity
    assistant: UserEntity
}
