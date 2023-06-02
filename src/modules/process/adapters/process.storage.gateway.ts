import {ProcessRepository} from "../use-cases/port/process.repository";
import {SaveProcessDto, UpdateProcessDto, UpdateStatusProcessDto} from "../entities/processDto";
import {Process} from "../entities/process";

export class ProcessStorageGateway implements ProcessRepository{
    create(process: SaveProcessDto): Promise<Process> {
        throw Error ('Not implement')
    }

    existByName(name: string): Promise<boolean> {
        throw Error ('Not implement')
    }

    findAll(): Promise<Process[]> {
        throw Error ('Not implement')
    }

    findById(id: number): Promise<Process> {
        throw Error ('Not implement')
    }

    update(process: UpdateProcessDto): Promise<Process> {
        throw Error ('Not implement')
    }

    updateStatus(process: UpdateStatusProcessDto): Promise<Process> {
        throw Error ('Not implement')
    }

}