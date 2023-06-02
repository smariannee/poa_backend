import {Process} from "../../entities/process";
import {SaveProcessDto, UpdateProcessDto, UpdateStatusProcessDto} from "../../entities/processDto";

export interface ProcessRepository {
    findAll(): Promise<Process[]>
    findById(id: number): Promise<Process>;
    create(process: SaveProcessDto): Promise<Process>;
    update(process: UpdateProcessDto): Promise<Process>;
    updateStatus(process:UpdateStatusProcessDto): Promise<Process>;
    existByName(name: string): Promise<boolean>;
}