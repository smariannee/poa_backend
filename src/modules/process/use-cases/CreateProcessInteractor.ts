import {UseCase} from "../../../kernel/contracts";
import {SaveProcessDto} from "../entities/processDto";
import {Process} from "../entities/process";
import {ProcessRepository} from "./port/process.repository";


export class CreateProcessInteractor implements UseCase<SaveProcessDto, Process> {
    constructor(private readonly processRepository: ProcessRepository) {
    }
    async execute(payload: SaveProcessDto): Promise<Process> {
        return this.processRepository.create(payload)
    }
}
