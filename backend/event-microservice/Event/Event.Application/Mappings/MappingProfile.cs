using AutoMapper;
using Event.Application.Dto;
using Entities = Event.Domain.Entities;

namespace Event.Application.Mappings;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<Entities.Event, EventDto>();
    }
}
