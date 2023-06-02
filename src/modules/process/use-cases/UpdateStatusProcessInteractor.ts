import {UseCase} from "../../../kernel/contracts";
import {Process} from "../entities/process";
import {ProcessRepository} from "./port/process.repository";
import {UpdateStatusProcessDto} from "../entities/processDto";

export class UpdateStatusProcessInteractor implements UseCase<UpdateStatusProcessDto, Process> {
    constructor(private readonly areaRepository: ProcessRepository) {
    }
    execute(user:UpdateStatusProcessDto): Promise<Process> {
        return this.areaRepository.updateStatus(user);
    }
}
