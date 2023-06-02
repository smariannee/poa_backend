import {Entity} from "../../../kernel/types";

export type Process = Entity<number> & {
    process: string,
    process_number: string,
    sheet_number: string,
    status: string,
}