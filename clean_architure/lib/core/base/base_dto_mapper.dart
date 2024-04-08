abstract class BaseDTOMapper<DTO, ENTITY> {
  DTO mapToDTO(ENTITY entity);

  ENTITY mapToEntity(DTO dto);

  List<ENTITY> mapToEntities(List<DTO>? dTOs) {
    var models = <ENTITY>[];
    if (dTOs != null) {
      for (var it in dTOs) {
        ENTITY entity = mapToEntity(it);
        models.add(entity);
      }
    }
    return models;
  }

  List<DTO> mapToDTOs(List<ENTITY>? entities) {
    var dTOs = <DTO>[];
    if (entities != null) {
      for (var it in entities) {
        dTOs.add(mapToDTO(it));
      }
    }
    return dTOs;
  }
}
