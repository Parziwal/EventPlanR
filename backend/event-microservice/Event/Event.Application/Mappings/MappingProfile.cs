using AutoMapper;
using Event.Application.Dto;
using Entities = Event.Domain.Entities;

namespace Event.Application.Mappings;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<Entities.Event, EventDto>()
            .ForMember(dto => dto.Venue, opt => opt.MapFrom(src => src.Address.Venue));
        CreateMap<Entities.Event, EventDetailsDto>();
        CreateMap<Entities.EventAddress, EventAddressDto>()
            .ForMember(dto => dto.Longitude, opt => opt.MapFrom(src => src.Location.X))
            .ForMember(dto => dto.Latitude, opt => opt.MapFrom(src => src.Location.Y));
    }
}
