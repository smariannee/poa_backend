    import {UseCase} from "../../../kernel/contracts";
    import {Area} from "../entities/area";
    import {AreaRepository} from "./ports/area.repository";
    export class GetAreaInteractor implements UseCase<number, Area> {
        constructor(private readonly areaRepository: AreaRepository) {
        }
        execute(id: number): Promise<Area> {
            return this.areaRepository.findById(id);
        }
    }
