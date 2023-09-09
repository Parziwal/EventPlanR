using EventPlanR.Application.Dto.Common;
using EventPlanR.Application.Dto.Event;
using EventPlanR.Domain.Entities;

namespace EventPlanR.Application.Mappings;

public static class EventMapperExtensions
{
    public static EventDto ToEventDto(this Event eventEntity) => new EventDto()
    {
        Id = eventEntity.Id,
        Name = eventEntity.Name,
        FromDate = eventEntity.FromDate,
        Category = eventEntity.Category,
        Venue = eventEntity.Venue,
        CoverImageUrl = eventEntity.CoverImageUrl,
    };

    public static EventDetailsDto ToEventDetailsDto(this Event eventEntity) => new EventDetailsDto()
    {
        Id = eventEntity.Id,
        Name = eventEntity.Name,
        FromDate = eventEntity.FromDate,
        ToDate = eventEntity.ToDate,
        Category = eventEntity.Category,
        Description = eventEntity.Description,
        Venue =eventEntity.Venue,
        Address = new AddressDto()
        {
            City = eventEntity.Address.City,
            ZipCode = eventEntity.Address.ZipCode,
            Country = eventEntity.Address.Country,
            AddressLine = eventEntity.Address.AddressLine,
        },
        Coordinates = new CoordinatesDto()
        {
            Latitude = eventEntity.Coordinates.Latitude,
            Longitude = eventEntity.Coordinates.Longitude,
        },
        CoverImageUrl = eventEntity.CoverImageUrl,
    };
}
