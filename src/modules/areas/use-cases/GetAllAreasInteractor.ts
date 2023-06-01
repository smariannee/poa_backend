import {UseCase} from "../../../kernel/contracts";
import {Area} from "../entities/area";
import {AreaRepository} from "./ports/area.repository";

export class GetAllAreasInteractor implements UseCase<void, Area[]> {
    constructor(private readonly areaRepository: AreaRepository) {
    }
    execute(): Promise<Area[]> {
        return this.areaRepository.findAll()
    }
}
