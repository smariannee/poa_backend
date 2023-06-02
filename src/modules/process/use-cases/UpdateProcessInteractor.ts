import {UseCase} from "../../../kernel/contracts";
import {Process} from "../entities/process";
import {UpdateProcessDto} from "../entities/processDto";
import {ProcessRepository} from "./port/process.repository";

export class UpdateProcessInteractor implements UseCase<UpdateProcessDto, Process> {
    constructor(private readonly areaRepository: ProcessRepository) {
    }

    execute(payload: UpdateProcessDto): Promise<Process> {
        return this.areaRepository.update(payload)
    }
}

