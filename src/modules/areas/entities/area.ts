import {Entity} from "../../../kernel/types";
import {UserEntity} from "../boundary";

export type Area = Entity<number> & {
    area: string,
    status: boolean,
    director: UserEntity
    assistant: UserEntity
}
