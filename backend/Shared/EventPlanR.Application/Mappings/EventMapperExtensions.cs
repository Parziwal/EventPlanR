using EventPlanr.Application.Dto.Common;
using EventPlanr.Application.Dto.Event;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Mappings;

public static class EventMapperExtensions
{
    public static EventDto ToEventDto(this Event entity) => new EventDto()
    {
        Id = entity.Id,
        Name = entity.Name,
        FromDate = entity.FromDate,
        Category = entity.Category,
        Venue = entity.Venue,
        CoverImageUrl = entity.CoverImageUrl,
    };

    public static EventDetailsDto ToEventDetailsDto(this Event entity) => new EventDetailsDto()
    {
        Id = entity.Id,
        Name = entity.Name,
        FromDate = entity.FromDate,
        ToDate = entity.ToDate,
        Category = entity.Category,
        Description = entity.Description,
        Venue =entity.Venue,
        Address = new AddressDto()
        {
            City = entity.Address.City,
            ZipCode = entity.Address.ZipCode,
            Country = entity.Address.Country,
            AddressLine = entity.Address.AddressLine,
        },
        Coordinates = new CoordinatesDto()
        {
            Latitude = entity.Coordinates.Latitude,
            Longitude = entity.Coordinates.Longitude,
        },
        CoverImageUrl = entity.CoverImageUrl,
    };
}
